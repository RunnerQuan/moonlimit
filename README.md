# MoonLimit

MoonLimit is a composable rate limiting toolkit for MoonBit. It provides pure
algorithmic limiters that can be embedded in CLIs, async services, task queues,
API gateways, and tests without depending on a specific runtime.

## Planned Algorithms

- Token bucket for burst-friendly quotas.
- Leaky bucket for smooth draining.
- Fixed window counters for simple quotas.
- Sliding window counters for reduced boundary spikes.
- GCRA for precise arrival-time based throttling.
- Keyed limiter wrappers for per-user or per-resource limits.

## Development

```powershell
moon check
moon test
moon run cmd/main
```

This project is being built for the MoonBit open source contest. The goal is a
small, well-tested, reusable infrastructure library rather than a full gateway or
distributed rate limiting service.
