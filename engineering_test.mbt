///|
test "keyed fixed window isolates keys and prunes" {
  let limiter = @moonlimit.KeyedFixedWindow::new(1, 1000)
  inspect(limiter.allow_at("alice", 0).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 0).is_allowed(), content="false")
  inspect(limiter.allow_at("bob", 0).is_allowed(), content="true")
  inspect(limiter.len(), content="2")
  inspect(limiter.prune_idle(2000, 1000), content="2")
  inspect(limiter.len(), content="0")
}

///|
test "keyed sliding log isolates exact windows" {
  let limiter = @moonlimit.KeyedSlidingLog::new(2, 1000)
  inspect(limiter.allow_at("alice", 0).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 500).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 999).is_allowed(), content="false")
  inspect(limiter.allow_at("bob", 999).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 1000).is_allowed(), content="true")
}

///|
test "keyed gcra keeps independent theoretical arrival times" {
  let limiter = @moonlimit.KeyedGcra::new(1, 1000, burst_capacity=1)
  inspect(limiter.allow_at("alice", 0).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 999).is_allowed(), content="false")
  inspect(limiter.allow_at("bob", 999).is_allowed(), content="true")
  inspect(limiter.allow_at("alice", 1000).is_allowed(), content="true")
}

///|
test "keyed concurrency tracks in flight by key" {
  let limiter = @moonlimit.KeyedConcurrencyLimiter::new(1)
  inspect(limiter.acquire("alice").is_allowed(), content="true")
  inspect(limiter.acquire("alice").is_allowed(), content="false")
  inspect(limiter.acquire("bob").is_allowed(), content="true")
  inspect(limiter.in_use("alice"), content="1")
  inspect(limiter.release("alice"), content="true")
  inspect(limiter.acquire("alice").is_allowed(), content="true")
}

///|
test "limit spec validation reports warnings" {
  let spec = @moonlimit.LimitSpec::token_bucket("tiny", 1, 3, 1000)
  let report = spec.validate()
  inspect(report.is_ok(), content="true")
  inspect(report.warning_count(), content="1")
  inspect(report.summary(), content="errors=0 warnings=1 issues=1")
}

///|
test "rule set parses multiple lines and ignores comments" {
  let rules = @moonlimit.RuleSet::parse_lines(
    "# sample\n" +
    "token_bucket api 5 1 1000\n" +
    "fixed_window login 3 60000\n" +
    "sliding_log search 10 1000\n",
  )
  inspect(rules.len(), content="3")
  inspect(rules.validate().is_ok(), content="true")
}

///|
test "workload ramp gets denser over time" {
  let workload = @moonlimit.Workload::ramp(4, 0, 100, 25)
  inspect(workload.len(), content="4")
  inspect(workload.first_at(), content="0")
  inspect(workload.last_at(), content="225")
}

///|
test "workload alternating keys records range" {
  let workload = @moonlimit.Workload::alternating_keys(4, 10, 5, "a", "b")
  inspect(workload.describe(), content="events=4 first=10 last=25")
}

///|
test "workload repeat and shift compose traces" {
  let base = @moonlimit.Workload::steady(2, 0, 100)
  let repeated = base.repeat(3, 1000).shift(50)
  inspect(repeated.len(), content="6")
  inspect(repeated.first_at(), content="50")
  inspect(repeated.last_at(), content="2150")
}

///|
test "simulation report exposes ratios and summary" {
  let limiter = @moonlimit.FixedWindow::new(1, 1000)
  let report = @moonlimit.Simulator::run_fixed_window(
    limiter,
    @moonlimit.Workload::burst(4, 0),
  )
  inspect(report.allowed_per_thousand(), content="250")
  inspect(report.rejected_per_thousand(), content="750")
  inspect(
    report.summary_line(),
    content="total=4 allowed=1 rejected=3 max_retry_ms=1000",
  )
}
