///|
fn main {
  let limiter = @moonlimit.TokenBucket::new(2, 1, 1000)
  let requests = [0, 0, 0, 1000, 1500, 2000]
  println("MoonLimit token bucket demo")
  for now_ms in requests {
    let decision = limiter.allow_at(now_ms)
    if decision.is_allowed() {
      println(
        "\{now_ms}ms allow remaining=\{decision.remaining()} reset=\{decision.reset_after_ms()}ms",
      )
    } else {
      println("\{now_ms}ms reject retry_after=\{decision.retry_after_ms()}ms")
    }
  }
  println("")
  println(@moonlimit.recipe_login_guard().describe())
  let report = @moonlimit.recipe_login_guard().run()
  println(report.summary_line())
  println("")
  println("Algorithms: \{@moonlimit.algorithm_docs().length()}")
  println("Cookbook entries: \{@moonlimit.cookbook_count()}")
}
