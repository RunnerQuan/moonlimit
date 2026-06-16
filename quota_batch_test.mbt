///|
test "warmup token bucket starts small and grows capacity" {
  let bucket = @moonlimit.WarmupTokenBucket::new(10, 10, 1000, 10000)
  inspect(bucket.capacity_at(0), content="1")
  inspect(bucket.capacity_at(5000), content="5")
  inspect(bucket.capacity_at(10000), content="10")
}

///|
test "warmup token bucket rejects before refill arrives" {
  let bucket = @moonlimit.WarmupTokenBucket::new(10, 1, 1000, 10000)
  inspect(bucket.allow_at(0).is_allowed(), content="false")
  inspect(bucket.allow_at(1000).is_allowed(), content="true")
}

///|
test "quota window tracks long period quota" {
  let quota = @moonlimit.QuotaWindow::new(3, 86400000)
  inspect(quota.allow_at(0, cost=2).is_allowed(), content="true")
  inspect(quota.remaining_quota(), content="1")
  inspect(quota.allow_at(1, cost=2).is_allowed(), content="false")
  inspect(quota.allow_at(86400000, cost=3).is_allowed(), content="true")
}

///|
test "batch token bucket evaluates deterministic sequence" {
  let batch = @moonlimit.BatchTokenBucket::new(2, 1, 1000).allow_many([
    0, 0, 0, 1000,
  ])
  inspect(batch.len(), content="4")
  inspect(batch.allowed(), content="3")
  inspect(batch.rejected(), content="1")
  inspect(batch.all_allowed(), content="false")
}

///|
test "batch decision exposes maximum retry" {
  let batch = @moonlimit.BatchDecision::new()
  batch.push(@moonlimit.Decision::Rejected({ retry_after_ms: 50, reason: "a" }))
  batch.push(
    @moonlimit.Decision::Rejected({ retry_after_ms: 150, reason: "b" }),
  )
  inspect(batch.max_retry_after_ms(), content="150")
}

///|
test "decision stats records retry averages" {
  let stats = @moonlimit.DecisionStats::new()
  stats.record(
    @moonlimit.Decision::Allowed({ remaining: 1, reset_after_ms: 0 }),
  )
  stats.record(
    @moonlimit.Decision::Rejected({ retry_after_ms: 100, reason: "a" }),
  )
  stats.record(
    @moonlimit.Decision::Rejected({ retry_after_ms: 300, reason: "b" }),
  )
  inspect(stats.allowed(), content="1")
  inspect(stats.rejected(), content="2")
  inspect(stats.average_retry_after_ms(), content="200")
  inspect(
    stats.summary(),
    content="allowed=1 rejected=2 avg_retry_ms=200 max_retry_ms=300",
  )
}
