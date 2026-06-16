test "policy engine all rejects when first rule rejects" {
  let engine = @moonlimit.PolicyEngine::all()
  engine.add_token_bucket("burst", 1, 1, 1000)
  engine.add_fixed_window("window", 10, 1000)
  inspect(engine.allow_at(0).is_allowed(), content="true")
  inspect(engine.allow_at(0).is_allowed(), content="false")
}

test "policy engine any accepts through fallback rule" {
  let engine = @moonlimit.PolicyEngine::any()
  engine.add_token_bucket("strict", 1, 1, 1000)
  engine.add_fixed_window("fallback", 10, 1000)
  inspect(engine.allow_at(0).is_allowed(), content="true")
  inspect(engine.allow_at(0).is_allowed(), content="true")
}

test "policy engine describes named rules" {
  let engine = @moonlimit.PolicyEngine::all()
  engine.add_token_bucket("api", 2, 1, 1000)
  engine.add_sliding_log("search", 10, 1000)
  inspect(engine.describe(), content="mode=all rules=2 api:token_bucket search:sliding_log")
}

test "policy engine can simulate workload" {
  let engine = @moonlimit.PolicyEngine::all()
  engine.add_fixed_window("tiny", 1, 1000)
  let report = engine.simulate(@moonlimit.Workload::burst(3, 0))
  inspect(report.allowed(), content="1")
  inspect(report.rejected(), content="2")
}

test "retry advice explains decisions" {
  let rejected = @moonlimit.Decision::Rejected({
    retry_after_ms: 42,
    reason: "limited",
  })
  let advice = @moonlimit.RetryAdvice::from_decision(rejected)
  inspect(advice.should_retry(), content="true")
  inspect(advice.wait_ms(), content="42")
  inspect(advice.message(), content="retry after 42ms")
}

test "retry schedule caps exponential delay" {
  let schedule = @moonlimit.RetrySchedule::exponential(100, 500)
  inspect(schedule.delay_at(0), content="100")
  inspect(schedule.delay_at(1), content="200")
  inspect(schedule.delay_at(2), content="400")
  inspect(schedule.delay_at(3), content="500")
  inspect(schedule.describe(4), content="retry 100ms 200ms 400ms 500ms")
}

test "decision explain produces readable text" {
  let decision = @moonlimit.Decision::Allowed({
    remaining: 2,
    reset_after_ms: 0,
  })
  inspect(decision.explain(), content="allowed remaining=2 reset_after_ms=0")
}

test "limit spec explain documents parameters" {
  let spec = @moonlimit.LimitSpec::token_bucket("api", 10, 1, 1000)
  inspect(
    spec.explain(),
    content="token_bucket api: capacity=10 refill=1/1000ms",
  )
}
