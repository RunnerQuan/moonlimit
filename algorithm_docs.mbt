///|
pub(all) struct AlgorithmDoc {
  doc_name : String
  summary : String
  strengths : String
  tradeoffs : String
} derive(Eq, Debug)

///|
pub fn AlgorithmDoc::name(self : AlgorithmDoc) -> String {
  self.doc_name
}

///|
pub fn AlgorithmDoc::line(self : AlgorithmDoc) -> String {
  "\{self.doc_name}: \{self.summary}"
}

///|
pub fn AlgorithmDoc::markdown(self : AlgorithmDoc) -> String {
  "## \{self.doc_name}\n\n\{self.summary}\n\nStrengths: \{self.strengths}\n\nTradeoffs: \{self.tradeoffs}\n"
}

///|
pub fn doc_token_bucket() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Token Bucket",
    summary: "Allows short bursts while enforcing an average refill rate.",
    strengths: "Simple, fast, and suitable for API edge quotas.",
    tradeoffs: "Integer refill can be coarse unless callers choose a fine period.",
  }
}

///|
pub fn doc_leaky_bucket() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Leaky Bucket",
    summary: "Models a draining queue and smooths request admission.",
    strengths: "Easy to reason about when downstream systems need steady flow.",
    tradeoffs: "Less burst-friendly than token bucket.",
  }
}

///|
pub fn doc_fixed_window() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Fixed Window",
    summary: "Counts requests inside aligned time windows.",
    strengths: "Very small state and straightforward operational semantics.",
    tradeoffs: "Can allow boundary spikes at window edges.",
  }
}

///|
pub fn doc_sliding_window() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Sliding Window",
    summary: "Weights the previous window to reduce boundary spikes.",
    strengths: "Good compromise between state size and smoother behavior.",
    tradeoffs: "Approximate; exact fairness requires sliding log.",
  }
}

///|
pub fn doc_sliding_log() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Sliding Log",
    summary: "Stores exact timestamps for events inside the active window.",
    strengths: "Precise and easy to validate in tests.",
    tradeoffs: "Memory grows with the number of accepted events in the window.",
  }
}

///|
pub fn doc_gcra() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "GCRA",
    summary: "Tracks theoretical arrival time for precise rate conformance.",
    strengths: "Industrial-grade algorithm used by high precision throttlers.",
    tradeoffs: "Less intuitive than bucket counters for new users.",
  }
}

///|
pub fn doc_concurrency() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Concurrency Limiter",
    summary: "Restricts in-flight work rather than requests per time window.",
    strengths: "Protects CPU, memory, sockets, and other bounded resources.",
    tradeoffs: "Requires callers to release permits reliably.",
  }
}

///|
pub fn doc_quota() -> AlgorithmDoc {
  AlgorithmDoc::{
    doc_name: "Quota Window",
    summary: "Tracks long-period budgets such as daily or monthly allowances.",
    strengths: "Useful for billing, abuse controls, and product plan limits.",
    tradeoffs: "Needs persistent storage for distributed or restart-safe quotas.",
  }
}

///|
pub fn algorithm_docs() -> Array[AlgorithmDoc] {
  [
    doc_token_bucket(),
    doc_leaky_bucket(),
    doc_fixed_window(),
    doc_sliding_window(),
    doc_sliding_log(),
    doc_gcra(),
    doc_concurrency(),
    doc_quota(),
  ]
}

///|
pub fn algorithm_markdown() -> String {
  let mut out = "# MoonLimit Algorithms\n"
  for doc in algorithm_docs() {
    out = out + "\n" + doc.markdown()
  }
  out
}

///|
pub fn algorithm_summary_table() -> String {
  let mut out = "algorithm,summary\n"
  for doc in algorithm_docs() {
    out = out + doc.name() + "," + doc.summary + "\n"
  }
  out
}
