pub(all) enum Severity {
  Info
  Warning
  Error
} derive(Eq, Debug)

pub(all) struct ValidationIssue {
  severity : Severity
  field : String
  message : String
} derive(Eq, Debug)

pub fn ValidationIssue::error(field : String, message : String) -> ValidationIssue {
  ValidationIssue::{ severity: Error, field, message }
}

pub fn ValidationIssue::warning(field : String, message : String) -> ValidationIssue {
  ValidationIssue::{ severity: Warning, field, message }
}

pub fn ValidationIssue::info(field : String, message : String) -> ValidationIssue {
  ValidationIssue::{ severity: Info, field, message }
}

pub fn ValidationIssue::is_error(self : ValidationIssue) -> Bool {
  self.severity == Error
}

pub fn ValidationIssue::field(self : ValidationIssue) -> String {
  self.field
}

pub fn ValidationIssue::message(self : ValidationIssue) -> String {
  self.message
}

pub(all) struct ValidationReport {
  mut issues : Array[ValidationIssue]
} derive(Debug)

pub fn ValidationReport::new() -> ValidationReport {
  ValidationReport::{ issues: [] }
}

pub fn ValidationReport::push(self : ValidationReport, issue : ValidationIssue) -> Unit {
  self.issues.push(issue)
}

pub fn ValidationReport::len(self : ValidationReport) -> Int {
  self.issues.length()
}

pub fn ValidationReport::is_ok(self : ValidationReport) -> Bool {
  for issue in self.issues {
    if issue.is_error() {
      return false
    }
  }
  true
}

pub fn ValidationReport::error_count(self : ValidationReport) -> Int {
  let mut count = 0
  for issue in self.issues {
    if issue.is_error() {
      count = count + 1
    }
  }
  count
}

pub fn ValidationReport::warning_count(self : ValidationReport) -> Int {
  let mut count = 0
  for issue in self.issues {
    if issue.severity == Warning {
      count = count + 1
    }
  }
  count
}

pub fn ValidationReport::summary(self : ValidationReport) -> String {
  "errors=\{self.error_count()} warnings=\{self.warning_count()} issues=\{self.len()}"
}

pub fn LimitSpec::validate(self : LimitSpec) -> ValidationReport {
  let report = ValidationReport::new()
  if self.spec_name.length() == 0 {
    report.push(ValidationIssue::error("name", "name must not be empty"))
  }
  if self.first <= 0 {
    report.push(ValidationIssue::error("limit", "limit must be positive"))
  }
  if self.second <= 0 {
    report.push(ValidationIssue::error("period", "period must be positive"))
  }
  if self.kind == TokenBucket && self.third <= 0 {
    report.push(ValidationIssue::error("refill_period_ms", "refill period must be positive"))
  }
  if self.kind == TokenBucket && self.first < self.second {
    report.push(ValidationIssue::warning("capacity", "capacity is smaller than refill quantum"))
  }
  report
}

pub fn LimitSpec::kind_name(self : LimitSpec) -> String {
  match self.kind {
    TokenBucket => "token_bucket"
    FixedWindow => "fixed_window"
    SlidingLog => "sliding_log"
    GcraSpec => "gcra"
  }
}

pub(all) struct RuleSet {
  mut specs : Array[LimitSpec]
} derive(Debug)

pub fn RuleSet::new() -> RuleSet {
  RuleSet::{ specs: [] }
}

pub fn RuleSet::push(self : RuleSet, spec : LimitSpec) -> Unit {
  self.specs.push(spec)
}

pub fn RuleSet::len(self : RuleSet) -> Int {
  self.specs.length()
}

pub fn RuleSet::get(self : RuleSet, index : Int) -> LimitSpec? {
  self.specs.get(index)
}

pub fn RuleSet::validate(self : RuleSet) -> ValidationReport {
  let report = ValidationReport::new()
  if self.specs.length() == 0 {
    report.push(ValidationIssue::warning("rules", "rule set is empty"))
  }
  for spec in self.specs {
    let nested = spec.validate()
    for issue in nested.issues {
      report.push(issue)
    }
  }
  report
}

pub fn RuleSet::parse_lines(text : String) -> RuleSet {
  let rules = RuleSet::new()
  let lines = split_lines(text)
  for line in lines {
    let trimmed = line.trim().to_owned()
    if trimmed.length() > 0 && !starts_with(trimmed, "#") {
      rules.push(LimitSpec::parse(trimmed))
    }
  }
  rules
}

fn starts_with(text : String, prefix : String) -> Bool {
  if prefix.length() > text.length() {
    false
  } else {
    text[0:prefix.length()] == prefix
  }
}

fn split_lines(text : String) -> Array[String] {
  let lines : Array[String] = []
  let mut start = 0
  for i in 0..<text.length() {
    let ch = text.unsafe_get(i)
    if ch.to_int() == '\n'.to_int() {
      lines.push(text[start:i].to_owned())
      start = i + 1
    }
  }
  if start <= text.length() {
    lines.push(text[start:text.length()].to_owned())
  }
  lines
}
