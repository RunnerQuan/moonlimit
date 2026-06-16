pub(all) struct LimiterRecipe {
  recipe_name : String
  audience : String
  engine : PolicyEngine
  workload : Workload
} derive(Debug)

pub fn LimiterRecipe::name(self : LimiterRecipe) -> String {
  self.recipe_name
}

pub fn LimiterRecipe::describe(self : LimiterRecipe) -> String {
  "\{self.recipe_name} for \{self.audience}: \{self.engine.describe()}"
}

pub fn LimiterRecipe::run(self : LimiterRecipe) -> SimulationReport {
  self.engine.simulate(self.workload)
}

pub fn recipe_api_gateway() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_token_bucket("global-burst", 100, 20, 1000)
  engine.add_sliding_log("edge-smooth", 120, 1000)
  LimiterRecipe::{
    recipe_name: "api-gateway",
    audience: "HTTP API edge services",
    engine,
    workload: Workload::steady(120, 0, 8),
  }
}

pub fn recipe_login_guard() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_fixed_window("login-window", 5, 60000)
  engine.add_quota("login-day", 50, 86400000)
  LimiterRecipe::{
    recipe_name: "login-guard",
    audience: "authentication endpoints",
    engine,
    workload: Workload::burst(8, 0),
  }
}

pub fn recipe_search_box() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_sliding_log("typeahead", 20, 1000)
  engine.add_token_bucket("search-burst", 10, 5, 1000)
  LimiterRecipe::{
    recipe_name: "search-box",
    audience: "interactive search and autocomplete",
    engine,
    workload: Workload::ramp(20, 0, 100, 4),
  }
}

pub fn recipe_crawler_politeness() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_token_bucket("host-bucket", 2, 1, 1000)
  engine.add_fixed_window("host-minute", 30, 60000)
  LimiterRecipe::{
    recipe_name: "crawler-politeness",
    audience: "web crawlers and sync jobs",
    engine,
    workload: Workload::steady(10, 0, 250),
  }
}

pub fn recipe_webhook_dispatch() -> LimiterRecipe {
  let engine = PolicyEngine::any()
  engine.add_token_bucket("normal", 5, 2, 1000)
  engine.add_fixed_window("fallback-minute", 60, 60000)
  LimiterRecipe::{
    recipe_name: "webhook-dispatch",
    audience: "outbound webhook workers",
    engine,
    workload: Workload::burst(12, 0),
  }
}

pub fn recipe_email_sender() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_fixed_window("per-minute", 120, 60000)
  engine.add_quota("per-day", 1000, 86400000)
  LimiterRecipe::{
    recipe_name: "email-sender",
    audience: "transactional email services",
    engine,
    workload: Workload::steady(130, 0, 450),
  }
}

pub fn recipe_sms_sender() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_fixed_window("per-minute", 20, 60000)
  engine.add_quota("per-day", 200, 86400000)
  LimiterRecipe::{
    recipe_name: "sms-sender",
    audience: "SMS notification workers",
    engine,
    workload: Workload::burst(25, 0),
  }
}

pub fn recipe_image_renderer() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_token_bucket("render-burst", 4, 1, 1000)
  engine.add_fixed_window("render-minute", 30, 60000)
  LimiterRecipe::{
    recipe_name: "image-renderer",
    audience: "expensive CPU-bound rendering jobs",
    engine,
    workload: Workload::ramp(12, 0, 500, 20),
  }
}

pub fn recipe_checkout_guard() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_sliding_log("checkout", 3, 10000)
  engine.add_quota("daily-checkout", 30, 86400000)
  LimiterRecipe::{
    recipe_name: "checkout-guard",
    audience: "payment and checkout workflows",
    engine,
    workload: Workload::burst(5, 0),
  }
}

pub fn recipe_password_reset() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_fixed_window("reset-hour", 3, 3600000)
  engine.add_quota("reset-day", 5, 86400000)
  LimiterRecipe::{
    recipe_name: "password-reset",
    audience: "account recovery flows",
    engine,
    workload: Workload::burst(6, 0),
  }
}

pub fn recipe_batch_import() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_token_bucket("import-rate", 50, 10, 1000)
  engine.add_fixed_window("import-minute", 500, 60000)
  LimiterRecipe::{
    recipe_name: "batch-import",
    audience: "bulk import jobs",
    engine,
    workload: Workload::steady(80, 0, 50),
  }
}

pub fn recipe_tenant_fairness() -> LimiterRecipe {
  let engine = PolicyEngine::all()
  engine.add_token_bucket("tenant-burst", 20, 5, 1000)
  engine.add_quota("tenant-day", 10000, 86400000)
  LimiterRecipe::{
    recipe_name: "tenant-fairness",
    audience: "multi-tenant SaaS backends",
    engine,
    workload: Workload::alternating_keys(40, 0, 50, "tenant-a", "tenant-b"),
  }
}

pub fn recipe_all() -> Array[LimiterRecipe] {
  [
    recipe_api_gateway(),
    recipe_login_guard(),
    recipe_search_box(),
    recipe_crawler_politeness(),
    recipe_webhook_dispatch(),
    recipe_email_sender(),
    recipe_sms_sender(),
    recipe_image_renderer(),
    recipe_checkout_guard(),
    recipe_password_reset(),
    recipe_batch_import(),
    recipe_tenant_fairness(),
  ]
}

pub fn recipe_names() -> Array[String] {
  let names : Array[String] = []
  for recipe in recipe_all() {
    names.push(recipe.name())
  }
  names
}

pub fn recipe_markdown_index() -> String {
  let mut out = "# MoonLimit Recipes\n"
  for recipe in recipe_all() {
    out = out + "- " + recipe.describe() + "\n"
  }
  out
}
