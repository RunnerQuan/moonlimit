///|
pub(all) struct SlidingLog {
  limit : Int
  window_ms : Int
  mut events : Array[Int]
} derive(Debug)

///|
pub fn SlidingLog::new(limit : Int, window_ms : Int) -> SlidingLog {
  SlidingLog::{
    limit: positive(limit, 1),
    window_ms: positive(window_ms, 1),
    events: [],
  }
}

///|
fn SlidingLog::prune(self : SlidingLog, now_ms : Int) -> Unit {
  let cutoff = now_ms - self.window_ms
  while self.events.length() > 0 && self.events[0] <= cutoff {
    ignore(self.events.remove(0))
  }
}

///|
pub fn SlidingLog::allow_at(
  self : SlidingLog,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.prune(now_ms)
  if self.events.length() + need <= self.limit {
    for _ in 0..<need {
      self.events.push(now_ms)
    }
    Allowed({ remaining: self.limit - self.events.length(), reset_after_ms: 0 })
  } else {
    let retry = if self.events.length() == 0 {
      self.window_ms
    } else {
      clamp_non_negative(self.events[0] + self.window_ms - now_ms)
    }
    Rejected({ retry_after_ms: retry, reason: "sliding log limit exceeded" })
  }
}

///|
pub fn SlidingLog::len(self : SlidingLog) -> Int {
  self.events.length()
}

///|
pub(all) struct ConcurrencyLimiter {
  capacity : Int
  mut in_flight : Int
} derive(Debug)

///|
pub fn ConcurrencyLimiter::new(capacity : Int) -> ConcurrencyLimiter {
  ConcurrencyLimiter::{ capacity: positive(capacity, 1), in_flight: 0 }
}

///|
pub fn ConcurrencyLimiter::acquire(self : ConcurrencyLimiter) -> Decision {
  if self.in_flight < self.capacity {
    self.in_flight = self.in_flight + 1
    Allowed({ remaining: self.capacity - self.in_flight, reset_after_ms: 0 })
  } else {
    Rejected({ retry_after_ms: 0, reason: "concurrency limit exceeded" })
  }
}

///|
pub fn ConcurrencyLimiter::release(self : ConcurrencyLimiter) -> Bool {
  if self.in_flight > 0 {
    self.in_flight = self.in_flight - 1
    true
  } else {
    false
  }
}

///|
pub fn ConcurrencyLimiter::in_use(self : ConcurrencyLimiter) -> Int {
  self.in_flight
}

///|
pub(all) struct CompositeLimiter {
  mut token_buckets : Array[TokenBucket]
  mut fixed_windows : Array[FixedWindow]
} derive(Debug)

///|
pub fn CompositeLimiter::all() -> CompositeLimiter {
  CompositeLimiter::{ token_buckets: [], fixed_windows: [] }
}

///|
pub fn CompositeLimiter::add_token_bucket(
  self : CompositeLimiter,
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
) -> Unit {
  self.token_buckets.push(
    TokenBucket::new(capacity, refill_tokens, refill_period_ms),
  )
}

///|
pub fn CompositeLimiter::add_fixed_window(
  self : CompositeLimiter,
  limit : Int,
  window_ms : Int,
) -> Unit {
  self.fixed_windows.push(FixedWindow::new(limit, window_ms))
}

///|
pub fn CompositeLimiter::allow_at(
  self : CompositeLimiter,
  now_ms : Int,
) -> Decision {
  for bucket in self.token_buckets {
    let decision = bucket.allow_at(now_ms)
    if !decision.is_allowed() {
      return decision
    }
  }
  for window in self.fixed_windows {
    let decision = window.allow_at(now_ms)
    if !decision.is_allowed() {
      return decision
    }
  }
  Allowed({ remaining: 0, reset_after_ms: 0 })
}
