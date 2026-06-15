# MoonLimit Design

## Goal

MoonLimit provides a pure MoonBit rate limiting library with reusable algorithms,
clear decisions, deterministic testing, and a small CLI demonstration. It targets
application authors who need in-process throttling for API calls, task queues,
batch jobs, command-line tools, and async workflows.

## Scope

The contest version implements local in-memory rate limiting only. It does not
include HTTP middleware, distributed coordination, Redis storage, or a long-lived
scheduler daemon. Those integrations can be layered on top of the core API later.

## Public Model

All limiters return a `Decision` instead of a raw boolean. Allowed decisions
include the remaining capacity where that concept is available. Rejected
decisions include a retry delay and a reason string so callers can explain and
test behavior.

Time is represented as monotonic milliseconds. Limiters accept timestamps from
callers instead of reading wall-clock time internally, which keeps the library
portable across MoonBit backends and easy to test.

## Algorithms

The initial library contains five independent limiters:

- Token bucket for burst-tolerant quotas.
- Leaky bucket for smooth queue-like draining.
- Fixed window counters for simple quota windows.
- Sliding window counters for less bursty window boundaries.
- GCRA for precise arrival-time based rate control.

A keyed wrapper stores one limiter state per key and exposes pruning helpers so
applications can bound memory usage.

## Package Layout

- Root package: public types, limiters, keyed wrapper, and tests.
- `cmd/main`: runnable demonstration that prints decisions for a sample request
  stream.
- `docs/superpowers`: design and implementation planning notes.
- `.github/workflows`: CI that installs MoonBit and runs check/test.

## Error Handling

Constructors validate non-positive capacities, periods, and rates by falling back
to safe minimums where reasonable. Runtime rejections are normal results rather
than exceptions. The library avoids panics in ordinary use.

## Testing

Tests cover boundary timing, burst behavior, retry delay calculation, keyed state
isolation, and deterministic examples. The CLI is intentionally small and exists
only to make manual inspection and contest demos convenient.
