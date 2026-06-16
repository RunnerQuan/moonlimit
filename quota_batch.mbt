pub(all) struct WarmupTokenBucket {
  capacity : Int
  refill_tokens : Int
  refill_period_ms : Int
  warmup_ms : Int
  start_ms : Int
  mut tokens : Int
  mut last_refill_ms : Int
} derive(Debug)

pub fn WarmupTokenBucket::new(
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
  warmup_ms : Int,
  start_ms? : Int = 0,
) -> WarmupTokenBucket {
  WarmupTokenBucket::{
    capacity: positive(capacity, 1),
    refill_tokens: positive(refill_tokens, 1),
    refill_period_ms: positive(refill_period_ms, 1),
    warmup_ms: positive(warmup_ms, 1),
    start_ms,
    tokens: 0,
    last_refill_ms: start_ms,
  }
}

fn WarmupTokenBucket::current_capacity(self : WarmupTokenBucket, now_ms : Int) -> Int {
  let elapsed = clamp_non_negative(now_ms - self.start_ms)
  if elapsed >= self.warmup_ms {
    self.capacity
  } else {
    positive(self.capacity * elapsed / self.warmup_ms, 1)
  }
}

fn WarmupTokenBucket::refill(self : WarmupTokenBucket, now_ms : Int) -> Unit {
  let elapsed = now_ms - self.last_refill_ms
  if elapsed <= 0 {
    return
  }
  let gained = elapsed * self.refill_tokens / self.refill_period_ms
  if gained > 0 {
    let cap = self.current_capacity(now_ms)
    self.tokens = if self.tokens + gained > cap {
      cap
    } else {
      self.tokens + gained
    }
    self.last_refill_ms = now_ms
  }
}

pub fn WarmupTokenBucket::allow_at(
  self : WarmupTokenBucket,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.refill(now_ms)
  if self.tokens >= need {
    self.tokens = self.tokens - need
    Allowed({
      remaining: self.tokens,
      reset_after_ms: 0,
    })
  } else {
    let missing = need - self.tokens
    Rejected({
      retry_after_ms: ceil_div(missing * self.refill_period_ms, self.refill_tokens),
      reason: "warmup token bucket exhausted",
    })
  }
}

pub fn WarmupTokenBucket::capacity_at(
  self : WarmupTokenBucket,
  now_ms : Int,
) -> Int {
  self.current_capacity(now_ms)
}

pub(all) struct QuotaWindow {
  quota : Int
  period_ms : Int
  mut window_start_ms : Int
  mut used : Int
} derive(Debug)

pub fn QuotaWindow::new(
  quota : Int,
  period_ms : Int,
  start_ms? : Int = 0,
) -> QuotaWindow {
  QuotaWindow::{
    quota: positive(quota, 1),
    period_ms: positive(period_ms, 1),
    window_start_ms: start_ms,
    used: 0,
  }
}

fn QuotaWindow::roll(self : QuotaWindow, now_ms : Int) -> Unit {
  if now_ms >= self.window_start_ms + self.period_ms {
    let elapsed = now_ms - self.window_start_ms
    let periods = positive(elapsed / self.period_ms, 1)
    self.window_start_ms = self.window_start_ms + periods * self.period_ms
    self.used = 0
  }
}

pub fn QuotaWindow::allow_at(
  self : QuotaWindow,
  now_ms : Int,
  cost? : Int = 1,
) -> Decision {
  let need = positive(cost, 1)
  self.roll(now_ms)
  if self.used + need <= self.quota {
    self.used = self.used + need
    Allowed({
      remaining: self.quota - self.used,
      reset_after_ms: self.window_start_ms + self.period_ms - now_ms,
    })
  } else {
    Rejected({
      retry_after_ms: self.window_start_ms + self.period_ms - now_ms,
      reason: "quota exhausted",
    })
  }
}

pub fn QuotaWindow::used(self : QuotaWindow) -> Int {
  self.used
}

pub fn QuotaWindow::remaining_quota(self : QuotaWindow) -> Int {
  self.quota - self.used
}

pub(all) struct BatchDecision {
  mut decisions : Array[Decision]
} derive(Debug)

pub fn BatchDecision::new() -> BatchDecision {
  BatchDecision::{ decisions: [] }
}

pub fn BatchDecision::push(self : BatchDecision, decision : Decision) -> Unit {
  self.decisions.push(decision)
}

pub fn BatchDecision::len(self : BatchDecision) -> Int {
  self.decisions.length()
}

pub fn BatchDecision::allowed(self : BatchDecision) -> Int {
  let mut count = 0
  for decision in self.decisions {
    if decision.is_allowed() {
      count = count + 1
    }
  }
  count
}

pub fn BatchDecision::rejected(self : BatchDecision) -> Int {
  self.len() - self.allowed()
}

pub fn BatchDecision::all_allowed(self : BatchDecision) -> Bool {
  self.rejected() == 0
}

pub fn BatchDecision::max_retry_after_ms(self : BatchDecision) -> Int {
  let mut value = 0
  for decision in self.decisions {
    if decision.retry_after_ms() > value {
      value = decision.retry_after_ms()
    }
  }
  value
}

pub(all) struct BatchTokenBucket {
  bucket : TokenBucket
} derive(Debug)

pub fn BatchTokenBucket::new(
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
) -> BatchTokenBucket {
  BatchTokenBucket::{ bucket: TokenBucket::new(capacity, refill_tokens, refill_period_ms) }
}

pub fn BatchTokenBucket::allow_many(
  self : BatchTokenBucket,
  times : Array[Int],
) -> BatchDecision {
  let batch = BatchDecision::new()
  for now_ms in times {
    batch.push(self.bucket.allow_at(now_ms))
  }
  batch
}

pub(all) struct DecisionStats {
  mut allowed_count : Int
  mut rejected_count : Int
  mut retry_after_total_ms : Int
  mut retry_after_max_ms : Int
} derive(Debug)

pub fn DecisionStats::new() -> DecisionStats {
  DecisionStats::{
    allowed_count: 0,
    rejected_count: 0,
    retry_after_total_ms: 0,
    retry_after_max_ms: 0,
  }
}

pub fn DecisionStats::record(self : DecisionStats, decision : Decision) -> Unit {
  if decision.is_allowed() {
    self.allowed_count = self.allowed_count + 1
  } else {
    self.rejected_count = self.rejected_count + 1
    let retry = decision.retry_after_ms()
    self.retry_after_total_ms = self.retry_after_total_ms + retry
    if retry > self.retry_after_max_ms {
      self.retry_after_max_ms = retry
    }
  }
}

pub fn DecisionStats::allowed(self : DecisionStats) -> Int {
  self.allowed_count
}

pub fn DecisionStats::rejected(self : DecisionStats) -> Int {
  self.rejected_count
}

pub fn DecisionStats::total(self : DecisionStats) -> Int {
  self.allowed_count + self.rejected_count
}

pub fn DecisionStats::max_retry_after_ms(self : DecisionStats) -> Int {
  self.retry_after_max_ms
}

pub fn DecisionStats::average_retry_after_ms(self : DecisionStats) -> Int {
  if self.rejected_count == 0 {
    0
  } else {
    self.retry_after_total_ms / self.rejected_count
  }
}

pub fn DecisionStats::summary(self : DecisionStats) -> String {
  "allowed=\{self.allowed()} rejected=\{self.rejected()} avg_retry_ms=\{self.average_retry_after_ms()} max_retry_ms=\{self.max_retry_after_ms()}"
}
