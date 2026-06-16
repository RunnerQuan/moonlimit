pub(all) enum AdmissionMode {
  AllOf
  AnyOf
} derive(Eq, Debug)

pub(all) struct EngineRule {
  rule_name : String
  kind : LimitKind
  token_bucket : TokenBucket
  fixed_window : FixedWindow
  sliding_log : SlidingLog
  quota_window : QuotaWindow
} derive(Debug)

pub fn EngineRule::token_bucket(
  name : String,
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
) -> EngineRule {
  EngineRule::{
    rule_name: name,
    kind: TokenBucket,
    token_bucket: TokenBucket::new(capacity, refill_tokens, refill_period_ms),
    fixed_window: FixedWindow::new(1, 1000),
    sliding_log: SlidingLog::new(1, 1000),
    quota_window: QuotaWindow::new(1, 1000),
  }
}

pub fn EngineRule::fixed_window(
  name : String,
  limit : Int,
  window_ms : Int,
) -> EngineRule {
  EngineRule::{
    rule_name: name,
    kind: FixedWindow,
    token_bucket: TokenBucket::new(1, 1, 1000),
    fixed_window: FixedWindow::new(limit, window_ms),
    sliding_log: SlidingLog::new(1, 1000),
    quota_window: QuotaWindow::new(1, 1000),
  }
}

pub fn EngineRule::sliding_log(
  name : String,
  limit : Int,
  window_ms : Int,
) -> EngineRule {
  EngineRule::{
    rule_name: name,
    kind: SlidingLog,
    token_bucket: TokenBucket::new(1, 1, 1000),
    fixed_window: FixedWindow::new(1, 1000),
    sliding_log: SlidingLog::new(limit, window_ms),
    quota_window: QuotaWindow::new(1, 1000),
  }
}

pub fn EngineRule::quota(
  name : String,
  quota : Int,
  period_ms : Int,
) -> EngineRule {
  EngineRule::{
    rule_name: name,
    kind: GcraSpec,
    token_bucket: TokenBucket::new(1, 1, 1000),
    fixed_window: FixedWindow::new(1, 1000),
    sliding_log: SlidingLog::new(1, 1000),
    quota_window: QuotaWindow::new(quota, period_ms),
  }
}

pub fn EngineRule::name(self : EngineRule) -> String {
  self.rule_name
}

pub fn EngineRule::allow_at(
  self : EngineRule,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  match self.kind {
    TokenBucket => self.token_bucket.allow_at(now_ms, cost~)
    FixedWindow => self.fixed_window.allow_at(now_ms, cost~)
    SlidingLog => self.sliding_log.allow_at(now_ms, cost~)
    GcraSpec => self.quota_window.allow_at(now_ms, cost~)
  }
}

pub fn EngineRule::describe(self : EngineRule) -> String {
  "\{self.rule_name}:\{self.kind_name()}"
}

pub fn EngineRule::kind_name(self : EngineRule) -> String {
  match self.kind {
    TokenBucket => "token_bucket"
    FixedWindow => "fixed_window"
    SlidingLog => "sliding_log"
    GcraSpec => "quota"
  }
}

pub(all) struct PolicyEngine {
  mode : AdmissionMode
  mut rules : Array[EngineRule]
} derive(Debug)

pub fn PolicyEngine::all() -> PolicyEngine {
  PolicyEngine::{ mode: AllOf, rules: [] }
}

pub fn PolicyEngine::any() -> PolicyEngine {
  PolicyEngine::{ mode: AnyOf, rules: [] }
}

pub fn PolicyEngine::add_rule(self : PolicyEngine, rule : EngineRule) -> Unit {
  self.rules.push(rule)
}

pub fn PolicyEngine::add_token_bucket(
  self : PolicyEngine,
  name : String,
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
) -> Unit {
  self.add_rule(EngineRule::token_bucket(name, capacity, refill_tokens, refill_period_ms))
}

pub fn PolicyEngine::add_fixed_window(
  self : PolicyEngine,
  name : String,
  limit : Int,
  window_ms : Int,
) -> Unit {
  self.add_rule(EngineRule::fixed_window(name, limit, window_ms))
}

pub fn PolicyEngine::add_sliding_log(
  self : PolicyEngine,
  name : String,
  limit : Int,
  window_ms : Int,
) -> Unit {
  self.add_rule(EngineRule::sliding_log(name, limit, window_ms))
}

pub fn PolicyEngine::add_quota(
  self : PolicyEngine,
  name : String,
  quota : Int,
  period_ms : Int,
) -> Unit {
  self.add_rule(EngineRule::quota(name, quota, period_ms))
}

pub fn PolicyEngine::len(self : PolicyEngine) -> Int {
  self.rules.length()
}

pub fn PolicyEngine::allow_at(
  self : PolicyEngine,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  if self.rules.length() == 0 {
    return Allowed({ remaining: 0, reset_after_ms: 0 })
  }
  match self.mode {
    AllOf => {
      for rule in self.rules {
        let decision = rule.allow_at(now_ms, cost~)
        if !decision.is_allowed() {
          return decision
        }
      }
      Allowed({ remaining: 0, reset_after_ms: 0 })
    }
    AnyOf => {
      let mut best_retry = 0
      for rule in self.rules {
        let decision = rule.allow_at(now_ms, cost~)
        if decision.is_allowed() {
          return decision
        }
        if decision.retry_after_ms() > best_retry {
          best_retry = decision.retry_after_ms()
        }
      }
      Rejected({ retry_after_ms: best_retry, reason: "all policy alternatives rejected" })
    }
  }
}

pub fn PolicyEngine::describe(self : PolicyEngine) -> String {
  let mode = match self.mode {
    AllOf => "all"
    AnyOf => "any"
  }
  let mut out = "mode=\{mode} rules=\{self.rules.length()}"
  for rule in self.rules {
    out = out + " " + rule.describe()
  }
  out
}

pub fn PolicyEngine::simulate(self : PolicyEngine, workload : Workload) -> SimulationReport {
  let report = SimulationReport::new()
  for event in workload.events {
    report.record(event.at_ms, self.allow_at(event.at_ms, cost=event.cost))
  }
  report
}
