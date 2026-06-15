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
