/// Successful admission details returned by a limiter.
pub(all) struct AllowInfo {
  remaining : Int
  reset_after_ms : Int
} derive(Eq, Debug)

/// Rejection details returned by a limiter.
pub(all) struct RejectInfo {
  retry_after_ms : Int
  reason : String
} derive(Eq, Debug)

/// Rate limiter decision with enough context for logs, tests, and clients.
pub(all) enum Decision {
  Allowed(AllowInfo)
  Rejected(RejectInfo)
} derive(Eq, Debug)

pub fn Decision::is_allowed(self : Decision) -> Bool {
  match self {
    Allowed(_) => true
    Rejected(_) => false
  }
}

pub fn Decision::retry_after_ms(self : Decision) -> Int {
  match self {
    Allowed(_) => 0
    Rejected(info) => info.retry_after_ms
  }
}

pub fn Decision::remaining(self : Decision) -> Int {
  match self {
    Allowed(info) => info.remaining
    Rejected(_) => 0
  }
}

fn positive(value : Int, fallback : Int) -> Int {
  if value > 0 { value } else { fallback }
}

pub fn ceil_div(numerator : Int, denominator : Int) -> Int {
  let d = positive(denominator, 1)
  if numerator <= 0 { 0 } else { (numerator + d - 1) / d }
}

pub fn clamp_non_negative(value : Int) -> Int {
  if value < 0 { 0 } else { value }
}
