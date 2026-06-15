/// Successful admission details returned by a limiter.
pub(all) struct AllowInfo {
  remaining : Int
  reset_after_ms : Int
} derive(Eq, Debug)

/// Rejection details returned by a limiter.
pub(all) struct RejectInfo {
  retry_after_ms : Int
  reason : String
} derive(Eq, Debug)

/// Rate limiter decision with enough context for logs, tests, and clients.
pub(all) enum Decision {
  Allowed(AllowInfo)
  Rejected(RejectInfo)
} derive(Eq, Debug)

pub fn Decision::is_allowed(self : Decision) -> Bool {
  match self {
    Allowed(_) => true
    Rejected(_) => false
  }
}

pub fn Decision::retry_after_ms(self : Decision) -> Int {
  match self {
    Allowed(_) => 0
    Rejected(info) => info.retry_after_ms
  }
}

pub fn Decision::remaining(self : Decision) -> Int {
  match self {
    Allowed(info) => info.remaining
    Rejected(_) => 0
  }
}

pub fn Decision::reset_after_ms(self : Decision) -> Int {
  match self {
    Allowed(info) => info.reset_after_ms
    Rejected(_) => 0
  }
}

fn positive(value : Int, fallback : Int) -> Int {
  if value > 0 { value } else { fallback }
}

pub fn ceil_div(numerator : Int, denominator : Int) -> Int {
  let d = positive(denominator, 1)
  if numerator <= 0 { 0 } else { (numerator + d - 1) / d }
}

pub fn clamp_non_negative(value : Int) -> Int {
  if value < 0 { 0 } else { value }
}

pub(all) struct TokenBucket {
  capacity : Int
  refill_tokens : Int
  refill_period_ms : Int
  mut tokens : Int
  mut last_refill_ms : Int
} derive(Debug)

pub fn TokenBucket::new(
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
  start_ms? : Int = 0,
) -> TokenBucket {
  let cap = positive(capacity, 1)
  TokenBucket::{
    capacity: cap,
    refill_tokens: positive(refill_tokens, 1),
    refill_period_ms: positive(refill_period_ms, 1),
    tokens: cap,
    last_refill_ms: start_ms,
  }
}

fn TokenBucket::refill(self : TokenBucket, now_ms : Int) -> Unit {
  let elapsed = now_ms - self.last_refill_ms
  if elapsed <= 0 {
    return
  }
  let gained = elapsed * self.refill_tokens / self.refill_period_ms
  if gained > 0 {
    self.tokens = if self.tokens + gained > self.capacity {
      self.capacity
    } else {
      self.tokens + gained
    }
    self.last_refill_ms = now_ms
  }
}

pub fn TokenBucket::allow_at(
  self : TokenBucket,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.refill(now_ms)
  if self.tokens >= need {
    self.tokens = self.tokens - need
    Allowed({
      remaining: self.tokens,
      reset_after_ms: 0,
    })
  } else {
    let missing = need - self.tokens
    let retry = ceil_div(missing * self.refill_period_ms, self.refill_tokens)
    Rejected({
      retry_after_ms: retry,
      reason: "token bucket exhausted",
    })
  }
}

pub(all) struct LeakyBucket {
  capacity : Int
  leak_tokens : Int
  leak_period_ms : Int
  mut level : Int
  mut last_leak_ms : Int
} derive(Debug)

pub fn LeakyBucket::new(
  capacity : Int,
  leak_tokens : Int,
  leak_period_ms : Int,
  start_ms? : Int = 0,
) -> LeakyBucket {
  LeakyBucket::{
    capacity: positive(capacity, 1),
    leak_tokens: positive(leak_tokens, 1),
    leak_period_ms: positive(leak_period_ms, 1),
    level: 0,
    last_leak_ms: start_ms,
  }
}

fn LeakyBucket::drain(self : LeakyBucket, now_ms : Int) -> Unit {
  let elapsed = now_ms - self.last_leak_ms
  if elapsed <= 0 {
    return
  }
  let leaked = elapsed * self.leak_tokens / self.leak_period_ms
  if leaked > 0 {
    self.level = clamp_non_negative(self.level - leaked)
    self.last_leak_ms = now_ms
  }
}

pub fn LeakyBucket::allow_at(
  self : LeakyBucket,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.drain(now_ms)
  if self.level + need <= self.capacity {
    self.level = self.level + need
    Allowed({
      remaining: self.capacity - self.level,
      reset_after_ms: 0,
    })
  } else {
    let overflow = self.level + need - self.capacity
    Rejected({
      retry_after_ms: ceil_div(overflow * self.leak_period_ms, self.leak_tokens),
      reason: "leaky bucket full",
    })
  }
}

