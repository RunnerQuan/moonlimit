test "decision model reports allowed state" {
  let decision = @moonlimit.Decision::Allowed({
    remaining: 3,
    reset_after_ms: 1000,
  })
  inspect(decision.is_allowed(), content="true")
  inspect(decision.remaining(), content="3")
  inspect(decision.retry_after_ms(), content="0")
}

test "decision model reports rejected state" {
  let decision = @moonlimit.Decision::Rejected({
    retry_after_ms: 250,
    reason: "limited",
  })
  inspect(decision.is_allowed(), content="false")
  inspect(decision.remaining(), content="0")
  inspect(decision.retry_after_ms(), content="250")
}

test "token bucket allows initial burst then rejects" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  let rejected = bucket.allow_at(0)
  inspect(rejected.is_allowed(), content="false")
  inspect(rejected.retry_after_ms(), content="1000")
}

test "token bucket refills over time" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  ignore(bucket.allow_at(0))
  ignore(bucket.allow_at(0))
  inspect(bucket.allow_at(999).is_allowed(), content="false")
  let allowed = bucket.allow_at(1000)
  inspect(allowed.is_allowed(), content="true")
  inspect(allowed.remaining(), content="0")
}

test "leaky bucket admits until full" {
  let bucket = @moonlimit.LeakyBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  let rejected = bucket.allow_at(0)
  inspect(rejected.is_allowed(), content="false")
  inspect(rejected.retry_after_ms(), content="1000")
}

test "leaky bucket drains before next admission" {
  let bucket = @moonlimit.LeakyBucket::new(2, 1, 1000)
  ignore(bucket.allow_at(0))
  ignore(bucket.allow_at(0))
  inspect(bucket.allow_at(999).is_allowed(), content="false")
  let allowed = bucket.allow_at(1000)
  inspect(allowed.is_allowed(), content="true")
  inspect(allowed.remaining(), content="0")
}

test "fixed window rejects within a full window" {
  let limiter = @moonlimit.FixedWindow::new(2, 1000)
  inspect(limiter.allow_at(10).is_allowed(), content="true")
  inspect(limiter.allow_at(20).is_allowed(), content="true")
  let rejected = limiter.allow_at(30)
  inspect(rejected.is_allowed(), content="false")
  inspect(rejected.retry_after_ms(), content="970")
}

test "fixed window resets on next window" {
  let limiter = @moonlimit.FixedWindow::new(1, 1000)
  inspect(limiter.allow_at(999).is_allowed(), content="true")
  inspect(limiter.allow_at(999).is_allowed(), content="false")
  let allowed = limiter.allow_at(1000)
  inspect(allowed.is_allowed(), content="true")
  inspect(allowed.remaining(), content="0")
}

test "sliding window rejects weighted previous traffic" {
  let limiter = @moonlimit.SlidingWindow::new(2, 1000)
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  let rejected = limiter.allow_at(1000)
  inspect(rejected.is_allowed(), content="false")
  inspect(rejected.retry_after_ms(), content="1000")
}

test "sliding window allows after previous window weight decays" {
  let limiter = @moonlimit.SlidingWindow::new(2, 1000)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1499).is_allowed(), content="false")
  let allowed = limiter.allow_at(1500)
  inspect(allowed.is_allowed(), content="true")
  inspect(allowed.remaining(), content="0")
}

test "gcra allows configured burst then rejects" {
  let limiter = @moonlimit.Gcra::new(1, 1000, burst_capacity=2)
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  let rejected = limiter.allow_at(0)
  inspect(rejected.is_allowed(), content="false")
  inspect(rejected.retry_after_ms(), content="1000")
}

test "gcra admits once theoretical arrival catches up" {
  let limiter = @moonlimit.Gcra::new(1, 1000, burst_capacity=1)
  inspect(limiter.allow_at(0).is_allowed(), content="true")
  inspect(limiter.allow_at(999).is_allowed(), content="false")
  let allowed = limiter.allow_at(1000)
  inspect(allowed.is_allowed(), content="true")
  inspect(allowed.reset_after_ms(), content="1000")
}
