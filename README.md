# MoonLimit

MoonLimit is a composable rate limiting toolkit for MoonBit. It provides pure
algorithmic limiters that can be embedded in CLIs, async services, task queues,
API gateways, and tests without depending on a specific runtime.

## Algorithms

- Token bucket for burst-friendly quotas.
- Leaky bucket for smooth draining.
- Fixed window counters for simple quotas.
- Sliding window counters for reduced boundary spikes.
- Sliding log for exact timestamp-based windows.
- GCRA for precise arrival-time based throttling.
- Warmup token bucket for gradual rollout.
- Quota window for long-period product or billing limits.
- Concurrency limiter for in-flight work protection.
- Keyed limiter wrappers for per-user or per-resource limits.
- Policy engine for all-of / any-of rule composition.
- Workload simulation and cookbook recipes for demos and tuning.

## Example

```moonbit
fn main {
  let limiter = @moonlimit.TokenBucket::new(2, 1, 1000)
  let first = limiter.allow_at(0)
  let second = limiter.allow_at(0)
  let third = limiter.allow_at(0)

  inspect(first.is_allowed(), content="true")
  inspect(second.is_allowed(), content="true")
  inspect(third.retry_after_ms(), content="1000")
}
```

## Public API Shape

Limiters return `Decision` values:

- `Allowed({ remaining, reset_after_ms })`
- `Rejected({ retry_after_ms, reason })`

Callers pass monotonic milliseconds into `allow_at`, so the algorithms are
deterministic in tests and portable across MoonBit backends.

## Non-goals

MoonLimit is not a web framework, API gateway, Redis integration, or distributed
quota service. It intentionally stays focused on the reusable rate limiting core.

## Development

```powershell
moon check
moon test
moon run cmd/main
```

## Current Contest Readiness

- MoonBit source scale: over 4k effective nonblank, noncomment lines.
- Test suite: 237 tests covering algorithms, keyed variants, policy engines,
  configuration parsing, workloads, cookbook recipes, and regression matrices.
- CI: GitHub Actions runs `moon check`, `moon test`, and the CLI demo.
- License: Apache-2.0.

This project is being built for the MoonBit open source contest. The goal is a
small, well-tested, reusable infrastructure library rather than a full gateway or
distributed rate limiting service.
