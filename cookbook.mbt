///|
pub(all) struct CookbookEntry {
  entry_name : String
  description : String
  spec : LimitSpec
} derive(Eq, Debug)

///|
pub fn CookbookEntry::name(self : CookbookEntry) -> String {
  self.entry_name
}

///|
pub fn CookbookEntry::summary(self : CookbookEntry) -> String {
  self.entry_name + ": " + self.description + " -> " + self.spec.explain()
}

///|
pub fn cookbook_public_api_edge() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "public_api_edge",
    description: "Public API edge throttling",
    spec: LimitSpec::token_bucket("api", 22, 3, 2250),
  }
}

///|
pub fn cookbook_admin_api() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "admin_api",
    description: "Admin API protection",
    spec: LimitSpec::token_bucket("admin", 13, 1, 2500),
  }
}

///|
pub fn cookbook_login_endpoint() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "login_endpoint",
    description: "Login endpoint abuse control",
    spec: LimitSpec::token_bucket("login", 21, 4, 1000),
  }
}

///|
pub fn cookbook_signup_endpoint() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "signup_endpoint",
    description: "Signup endpoint protection",
    spec: LimitSpec::token_bucket("signup", 12, 2, 1250),
  }
}

///|
pub fn cookbook_password_reset_endpoint() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "password_reset_endpoint",
    description: "Password reset protection",
    spec: LimitSpec::token_bucket("reset", 20, 5, 1500),
  }
}

///|
pub fn cookbook_search_typeahead() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "search_typeahead",
    description: "Search typeahead smoothing",
    spec: LimitSpec::token_bucket("search", 11, 3, 1750),
  }
}

///|
pub fn cookbook_upload_endpoint() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "upload_endpoint",
    description: "Upload endpoint fairness",
    spec: LimitSpec::token_bucket("upload", 19, 1, 2000),
  }
}

///|
pub fn cookbook_download_endpoint() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "download_endpoint",
    description: "Download endpoint fairness",
    spec: LimitSpec::token_bucket("download", 10, 4, 2250),
  }
}

///|
pub fn cookbook_webhook_worker() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "webhook_worker",
    description: "Webhook worker dispatch",
    spec: LimitSpec::token_bucket("webhook", 18, 2, 2500),
  }
}

///|
pub fn cookbook_email_worker() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "email_worker",
    description: "Email worker quota",
    spec: LimitSpec::token_bucket("email", 26, 5, 1000),
  }
}

///|
pub fn cookbook_sms_worker() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "sms_worker",
    description: "SMS worker quota",
    spec: LimitSpec::token_bucket("sms", 17, 3, 1250),
  }
}

///|
pub fn cookbook_image_worker() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "image_worker",
    description: "Image rendering jobs",
    spec: LimitSpec::token_bucket("image", 25, 1, 1500),
  }
}

///|
pub fn cookbook_report_worker() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "report_worker",
    description: "Report generation jobs",
    spec: LimitSpec::token_bucket("report", 16, 4, 1750),
  }
}

///|
pub fn cookbook_crawler_host() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "crawler_host",
    description: "Crawler host politeness",
    spec: LimitSpec::token_bucket("crawler", 24, 2, 2000),
  }
}

///|
pub fn cookbook_tenant_plan_free() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "tenant_plan_free",
    description: "Free tenant plan quota",
    spec: LimitSpec::token_bucket("free", 15, 5, 2250),
  }
}

///|
pub fn cookbook_tenant_plan_pro() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "tenant_plan_pro",
    description: "Pro tenant plan quota",
    spec: LimitSpec::token_bucket("pro", 23, 3, 2500),
  }
}

///|
pub fn cookbook_checkout_flow() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "checkout_flow",
    description: "Checkout flow guard",
    spec: LimitSpec::token_bucket("checkout", 14, 1, 1000),
  }
}

///|
pub fn cookbook_payment_attempts() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "payment_attempts",
    description: "Payment attempt guard",
    spec: LimitSpec::token_bucket("payment", 22, 4, 1250),
  }
}

