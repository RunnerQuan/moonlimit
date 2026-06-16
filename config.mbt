pub(all) enum LimitKind {
  TokenBucket
  FixedWindow
  SlidingLog
  GcraSpec
} derive(Eq, Debug)

pub(all) struct LimitSpec {
  kind : LimitKind
  spec_name : String
  first : Int
  second : Int
  third : Int
} derive(Eq, Debug)

pub fn LimitSpec::token_bucket(
  name : String,
  capacity : Int,
  refill_tokens : Int,
  refill_period_ms : Int,
) -> LimitSpec {
  LimitSpec::{
    kind: TokenBucket,
    spec_name: name,
    first: positive(capacity, 1),
    second: positive(refill_tokens, 1),
    third: positive(refill_period_ms, 1),
  }
}

pub fn LimitSpec::fixed_window(
  name : String,
  limit : Int,
  window_ms : Int,
) -> LimitSpec {
  LimitSpec::{
    kind: FixedWindow,
    spec_name: name,
    first: positive(limit, 1),
    second: positive(window_ms, 1),
    third: 0,
  }
}

pub fn LimitSpec::sliding_log(
  name : String,
  limit : Int,
  window_ms : Int,
) -> LimitSpec {
  LimitSpec::{
    kind: SlidingLog,
    spec_name: name,
    first: positive(limit, 1),
    second: positive(window_ms, 1),
    third: 0,
  }
}

pub fn LimitSpec::name(self : LimitSpec) -> String {
  self.spec_name
}

pub fn LimitSpec::parse(text : String) -> LimitSpec {
  let words = split_words(text)
  if words.length() >= 5 && words[0] == "token_bucket" {
    LimitSpec::token_bucket(
      words[1],
      parse_positive_prefix(words[2]),
      parse_positive_prefix(words[3]),
      parse_positive_prefix(words[4]),
    )
  } else if words.length() >= 4 && words[0] == "fixed_window" {
    LimitSpec::fixed_window(
      words[1],
      parse_positive_prefix(words[2]),
      parse_positive_prefix(words[3]),
    )
  } else if words.length() >= 4 && words[0] == "sliding_log" {
    LimitSpec::sliding_log(
      words[1],
      parse_positive_prefix(words[2]),
      parse_positive_prefix(words[3]),
    )
  } else {
    LimitSpec::token_bucket("default", 1, 1, 1000)
  }
}

pub fn LimitSpec::to_token_bucket(self : LimitSpec) -> TokenBucket {
  match self.kind {
    TokenBucket => TokenBucket::new(self.first, self.second, self.third)
    _ => TokenBucket::new(1, 1, 1000)
  }
}

pub fn LimitSpec::to_fixed_window(self : LimitSpec) -> FixedWindow {
  match self.kind {
    FixedWindow => FixedWindow::new(self.first, self.second)
    _ => FixedWindow::new(1, 1000)
  }
}

pub fn LimitSpec::to_sliding_log(self : LimitSpec) -> SlidingLog {
  match self.kind {
    SlidingLog => SlidingLog::new(self.first, self.second)
    _ => SlidingLog::new(1, 1000)
  }
}
