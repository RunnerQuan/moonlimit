///|
test "recipe catalog exposes names" {
  let names = @moonlimit.recipe_names()
  inspect(names.length(), content="12")
  inspect(names[0], content="api-gateway")
  inspect(names[11], content="tenant-fairness")
}

///|
test "recipe markdown includes selected recipes" {
  let markdown = @moonlimit.recipe_markdown_index()
  inspect(markdown[0:19].to_owned(), content="# MoonLimit Recipes")
}

///|
test "login recipe rejects abusive burst" {
  let report = @moonlimit.recipe_login_guard().run()
  inspect(report.allowed(), content="5")
  inspect(report.rejected(), content="3")
}

///|
test "webhook recipe uses any-mode fallback" {
  let report = @moonlimit.recipe_webhook_dispatch().run()
  inspect(report.allowed() > 5, content="true")
  inspect(report.total(), content="12")
}

///|
test "password reset recipe is intentionally strict" {
  let report = @moonlimit.recipe_password_reset().run()
  inspect(report.allowed(), content="3")
  inspect(report.rejected(), content="3")
}

///|
test "algorithm docs list core algorithms" {
  let docs = @moonlimit.algorithm_docs()
  inspect(docs.length(), content="8")
  inspect(docs[0].name(), content="Token Bucket")
  inspect(docs[7].name(), content="Quota Window")
}

///|
test "algorithm markdown starts with title" {
  let markdown = @moonlimit.algorithm_markdown()
  inspect(markdown[0:22].to_owned(), content="# MoonLimit Algorithms")
}

///|
test "algorithm table has csv header" {
  let table = @moonlimit.algorithm_summary_table()
  inspect(table[0:17].to_owned(), content="algorithm,summary")
}
