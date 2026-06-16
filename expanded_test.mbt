test "duration parser accepts common units" {
  inspect(@moonlimit.Duration::parse("100ms").millis(), content="100")
  inspect(@moonlimit.Duration::parse("5s").millis(), content="5000")
  inspect(@moonlimit.Duration::parse("2m").millis(), content="120000")
  inspect(@moonlimit.Duration::parse("1h").millis(), content="3600000")
}

test "rate parser converts per second and per minute" {
  let fast = @moonlimit.Rate::parse("10/s")
  inspect(fast.events(), content="10")
  inspect(fast.period_ms(), content="1000")
  let slow = @moonlimit.Rate::parse("120/min")
  inspect(slow.events(), content="120")
  inspect(slow.period_ms(), content="60000")
}

test "sliding log keeps exact timestamps in window" {
  let limiter = @moonlimit.SlidingLog::new(2, 1000)
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(500).is_allowed(), content="true")
  inspect(limiter.allow_at(999).is_allowed(), content="false")
  inspect(limiter.allow_at(1000).is_allowed(), content="true")
}

test "concurrency limiter releases permits" {
  let limiter = @moonlimit.ConcurrencyLimiter::new(2)
  inspect(limiter.acquire().is_allowed(), content="true")
  inspect(limiter.acquire().is_allowed(), content="true")
  inspect(limiter.acquire().is_allowed(), content="false")
  inspect(limiter.release(), content="true")
  inspect(limiter.acquire().is_allowed(), content="true")
}

test "composite limiter requires all children by default" {
  let limiter = @moonlimit.CompositeLimiter::all()
  limiter.add_token_bucket(1, 1, 1000)
  limiter.add_fixed_window(10, 1000)
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="false")
}

test "limit spec parser builds token bucket" {
  let spec = @moonlimit.LimitSpec::parse("token_bucket api 3 1 1000")
  inspect(spec.name(), content="api")
  let limiter = spec.to_token_bucket()
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="false")
}

test "simulator records allowed and rejected totals" {
  let limiter = @moonlimit.TokenBucket::new(1, 1, 1000)
  let workload = @moonlimit.Workload::burst(3, 0)
  let report = @moonlimit.Simulator::run_token_bucket(limiter, workload)
  inspect(report.allowed(), content="1")
  inspect(report.rejected(), content="2")
  inspect(report.total(), content="3")
}
