pub(all) struct Duration {
  value_ms : Int
} derive(Eq, Debug)

pub fn Duration::from_millis(value_ms : Int) -> Duration {
  Duration::{ value_ms: clamp_non_negative(value_ms) }
}

pub fn Duration::millis(self : Duration) -> Int {
  self.value_ms
}

pub fn Duration::seconds(self : Duration) -> Int {
  self.value_ms / 1000
}

pub fn Duration::parse(text : String) -> Duration {
  let value = parse_positive_prefix(text)
  if ends_with(text, "ms") {
    Duration::from_millis(value)
  } else if ends_with(text, "s") {
    Duration::from_millis(value * 1000)
  } else if ends_with(text, "m") {
    Duration::from_millis(value * 60 * 1000)
  } else if ends_with(text, "h") {
    Duration::from_millis(value * 60 * 60 * 1000)
  } else {
    Duration::from_millis(value)
  }
}

pub(all) struct Rate {
  count : Int
  period : Duration
} derive(Eq, Debug)

pub fn Rate::new(count : Int, period : Duration) -> Rate {
  Rate::{ count: positive(count, 1), period }
}

pub fn Rate::events(self : Rate) -> Int {
  self.count
}

pub fn Rate::period_ms(self : Rate) -> Int {
  self.period.millis()
}

pub fn Rate::parse(text : String) -> Rate {
  let count = parse_positive_prefix(text)
  if ends_with(text, "/ms") {
    Rate::new(count, Duration::from_millis(1))
  } else if ends_with(text, "/s") {
    Rate::new(count, Duration::from_millis(1000))
  } else if ends_with(text, "/min") {
    Rate::new(count, Duration::from_millis(60000))
  } else if ends_with(text, "/h") {
    Rate::new(count, Duration::from_millis(3600000))
  } else {
    Rate::new(count, Duration::from_millis(1000))
  }
}

fn ends_with(text : String, suffix : String) -> Bool {
  let text_len = text.length()
  let suffix_len = suffix.length()
  if suffix_len > text_len {
    false
  } else {
    text[text_len - suffix_len:text_len] == suffix
  }
}

fn is_digit(ch : UInt16) -> Bool {
  ch.to_int() >= '0'.to_int() && ch.to_int() <= '9'.to_int()
}

fn parse_positive_prefix(text : String) -> Int {
  let mut value = 0
  let mut seen = false
  for i in 0..<text.length() {
    let ch = text.unsafe_get(i)
    if is_digit(ch) {
      seen = true
      value = value * 10 + ch.to_int() - '0'.to_int()
    } else {
      break
    }
  }
  if seen { positive(value, 1) } else { 1 }
}

fn split_words(text : String) -> Array[String] {
  let words : Array[String] = []
  let mut start = -1
  for i in 0..<text.length() {
    let ch = text.unsafe_get(i)
    if ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r' {
      if start >= 0 {
        words.push(text[start:i].to_owned())
        start = -1
      }
    } else if start < 0 {
      start = i
    }
  }
  if start >= 0 {
    words.push(text[start:text.length()].to_owned())
  }
  words
}
