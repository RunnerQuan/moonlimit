# MoonLimit

Composable rate limiting algorithms for MoonBit applications.

MoonLimit currently includes token bucket, leaky bucket, fixed window, sliding
window, sliding log, GCRA, warmup token bucket, quota window, concurrency,
keyed variants, policy engines, simulation helpers, and cookbook recipes.

```moonbit nocheck
let limiter = @moonlimit.TokenBucket::new(2, 1, 1000)
let decision = limiter.allow_at(0)
inspect(decision.is_allowed(), content="true")
```
