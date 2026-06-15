# MoonLimit

Composable rate limiting algorithms for MoonBit applications.

MoonLimit currently includes token bucket, leaky bucket, fixed window, sliding
window, GCRA, and keyed token bucket limiters.

```moonbit
let limiter = @moonlimit.TokenBucket::new(2, 1, 1000)
let decision = limiter.allow_at(0)
inspect(decision.is_allowed(), content="true")
```
