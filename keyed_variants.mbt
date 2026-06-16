///|
pub(all) struct KeyedFixedWindow {
  limit : Int
  window_ms : Int
  mut windows : @hashmap.HashMap[String, FixedWindow]
  mut last_seen : @hashmap.HashMap[String, Int]
} derive(Debug)

///|
pub fn KeyedFixedWindow::new(limit : Int, window_ms : Int) -> KeyedFixedWindow {
  KeyedFixedWindow::{
    limit: positive(limit, 1),
    window_ms: positive(window_ms, 1),
    windows: @hashmap.HashMap([]),
    last_seen: @hashmap.HashMap([]),
  }
}

///|
fn KeyedFixedWindow::window_for(
  self : KeyedFixedWindow,
  key : String,
  now_ms : Int,
) -> FixedWindow {
  match self.windows.get(key) {
    Some(window) => window
    None => {
      let window = FixedWindow::new(self.limit, self.window_ms, start_ms=now_ms)
      self.windows.set(key, window)
      window
    }
  }
}

///|
pub fn KeyedFixedWindow::allow_at(
  self : KeyedFixedWindow,
  key : String,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let window = self.window_for(key, now_ms)
  self.last_seen.set(key, now_ms)
  window.allow_at(now_ms, cost~)
}

///|
pub fn KeyedFixedWindow::len(self : KeyedFixedWindow) -> Int {
  self.windows.length()
}

///|
pub fn KeyedFixedWindow::prune_idle(
  self : KeyedFixedWindow,
  now_ms : Int,
  max_idle_ms : Int,
) -> Int {
  prune_string_maps(self.last_seen, self.windows, now_ms, max_idle_ms)
}

///|
pub(all) struct KeyedSlidingLog {
  limit : Int
  window_ms : Int
  mut logs : @hashmap.HashMap[String, SlidingLog]
  mut last_seen : @hashmap.HashMap[String, Int]
} derive(Debug)

///|
pub fn KeyedSlidingLog::new(limit : Int, window_ms : Int) -> KeyedSlidingLog {
  KeyedSlidingLog::{
    limit: positive(limit, 1),
    window_ms: positive(window_ms, 1),
    logs: @hashmap.HashMap([]),
    last_seen: @hashmap.HashMap([]),
  }
}

///|
fn KeyedSlidingLog::log_for(
  self : KeyedSlidingLog,
  key : String,
  _now_ms : Int,
) -> SlidingLog {
  match self.logs.get(key) {
    Some(log) => log
    None => {
      let log = SlidingLog::new(self.limit, self.window_ms)
      self.logs.set(key, log)
      log
    }
  }
}

///|
pub fn KeyedSlidingLog::allow_at(
  self : KeyedSlidingLog,
  key : String,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let log = self.log_for(key, now_ms)
  self.last_seen.set(key, now_ms)
  log.allow_at(now_ms, cost~)
}

///|
pub fn KeyedSlidingLog::len(self : KeyedSlidingLog) -> Int {
  self.logs.length()
}

///|
pub fn KeyedSlidingLog::prune_idle(
  self : KeyedSlidingLog,
  now_ms : Int,
  max_idle_ms : Int,
) -> Int {
  prune_string_maps(self.last_seen, self.logs, now_ms, max_idle_ms)
}

///|
pub(all) struct KeyedGcra {
  limit : Int
  period_ms : Int
  burst_capacity : Int
  mut states : @hashmap.HashMap[String, Gcra]
  mut last_seen : @hashmap.HashMap[String, Int]
} derive(Debug)

///|
pub fn KeyedGcra::new(
  limit : Int,
  period_ms : Int,
  burst_capacity? : Int = 1,
) -> KeyedGcra {
  KeyedGcra::{
    limit: positive(limit, 1),
    period_ms: positive(period_ms, 1),
    burst_capacity: positive(burst_capacity, 1),
    states: @hashmap.HashMap([]),
    last_seen: @hashmap.HashMap([]),
  }
}

///|
fn KeyedGcra::state_for(self : KeyedGcra, key : String, now_ms : Int) -> Gcra {
  match self.states.get(key) {
    Some(state) => state
    None => {
      let state = Gcra::new(
        self.limit,
        self.period_ms,
        burst_capacity=self.burst_capacity,
        start_ms=now_ms,
      )
      self.states.set(key, state)
      state
    }
  }
}

///|
pub fn KeyedGcra::allow_at(
  self : KeyedGcra,
  key : String,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let state = self.state_for(key, now_ms)
  self.last_seen.set(key, now_ms)
  state.allow_at(now_ms, cost~)
}

///|
pub fn KeyedGcra::len(self : KeyedGcra) -> Int {
  self.states.length()
}

///|
pub fn KeyedGcra::prune_idle(
  self : KeyedGcra,
  now_ms : Int,
  max_idle_ms : Int,
) -> Int {
  prune_string_maps(self.last_seen, self.states, now_ms, max_idle_ms)
}

///|
pub(all) struct KeyedConcurrencyLimiter {
  capacity : Int
  mut states : @hashmap.HashMap[String, ConcurrencyLimiter]
} derive(Debug)

///|
pub fn KeyedConcurrencyLimiter::new(capacity : Int) -> KeyedConcurrencyLimiter {
  KeyedConcurrencyLimiter::{
    capacity: positive(capacity, 1),
    states: @hashmap.HashMap([]),
  }
}

///|
fn KeyedConcurrencyLimiter::state_for(
  self : KeyedConcurrencyLimiter,
  key : String,
) -> ConcurrencyLimiter {
  match self.states.get(key) {
    Some(state) => state
    None => {
      let state = ConcurrencyLimiter::new(self.capacity)
      self.states.set(key, state)
      state
    }
  }
}

///|
pub fn KeyedConcurrencyLimiter::acquire(
  self : KeyedConcurrencyLimiter,
  key : String,
) -> Decision {
  self.state_for(key).acquire()
}

///|
pub fn KeyedConcurrencyLimiter::release(
  self : KeyedConcurrencyLimiter,
  key : String,
) -> Bool {
  match self.states.get(key) {
    Some(state) => state.release()
    None => false
  }
}

///|
pub fn KeyedConcurrencyLimiter::in_use(
  self : KeyedConcurrencyLimiter,
  key : String,
) -> Int {
  match self.states.get(key) {
    Some(state) => state.in_use()
    None => 0
  }
}

///|
pub fn KeyedConcurrencyLimiter::len(self : KeyedConcurrencyLimiter) -> Int {
  self.states.length()
}

///|
fn[V] prune_string_maps(
  last_seen : @hashmap.HashMap[String, Int],
  values : @hashmap.HashMap[String, V],
  now_ms : Int,
  max_idle_ms : Int,
) -> Int {
  let deadline = now_ms - positive(max_idle_ms, 1)
  let keys = last_seen.keys().to_array()
  let mut removed = 0
  for key in keys {
    match last_seen.get(key) {
      Some(last) =>
        if last < deadline {
          last_seen.remove(key)
          values.remove(key)
          removed = removed + 1
        }
      None => ()
    }
  }
  removed
}
