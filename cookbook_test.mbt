///|
test "cookbook exposes many business entries" {
  inspect(@moonlimit.cookbook_count(), content="30")
  let entries = @moonlimit.cookbook_entries()
  inspect(entries[0].name(), content="public_api_edge")
  inspect(entries[29].name(), content="billing_sync")
}

///|
test "cookbook find returns selected entry" {
  match @moonlimit.cookbook_find("login_endpoint") {
    Some(entry) => inspect(entry.name(), content="login_endpoint")
    None => inspect("missing", content="login_endpoint")
  }
}

///|
test "cookbook find returns none for unknown entry" {
  inspect(@moonlimit.cookbook_find("missing") is None, content="true")
}

///|
test "cookbook markdown starts with title" {
  let markdown = @moonlimit.cookbook_markdown()
  inspect(markdown[0:20].to_owned(), content="# MoonLimit Cookbook")
}
