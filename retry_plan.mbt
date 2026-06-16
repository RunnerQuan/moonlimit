pub(all) struct RetryAdvice {
  should_retry : Bool
  wait_ms : Int
  message : String
} derive(Eq, Debug)

pub fn RetryAdvice::from_decision(decision : Decision) -> RetryAdvice {
  if decision.is_allowed() {
    RetryAdvice::{
      should_retry: false,
      wait_ms: 0,
      message: "request accepted",
    }
  } else {
    RetryAdvice::{
      should_retry: true,
      wait_ms: decision.retry_after_ms(),
      message: "retry after \{decision.retry_after_ms()}ms",
    }
  }
}

pub fn RetryAdvice::should_retry(self : RetryAdvice) -> Bool {
  self.should_retry
}

pub fn RetryAdvice::wait_ms(self : RetryAdvice) -> Int {
  self.wait_ms
}

pub fn RetryAdvice::message(self : RetryAdvice) -> String {
  self.message
}

pub(all) struct RetrySchedule {
  base_ms : Int
  max_ms : Int
  factor : Int
} derive(Eq, Debug)

pub fn RetrySchedule::exponential(
  base_ms : Int,
  max_ms : Int,
  factor? : Int = 2,
) -> RetrySchedule {
  RetrySchedule::{
    base_ms: positive(base_ms, 1),
    max_ms: positive(max_ms, 1),
    factor: positive(factor, 1),
  }
}

pub fn RetrySchedule::delay_at(self : RetrySchedule, attempt : Int) -> Int {
  let mut delay = self.base_ms
  for _ in 0..<clamp_non_negative(attempt) {
    delay = delay * self.factor
    if delay >= self.max_ms {
      return self.max_ms
    }
  }
  if delay > self.max_ms { self.max_ms } else { delay }
}

pub fn RetrySchedule::delays(self : RetrySchedule, attempts : Int) -> Array[Int] {
  let values : Array[Int] = []
  for i in 0..<positive(attempts, 1) {
    values.push(self.delay_at(i))
  }
  values
}

pub fn RetrySchedule::describe(self : RetrySchedule, attempts : Int) -> String {
  let values = self.delays(attempts)
  let mut out = "retry"
  for value in values {
    out = out + " " + value.to_string() + "ms"
  }
  out
}

pub fn Decision::explain(self : Decision) -> String {
  match self {
    Allowed(info) =>
      "allowed remaining=\{info.remaining} reset_after_ms=\{info.reset_after_ms}"
    Rejected(info) =>
      "rejected retry_after_ms=\{info.retry_after_ms} reason=\{info.reason}"
  }
}

pub fn LimitSpec::explain(self : LimitSpec) -> String {
  match self.kind {
    TokenBucket =>
      "token_bucket \{self.spec_name}: capacity=\{self.first} refill=\{self.second}/\{self.third}ms"
    FixedWindow =>
      "fixed_window \{self.spec_name}: limit=\{self.first} window=\{self.second}ms"
    SlidingLog =>
      "sliding_log \{self.spec_name}: limit=\{self.first} window=\{self.second}ms"
    GcraSpec =>
      "gcra \{self.spec_name}: limit=\{self.first} period=\{self.second}ms burst=\{self.third}"
  }
}
