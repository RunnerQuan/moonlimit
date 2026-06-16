///|
test "cookbook regression public_api_edge" {
  match @moonlimit.cookbook_find("public_api_edge") {
    Some(entry) => {
      inspect(entry.name(), content="public_api_edge")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="public_api_edge")
  }
}

///|
test "cookbook regression admin_api" {
  match @moonlimit.cookbook_find("admin_api") {
    Some(entry) => {
      inspect(entry.name(), content="admin_api")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="admin_api")
  }
}

///|
test "cookbook regression login_endpoint" {
  match @moonlimit.cookbook_find("login_endpoint") {
    Some(entry) => {
      inspect(entry.name(), content="login_endpoint")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="login_endpoint")
  }
}

///|
test "cookbook regression signup_endpoint" {
  match @moonlimit.cookbook_find("signup_endpoint") {
    Some(entry) => {
      inspect(entry.name(), content="signup_endpoint")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="signup_endpoint")
  }
}

///|
test "cookbook regression password_reset_endpoint" {
  match @moonlimit.cookbook_find("password_reset_endpoint") {
    Some(entry) => {
      inspect(entry.name(), content="password_reset_endpoint")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="password_reset_endpoint")
  }
}

///|
test "cookbook regression search_typeahead" {
  match @moonlimit.cookbook_find("search_typeahead") {
    Some(entry) => {
      inspect(entry.name(), content="search_typeahead")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="search_typeahead")
  }
}

///|
test "cookbook regression upload_endpoint" {
  match @moonlimit.cookbook_find("upload_endpoint") {
    Some(entry) => {
      inspect(entry.name(), content="upload_endpoint")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="upload_endpoint")
  }
}

///|
test "cookbook regression download_endpoint" {
  match @moonlimit.cookbook_find("download_endpoint") {
    Some(entry) => {
      inspect(entry.name(), content="download_endpoint")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="download_endpoint")
  }
}

///|
test "cookbook regression webhook_worker" {
  match @moonlimit.cookbook_find("webhook_worker") {
    Some(entry) => {
      inspect(entry.name(), content="webhook_worker")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="webhook_worker")
  }
}

///|
test "cookbook regression email_worker" {
  match @moonlimit.cookbook_find("email_worker") {
    Some(entry) => {
      inspect(entry.name(), content="email_worker")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="email_worker")
  }
}

///|
test "cookbook regression sms_worker" {
  match @moonlimit.cookbook_find("sms_worker") {
    Some(entry) => {
      inspect(entry.name(), content="sms_worker")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="sms_worker")
  }
}

///|
test "cookbook regression image_worker" {
  match @moonlimit.cookbook_find("image_worker") {
    Some(entry) => {
      inspect(entry.name(), content="image_worker")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="image_worker")
  }
}

///|
test "cookbook regression report_worker" {
  match @moonlimit.cookbook_find("report_worker") {
    Some(entry) => {
      inspect(entry.name(), content="report_worker")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="report_worker")
  }
}

///|
test "cookbook regression crawler_host" {
  match @moonlimit.cookbook_find("crawler_host") {
    Some(entry) => {
      inspect(entry.name(), content="crawler_host")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="crawler_host")
  }
}

///|
test "cookbook regression tenant_plan_free" {
  match @moonlimit.cookbook_find("tenant_plan_free") {
    Some(entry) => {
      inspect(entry.name(), content="tenant_plan_free")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="tenant_plan_free")
  }
}

///|
test "cookbook regression tenant_plan_pro" {
  match @moonlimit.cookbook_find("tenant_plan_pro") {
    Some(entry) => {
      inspect(entry.name(), content="tenant_plan_pro")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="tenant_plan_pro")
  }
}

///|
test "cookbook regression checkout_flow" {
  match @moonlimit.cookbook_find("checkout_flow") {
    Some(entry) => {
      inspect(entry.name(), content="checkout_flow")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="checkout_flow")
  }
}

///|
test "cookbook regression payment_attempts" {
  match @moonlimit.cookbook_find("payment_attempts") {
    Some(entry) => {
      inspect(entry.name(), content="payment_attempts")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="payment_attempts")
  }
}

///|
test "cookbook regression comment_posting" {
  match @moonlimit.cookbook_find("comment_posting") {
    Some(entry) => {
      inspect(entry.name(), content="comment_posting")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="comment_posting")
  }
}

///|
test "cookbook regression message_sending" {
  match @moonlimit.cookbook_find("message_sending") {
    Some(entry) => {
      inspect(entry.name(), content="message_sending")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="message_sending")
  }
}

///|
test "cookbook regression notification_push" {
  match @moonlimit.cookbook_find("notification_push") {
    Some(entry) => {
      inspect(entry.name(), content="notification_push")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="notification_push")
  }
}

///|
test "cookbook regression audit_export" {
  match @moonlimit.cookbook_find("audit_export") {
    Some(entry) => {
      inspect(entry.name(), content="audit_export")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="audit_export")
  }
}

///|
test "cookbook regression backup_job" {
  match @moonlimit.cookbook_find("backup_job") {
    Some(entry) => {
      inspect(entry.name(), content="backup_job")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="backup_job")
  }
}

///|
test "cookbook regression ai_inference" {
  match @moonlimit.cookbook_find("ai_inference") {
    Some(entry) => {
      inspect(entry.name(), content="ai_inference")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="ai_inference")
  }
}

///|
test "cookbook regression embedding_job" {
  match @moonlimit.cookbook_find("embedding_job") {
    Some(entry) => {
      inspect(entry.name(), content="embedding_job")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="embedding_job")
  }
}

///|
test "cookbook regression thumbnail_job" {
  match @moonlimit.cookbook_find("thumbnail_job") {
    Some(entry) => {
      inspect(entry.name(), content="thumbnail_job")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="thumbnail_job")
  }
}

///|
test "cookbook regression feed_refresh" {
  match @moonlimit.cookbook_find("feed_refresh") {
    Some(entry) => {
      inspect(entry.name(), content="feed_refresh")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="feed_refresh")
  }
}

///|
test "cookbook regression metrics_ingest" {
  match @moonlimit.cookbook_find("metrics_ingest") {
    Some(entry) => {
      inspect(entry.name(), content="metrics_ingest")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="metrics_ingest")
  }
}

///|
test "cookbook regression log_ingest" {
  match @moonlimit.cookbook_find("log_ingest") {
    Some(entry) => {
      inspect(entry.name(), content="log_ingest")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="log_ingest")
  }
}

///|
test "cookbook regression billing_sync" {
  match @moonlimit.cookbook_find("billing_sync") {
    Some(entry) => {
      inspect(entry.name(), content="billing_sync")
      inspect(entry.summary().length() > entry.name().length(), content="true")
    }
    None => inspect("missing", content="billing_sync")
  }
}