pub(all) struct FixedWindow {
  limit : Int
  window_ms : Int
  mut window_start_ms : Int
  mut used : Int
} derive(Debug)

pub fn FixedWindow::new(
  limit : Int,
  window_ms : Int,
  start_ms? : Int = 0,
) -> FixedWindow {
  FixedWindow::{
    limit: positive(limit, 1),
    window_ms: positive(window_ms, 1),
    window_start_ms: start_ms,
    used: 0,
  }
}

fn FixedWindow::roll(self : FixedWindow, now_ms : Int) -> Unit {
  if now_ms >= self.window_start_ms + self.window_ms {
    let elapsed = now_ms - self.window_start_ms
    let windows = positive(elapsed / self.window_ms, 1)
    self.window_start_ms = self.window_start_ms + windows * self.window_ms
    self.used = 0
  }
}

pub fn FixedWindow::allow_at(
  self : FixedWindow,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.roll(now_ms)
  if self.used + need <= self.limit {
    self.used = self.used + need
    Allowed({
      remaining: self.limit - self.used,
      reset_after_ms: self.window_start_ms + self.window_ms - now_ms,
    })
  } else {
    Rejected({
      retry_after_ms: self.window_start_ms + self.window_ms - now_ms,
      reason: "fixed window limit exceeded",
    })
  }
}

pub(all) struct SlidingWindow {
  limit : Int
  window_ms : Int
  mut window_start_ms : Int
  mut current_count : Int
  mut previous_count : Int
} derive(Debug)

pub fn SlidingWindow::new(
  limit : Int,
  window_ms : Int,
  start_ms? : Int = 0,
) -> SlidingWindow {
  SlidingWindow::{
    limit: positive(limit, 1),
    window_ms: positive(window_ms, 1),
    window_start_ms: start_ms,
    current_count: 0,
    previous_count: 0,
  }
}

fn SlidingWindow::roll(self : SlidingWindow, now_ms : Int) -> Unit {
  if now_ms < self.window_start_ms + self.window_ms {
    return
  }
  let elapsed = now_ms - self.window_start_ms
  let windows = positive(elapsed / self.window_ms, 1)
  if windows == 1 {
    self.previous_count = self.current_count
  } else {
    self.previous_count = 0
  }
  self.current_count = 0
  self.window_start_ms = self.window_start_ms + windows * self.window_ms
}

fn SlidingWindow::estimated(self : SlidingWindow, now_ms : Int) -> Int {
  let elapsed = clamp_non_negative(now_ms - self.window_start_ms)
  let remaining = clamp_non_negative(self.window_ms - elapsed)
  self.current_count + ceil_div(self.previous_count * remaining, self.window_ms)
}

pub fn SlidingWindow::allow_at(
  self : SlidingWindow,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.roll(now_ms)
  let estimate = self.estimated(now_ms)
  if estimate + need <= self.limit {
    self.current_count = self.current_count + need
    Allowed({
      remaining: self.limit - estimate - need,
      reset_after_ms: self.window_start_ms + self.window_ms - now_ms,
    })
  } else {
    Rejected({
      retry_after_ms: self.window_start_ms + self.window_ms - now_ms,
      reason: "sliding window limit exceeded",
    })
  }
}

pub(all) struct Gcra {
  interval_ms : Int
  burst_capacity : Int
  mut theoretical_arrival_ms : Int
} derive(Debug)

pub fn Gcra::new(
  limit : Int,
  period_ms : Int,
  burst_capacity? : Int = 1,
  start_ms? : Int = 0,
) -> Gcra {
  let safe_limit = positive(limit, 1)
  Gcra::{
    interval_ms: positive(positive(period_ms, 1) / safe_limit, 1),
    burst_capacity: positive(burst_capacity, 1),
    theoretical_arrival_ms: start_ms,
  }
}

pub fn Gcra::allow_at(
  self : Gcra,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  let tolerance = (self.burst_capacity - 1) * self.interval_ms
  let earliest = self.theoretical_arrival_ms - tolerance
  if now_ms < earliest {
    Rejected({
      retry_after_ms: earliest - now_ms,
      reason: "gcra limit exceeded",
    })
  } else {
    let base = if now_ms > self.theoretical_arrival_ms {
      now_ms
    } else {
      self.theoretical_arrival_ms
    }
    self.theoretical_arrival_ms = base + need * self.interval_ms
    let next_earliest = self.theoretical_arrival_ms - tolerance
    Allowed({
      remaining: 0,
      reset_after_ms: clamp_non_negative(next_earliest - now_ms),
    })
  }
}
