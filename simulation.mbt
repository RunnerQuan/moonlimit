pub(all) struct RequestEvent {
  at_ms : Int
  cost : Int
  key : String
} derive(Eq, Debug)

pub(all) struct Workload {
  events : Array[RequestEvent]
} derive(Debug)

pub fn Workload::new() -> Workload {
  Workload::{ events: [] }
}

pub fn Workload::burst(count : Int, at_ms : Int) -> Workload {
  let workload = Workload::new()
  for _ in 0..<positive(count, 1) {
    workload.events.push({
      at_ms,
      cost: 1,
      key: "",
    })
  }
  workload
}

pub fn Workload::steady(count : Int, start_ms : Int, step_ms : Int) -> Workload {
  let workload = Workload::new()
  for i in 0..<positive(count, 1) {
    workload.events.push({
      at_ms: start_ms + i * positive(step_ms, 1),
      cost: 1,
      key: "",
    })
  }
  workload
}

pub fn Workload::len(self : Workload) -> Int {
  self.events.length()
}

pub(all) struct TraceEntry {
  at_ms : Int
  decision : Decision
} derive(Debug)

pub(all) struct SimulationReport {
  mut trace : Array[TraceEntry]
  mut allowed_count : Int
  mut rejected_count : Int
} derive(Debug)

pub fn SimulationReport::new() -> SimulationReport {
  SimulationReport::{ trace: [], allowed_count: 0, rejected_count: 0 }
}

pub fn SimulationReport::record(
  self : SimulationReport,
  at_ms : Int,
  decision : Decision,
) -> Unit {
  self.trace.push({ at_ms, decision })
  if decision.is_allowed() {
    self.allowed_count = self.allowed_count + 1
  } else {
    self.rejected_count = self.rejected_count + 1
  }
}

pub fn SimulationReport::allowed(self : SimulationReport) -> Int {
  self.allowed_count
}

pub fn SimulationReport::rejected(self : SimulationReport) -> Int {
  self.rejected_count
}

pub fn SimulationReport::total(self : SimulationReport) -> Int {
  self.allowed_count + self.rejected_count
}

pub fn SimulationReport::csv(self : SimulationReport) -> String {
  let mut out = "time_ms,allowed,retry_after_ms\n"
  for entry in self.trace {
    out = out +
      "\{entry.at_ms},\{entry.decision.is_allowed()},\{entry.decision.retry_after_ms()}\n"
  }
  out
}

pub(all) struct Simulator {
}

pub fn Simulator::run_token_bucket(
  limiter : TokenBucket,
  workload : Workload,
) -> SimulationReport {
  let report = SimulationReport::new()
  for event in workload.events {
    report.record(event.at_ms, limiter.allow_at(event.at_ms, cost=event.cost))
  }
  report
}

pub fn Simulator::run_fixed_window(
  limiter : FixedWindow,
  workload : Workload,
) -> SimulationReport {
  let report = SimulationReport::new()
  for event in workload.events {
    report.record(event.at_ms, limiter.allow_at(event.at_ms, cost=event.cost))
  }
  report
}