///|
pub fn cookbook_comment_posting() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "comment_posting",
    description: "Comment posting moderation",
    spec: LimitSpec::token_bucket("comment", 13, 2, 1500),
  }
}

///|
pub fn cookbook_message_sending() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "message_sending",
    description: "Message sending fairness",
    spec: LimitSpec::token_bucket("message", 21, 5, 1750),
  }
}

///|
pub fn cookbook_notification_push() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "notification_push",
    description: "Push notification throttle",
    spec: LimitSpec::token_bucket("push", 12, 3, 2000),
  }
}

///|
pub fn cookbook_audit_export() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "audit_export",
    description: "Audit export jobs",
    spec: LimitSpec::token_bucket("audit", 20, 1, 2250),
  }
}

///|
pub fn cookbook_backup_job() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "backup_job",
    description: "Backup job throttle",
    spec: LimitSpec::token_bucket("backup", 11, 4, 2500),
  }
}

///|
pub fn cookbook_ai_inference() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "ai_inference",
    description: "AI inference quota",
    spec: LimitSpec::token_bucket("inference", 19, 2, 1000),
  }
}

///|
pub fn cookbook_embedding_job() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "embedding_job",
    description: "Embedding generation quota",
    spec: LimitSpec::token_bucket("embedding", 10, 5, 1250),
  }
}

///|
pub fn cookbook_thumbnail_job() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "thumbnail_job",
    description: "Thumbnail generation throttle",
    spec: LimitSpec::token_bucket("thumbnail", 18, 3, 1500),
  }
}

///|
pub fn cookbook_feed_refresh() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "feed_refresh",
    description: "Feed refresh throttle",
    spec: LimitSpec::token_bucket("feed", 26, 1, 1750),
  }
}

///|
pub fn cookbook_metrics_ingest() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "metrics_ingest",
    description: "Metrics ingest smoothing",
    spec: LimitSpec::token_bucket("metrics", 17, 4, 2000),
  }
}

///|
pub fn cookbook_log_ingest() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "log_ingest",
    description: "Log ingest smoothing",
    spec: LimitSpec::token_bucket("logs", 25, 2, 2250),
  }
}

///|
pub fn cookbook_billing_sync() -> CookbookEntry {
  CookbookEntry::{
    entry_name: "billing_sync",
    description: "Billing sync quota",
    spec: LimitSpec::token_bucket("billing", 16, 5, 2500),
  }
}

///|
pub fn cookbook_entries() -> Array[CookbookEntry] {
  [
    cookbook_public_api_edge(),
    cookbook_admin_api(),
    cookbook_login_endpoint(),
    cookbook_signup_endpoint(),
    cookbook_password_reset_endpoint(),
    cookbook_search_typeahead(),
    cookbook_upload_endpoint(),
    cookbook_download_endpoint(),
    cookbook_webhook_worker(),
    cookbook_email_worker(),
    cookbook_sms_worker(),
    cookbook_image_worker(),
    cookbook_report_worker(),
    cookbook_crawler_host(),
    cookbook_tenant_plan_free(),
    cookbook_tenant_plan_pro(),
    cookbook_checkout_flow(),
    cookbook_payment_attempts(),
    cookbook_comment_posting(),
    cookbook_message_sending(),
    cookbook_notification_push(),
    cookbook_audit_export(),
    cookbook_backup_job(),
    cookbook_ai_inference(),
    cookbook_embedding_job(),
    cookbook_thumbnail_job(),
    cookbook_feed_refresh(),
    cookbook_metrics_ingest(),
    cookbook_log_ingest(),
    cookbook_billing_sync(),
  ]
}

///|
pub fn cookbook_markdown() -> String {
  let mut out = "# MoonLimit Cookbook\n"
  for entry in cookbook_entries() {
    out = out + "- " + entry.summary() + "\n"
  }
  out
}

///|
pub fn cookbook_find(name : String) -> CookbookEntry? {
  for entry in cookbook_entries() {
    if entry.name() == name {
      return Some(entry)
    }
  }
  None
}

///|
pub fn cookbook_count() -> Int {
  cookbook_entries().length()
}
