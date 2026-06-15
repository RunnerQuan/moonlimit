# MoonLimit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a tested MoonBit rate limiting library with five algorithms, keyed limiting, docs, CI, and a CLI demo.

**Architecture:** Keep the public API in the root package so consumers can import one module. Each limiter owns its state and accepts monotonic millisecond timestamps from callers for deterministic behavior.

**Tech Stack:** MoonBit 0.1.20260608, MoonBit built-in tests, GitHub Actions, PowerShell-compatible developer commands.

---

### Task 1: Project Metadata

**Files:**
- Modify: `moon.mod`
- Create: `README.md`
- Create: `docs/superpowers/specs/2026-06-15-moonlimit-design.md`

- [x] Add package metadata, contest-oriented README, and the approved design.
- [x] Run `moon check`.
- [x] Commit as `docs: add moonlimit project design`.

### Task 2: Public Decision Types

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Add monotonic time aliases, `Decision`, `AllowInfo`, and `RejectInfo`.
- [ ] Test helper predicates for allowed and rejected results.
- [ ] Commit as `feat: define limiter decision model`.

### Task 3: Token Bucket

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement token bucket state, refill, and `allow_at`.
- [ ] Test burst capacity and retry timing.
- [ ] Commit as `feat: add token bucket limiter`.

### Task 4: Leaky Bucket

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement leaky bucket drain and queue admission.
- [ ] Test smoothing and full-bucket rejection.
- [ ] Commit as `feat: add leaky bucket limiter`.

### Task 5: Fixed Window

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement fixed window counters.
- [ ] Test window reset behavior.
- [ ] Commit as `feat: add fixed window limiter`.

### Task 6: Sliding Window

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement weighted previous-window estimation.
- [ ] Test boundary smoothing.
- [ ] Commit as `feat: add sliding window limiter`.

### Task 7: GCRA

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement GCRA theoretical arrival time tracking.
- [ ] Test burst tolerance and retry delay.
- [ ] Commit as `feat: add gcra limiter`.

### Task 8: Keyed Limiter

**Files:**
- Modify: `moonlimit.mbt`
- Modify: `moonlimit_test.mbt`

- [ ] Implement keyed token bucket wrapper and pruning.
- [ ] Test key isolation and stale state removal.
- [ ] Commit as `feat: add keyed token bucket limiter`.

### Task 9: CLI Demo

**Files:**
- Modify: `cmd/main/moon.pkg`
- Modify: `cmd/main/main.mbt`

- [ ] Import the root library and print a deterministic sample trace.
- [ ] Run `moon run cmd/main`.
- [ ] Commit as `feat: add moonlimit cli demo`.

### Task 10: CI and Documentation Polish

**Files:**
- Modify: `.github/workflows/ci.yml`
- Modify: `README.md`
- Modify: `README.mbt.md`

- [ ] Add CI check/test workflow.
- [ ] Document each algorithm and example usage.
- [ ] Commit as `docs: complete contest ready documentation`.
