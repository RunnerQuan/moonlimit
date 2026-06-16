pub fn Workload::push(
  self : Workload,
  at_ms : Int,
  cost? : Int = 1,
  key? : String = "",
) -> Unit {
  self.events.push({
    at_ms,
    cost: positive(cost, 1),
    key,
  })
}

pub fn Workload::ramp(
  count : Int,
  start_ms : Int,
  initial_step_ms : Int,
  decrement_ms : Int,
) -> Workload {
  let workload = Workload::new()
  let mut now = start_ms
  let mut step = positive(initial_step_ms, 1)
  for _ in 0..<positive(count, 1) {
    workload.push(now)
    now = now + step
    step = positive(step - clamp_non_negative(decrement_ms), 1)
  }
  workload
}

pub fn Workload::alternating_keys(
  count : Int,
  start_ms : Int,
  step_ms : Int,
  left : String,
  right : String,
) -> Workload {
  let workload = Workload::new()
  for i in 0..<positive(count, 1) {
    let key = if i % 2 == 0 { left } else { right }
    workload.push(start_ms + i * positive(step_ms, 1), key=key)
  }
  workload
}

pub fn Workload::shift(self : Workload, delta_ms : Int) -> Workload {
  let shifted = Workload::new()
  for event in self.events {
    shifted.push(event.at_ms + delta_ms, cost=event.cost, key=event.key)
  }
  shifted
}

pub fn Workload::repeat(self : Workload, times : Int, spacing_ms : Int) -> Workload {
  let repeated = Workload::new()
  let safe_times = positive(times, 1)
  let safe_spacing = positive(spacing_ms, 1)
  for round in 0..<safe_times {
    for event in self.events {
      repeated.push(
        event.at_ms + round * safe_spacing,
        cost=event.cost,
        key=event.key,
      )
    }
  }
  repeated
}

pub fn Workload::merge(left : Workload, right : Workload) -> Workload {
  let merged = Workload::new()
  for event in left.events {
    merged.push(event.at_ms, cost=event.cost, key=event.key)
  }
  for event in right.events {
    merged.push(event.at_ms, cost=event.cost, key=event.key)
  }
  merged
}

pub fn Workload::first_at(self : Workload) -> Int {
  if self.events.length() == 0 {
    0
  } else {
    let mut value = self.events[0].at_ms
    for event in self.events {
      if event.at_ms < value {
        value = event.at_ms
      }
    }
    value
  }
}

pub fn Workload::last_at(self : Workload) -> Int {
  if self.events.length() == 0 {
    0
  } else {
    let mut value = self.events[0].at_ms
    for event in self.events {
      if event.at_ms > value {
        value = event.at_ms
      }
    }
    value
  }
}

pub fn Workload::describe(self : Workload) -> String {
  "events=\{self.len()} first=\{self.first_at()} last=\{self.last_at()}"
}

pub fn SimulationReport::allowed_per_thousand(self : SimulationReport) -> Int {
  if self.total() == 0 {
    0
  } else {
    self.allowed() * 1000 / self.total()
  }
}

pub fn SimulationReport::rejected_per_thousand(self : SimulationReport) -> Int {
  if self.total() == 0 {
    0
  } else {
    self.rejected() * 1000 / self.total()
  }
}

pub fn SimulationReport::max_retry_after_ms(self : SimulationReport) -> Int {
  let mut value = 0
  for entry in self.trace {
    let retry = entry.decision.retry_after_ms()
    if retry > value {
      value = retry
    }
  }
  value
}

pub fn SimulationReport::summary_line(self : SimulationReport) -> String {
  "total=\{self.total()} allowed=\{self.allowed()} rejected=\{self.rejected()} max_retry_ms=\{self.max_retry_after_ms()}"
}
