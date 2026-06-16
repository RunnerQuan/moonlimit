///|
test "regression token bucket burst 1" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 2" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 3" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 4" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 5" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 6" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 7" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 8" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 9" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 10" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 11" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 12" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 13" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 14" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 15" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 16" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 17" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 18" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 19" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 20" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 21" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 22" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 23" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 24" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 25" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 26" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 27" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 28" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 29" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 30" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 31" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 32" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 33" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 34" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 35" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 36" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 37" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 38" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 39" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 40" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 41" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 42" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 43" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 44" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 45" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 46" {
  let bucket = @moonlimit.TokenBucket::new(2, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 47" {
  let bucket = @moonlimit.TokenBucket::new(3, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 48" {
  let bucket = @moonlimit.TokenBucket::new(4, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 49" {
  let bucket = @moonlimit.TokenBucket::new(5, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression token bucket burst 50" {
  let bucket = @moonlimit.TokenBucket::new(1, 1, 1000)
  inspect(bucket.allow_at(0).is_allowed(), content="true")
  inspect(bucket.allow_at(0).is_allowed(), content="false")
}

///|
test "regression fixed window reset 1" {
  let limiter = @moonlimit.FixedWindow::new(2, 1001)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1001).is_allowed(), content="true")
}

///|
test "regression fixed window reset 2" {
  let limiter = @moonlimit.FixedWindow::new(3, 1002)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1002).is_allowed(), content="true")
}

///|
test "regression fixed window reset 3" {
  let limiter = @moonlimit.FixedWindow::new(4, 1003)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1003).is_allowed(), content="true")
}

///|
test "regression fixed window reset 4" {
  let limiter = @moonlimit.FixedWindow::new(1, 1004)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1004).is_allowed(), content="true")
}

///|
test "regression fixed window reset 5" {
  let limiter = @moonlimit.FixedWindow::new(2, 1005)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1005).is_allowed(), content="true")
}

///|
test "regression fixed window reset 6" {
  let limiter = @moonlimit.FixedWindow::new(3, 1006)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1006).is_allowed(), content="true")
}

///|
test "regression fixed window reset 7" {
  let limiter = @moonlimit.FixedWindow::new(4, 1007)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1007).is_allowed(), content="true")
}

///|
test "regression fixed window reset 8" {
  let limiter = @moonlimit.FixedWindow::new(1, 1008)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1008).is_allowed(), content="true")
}

///|
test "regression fixed window reset 9" {
  let limiter = @moonlimit.FixedWindow::new(2, 1009)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1009).is_allowed(), content="true")
}

///|
test "regression fixed window reset 10" {
  let limiter = @moonlimit.FixedWindow::new(3, 1010)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1010).is_allowed(), content="true")
}

///|
test "regression fixed window reset 11" {
  let limiter = @moonlimit.FixedWindow::new(4, 1011)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1011).is_allowed(), content="true")
}

///|
test "regression fixed window reset 12" {
  let limiter = @moonlimit.FixedWindow::new(1, 1012)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1012).is_allowed(), content="true")
}

///|
test "regression fixed window reset 13" {
  let limiter = @moonlimit.FixedWindow::new(2, 1013)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1013).is_allowed(), content="true")
}

///|
test "regression fixed window reset 14" {
  let limiter = @moonlimit.FixedWindow::new(3, 1014)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1014).is_allowed(), content="true")
}

///|
test "regression fixed window reset 15" {
  let limiter = @moonlimit.FixedWindow::new(4, 1015)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1015).is_allowed(), content="true")
}

///|
test "regression fixed window reset 16" {
  let limiter = @moonlimit.FixedWindow::new(1, 1016)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1016).is_allowed(), content="true")
}

///|
test "regression fixed window reset 17" {
  let limiter = @moonlimit.FixedWindow::new(2, 1017)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1017).is_allowed(), content="true")
}

///|
test "regression fixed window reset 18" {
  let limiter = @moonlimit.FixedWindow::new(3, 1018)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1018).is_allowed(), content="true")
}

///|
test "regression fixed window reset 19" {
  let limiter = @moonlimit.FixedWindow::new(4, 1019)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1019).is_allowed(), content="true")
}

///|
test "regression fixed window reset 20" {
  let limiter = @moonlimit.FixedWindow::new(1, 1020)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1020).is_allowed(), content="true")
}

///|
test "regression fixed window reset 21" {
  let limiter = @moonlimit.FixedWindow::new(2, 1021)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1021).is_allowed(), content="true")
}

///|
test "regression fixed window reset 22" {
  let limiter = @moonlimit.FixedWindow::new(3, 1022)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1022).is_allowed(), content="true")
}

///|
test "regression fixed window reset 23" {
  let limiter = @moonlimit.FixedWindow::new(4, 1023)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1023).is_allowed(), content="true")
}

///|
test "regression fixed window reset 24" {
  let limiter = @moonlimit.FixedWindow::new(1, 1024)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1024).is_allowed(), content="true")
}

///|
test "regression fixed window reset 25" {
  let limiter = @moonlimit.FixedWindow::new(2, 1025)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1025).is_allowed(), content="true")
}

///|
test "regression fixed window reset 26" {
  let limiter = @moonlimit.FixedWindow::new(3, 1026)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1026).is_allowed(), content="true")
}

///|
test "regression fixed window reset 27" {
  let limiter = @moonlimit.FixedWindow::new(4, 1027)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1027).is_allowed(), content="true")
}

///|
test "regression fixed window reset 28" {
  let limiter = @moonlimit.FixedWindow::new(1, 1028)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1028).is_allowed(), content="true")
}

///|
test "regression fixed window reset 29" {
  let limiter = @moonlimit.FixedWindow::new(2, 1029)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1029).is_allowed(), content="true")
}

///|
test "regression fixed window reset 30" {
  let limiter = @moonlimit.FixedWindow::new(3, 1030)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1030).is_allowed(), content="true")
}

///|
test "regression fixed window reset 31" {
  let limiter = @moonlimit.FixedWindow::new(4, 1031)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1031).is_allowed(), content="true")
}

///|
test "regression fixed window reset 32" {
  let limiter = @moonlimit.FixedWindow::new(1, 1032)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1032).is_allowed(), content="true")
}

///|
test "regression fixed window reset 33" {
  let limiter = @moonlimit.FixedWindow::new(2, 1033)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1033).is_allowed(), content="true")
}

///|
test "regression fixed window reset 34" {
  let limiter = @moonlimit.FixedWindow::new(3, 1034)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1034).is_allowed(), content="true")
}

///|
test "regression fixed window reset 35" {
  let limiter = @moonlimit.FixedWindow::new(4, 1035)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1035).is_allowed(), content="true")
}

///|
test "regression fixed window reset 36" {
  let limiter = @moonlimit.FixedWindow::new(1, 1036)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1036).is_allowed(), content="true")
}

///|
test "regression fixed window reset 37" {
  let limiter = @moonlimit.FixedWindow::new(2, 1037)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1037).is_allowed(), content="true")
}

///|
test "regression fixed window reset 38" {
  let limiter = @moonlimit.FixedWindow::new(3, 1038)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1038).is_allowed(), content="true")
}

///|
test "regression fixed window reset 39" {
  let limiter = @moonlimit.FixedWindow::new(4, 1039)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1039).is_allowed(), content="true")
}

///|
test "regression fixed window reset 40" {
  let limiter = @moonlimit.FixedWindow::new(1, 1040)
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(0).is_allowed(), content="false")
  inspect(limiter.allow_at(1040).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 1" {
  let limiter = @moonlimit.SlidingLog::new(3, 1010)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1009).is_allowed(), content="false")
  inspect(limiter.allow_at(1010).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 2" {
  let limiter = @moonlimit.SlidingLog::new(4, 1020)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1019).is_allowed(), content="false")
  inspect(limiter.allow_at(1020).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 3" {
  let limiter = @moonlimit.SlidingLog::new(2, 1030)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1029).is_allowed(), content="false")
  inspect(limiter.allow_at(1030).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 4" {
  let limiter = @moonlimit.SlidingLog::new(3, 1040)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1039).is_allowed(), content="false")
  inspect(limiter.allow_at(1040).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 5" {
  let limiter = @moonlimit.SlidingLog::new(4, 1050)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1049).is_allowed(), content="false")
  inspect(limiter.allow_at(1050).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 6" {
  let limiter = @moonlimit.SlidingLog::new(2, 1060)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1059).is_allowed(), content="false")
  inspect(limiter.allow_at(1060).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 7" {
  let limiter = @moonlimit.SlidingLog::new(3, 1070)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1069).is_allowed(), content="false")
  inspect(limiter.allow_at(1070).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 8" {
  let limiter = @moonlimit.SlidingLog::new(4, 1080)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1079).is_allowed(), content="false")
  inspect(limiter.allow_at(1080).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 9" {
  let limiter = @moonlimit.SlidingLog::new(2, 1090)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1089).is_allowed(), content="false")
  inspect(limiter.allow_at(1090).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 10" {
  let limiter = @moonlimit.SlidingLog::new(3, 1100)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1099).is_allowed(), content="false")
  inspect(limiter.allow_at(1100).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 11" {
  let limiter = @moonlimit.SlidingLog::new(4, 1110)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1109).is_allowed(), content="false")
  inspect(limiter.allow_at(1110).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 12" {
  let limiter = @moonlimit.SlidingLog::new(2, 1120)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1119).is_allowed(), content="false")
  inspect(limiter.allow_at(1120).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 13" {
  let limiter = @moonlimit.SlidingLog::new(3, 1130)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1129).is_allowed(), content="false")
  inspect(limiter.allow_at(1130).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 14" {
  let limiter = @moonlimit.SlidingLog::new(4, 1140)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1139).is_allowed(), content="false")
  inspect(limiter.allow_at(1140).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 15" {
  let limiter = @moonlimit.SlidingLog::new(2, 1150)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1149).is_allowed(), content="false")
  inspect(limiter.allow_at(1150).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 16" {
  let limiter = @moonlimit.SlidingLog::new(3, 1160)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1159).is_allowed(), content="false")
  inspect(limiter.allow_at(1160).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 17" {
  let limiter = @moonlimit.SlidingLog::new(4, 1170)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1169).is_allowed(), content="false")
  inspect(limiter.allow_at(1170).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 18" {
  let limiter = @moonlimit.SlidingLog::new(2, 1180)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1179).is_allowed(), content="false")
  inspect(limiter.allow_at(1180).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 19" {
  let limiter = @moonlimit.SlidingLog::new(3, 1190)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1189).is_allowed(), content="false")
  inspect(limiter.allow_at(1190).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 20" {
  let limiter = @moonlimit.SlidingLog::new(4, 1200)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1199).is_allowed(), content="false")
  inspect(limiter.allow_at(1200).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 21" {
  let limiter = @moonlimit.SlidingLog::new(2, 1210)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1209).is_allowed(), content="false")
  inspect(limiter.allow_at(1210).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 22" {
  let limiter = @moonlimit.SlidingLog::new(3, 1220)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1219).is_allowed(), content="false")
  inspect(limiter.allow_at(1220).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 23" {
  let limiter = @moonlimit.SlidingLog::new(4, 1230)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1229).is_allowed(), content="false")
  inspect(limiter.allow_at(1230).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 24" {
  let limiter = @moonlimit.SlidingLog::new(2, 1240)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1239).is_allowed(), content="false")
  inspect(limiter.allow_at(1240).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 25" {
  let limiter = @moonlimit.SlidingLog::new(3, 1250)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1249).is_allowed(), content="false")
  inspect(limiter.allow_at(1250).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 26" {
  let limiter = @moonlimit.SlidingLog::new(4, 1260)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1259).is_allowed(), content="false")
  inspect(limiter.allow_at(1260).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 27" {
  let limiter = @moonlimit.SlidingLog::new(2, 1270)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1269).is_allowed(), content="false")
  inspect(limiter.allow_at(1270).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 28" {
  let limiter = @moonlimit.SlidingLog::new(3, 1280)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1279).is_allowed(), content="false")
  inspect(limiter.allow_at(1280).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 29" {
  let limiter = @moonlimit.SlidingLog::new(4, 1290)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1289).is_allowed(), content="false")
  inspect(limiter.allow_at(1290).is_allowed(), content="true")
}

///|
test "regression sliding log exactness 30" {
  let limiter = @moonlimit.SlidingLog::new(2, 1300)
  ignore(limiter.allow_at(0))
  ignore(limiter.allow_at(0))
  inspect(limiter.allow_at(1299).is_allowed(), content="false")
  inspect(limiter.allow_at(1300).is_allowed(), content="true")
}

///|
test "regression retry schedule cap 1" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 2" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 3" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 4" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 5" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}

///|
test "regression retry schedule cap 6" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 7" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 8" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 9" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 10" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}

///|
test "regression retry schedule cap 11" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 12" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 13" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 14" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 15" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}

///|
test "regression retry schedule cap 16" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 17" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 18" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 19" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 20" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}

///|
test "regression retry schedule cap 21" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 22" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 23" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 24" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 25" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}

///|
test "regression retry schedule cap 26" {
  let schedule = @moonlimit.RetrySchedule::exponential(20, 160)
  inspect(schedule.delay_at(0), content="20")
  inspect(schedule.delay_at(3), content="160")
  inspect(schedule.delay_at(8), content="160")
}

///|
test "regression retry schedule cap 27" {
  let schedule = @moonlimit.RetrySchedule::exponential(30, 240)
  inspect(schedule.delay_at(0), content="30")
  inspect(schedule.delay_at(3), content="240")
  inspect(schedule.delay_at(8), content="240")
}

///|
test "regression retry schedule cap 28" {
  let schedule = @moonlimit.RetrySchedule::exponential(40, 320)
  inspect(schedule.delay_at(0), content="40")
  inspect(schedule.delay_at(3), content="320")
  inspect(schedule.delay_at(8), content="320")
}

///|
test "regression retry schedule cap 29" {
  let schedule = @moonlimit.RetrySchedule::exponential(50, 400)
  inspect(schedule.delay_at(0), content="50")
  inspect(schedule.delay_at(3), content="400")
  inspect(schedule.delay_at(8), content="400")
}

///|
test "regression retry schedule cap 30" {
  let schedule = @moonlimit.RetrySchedule::exponential(10, 80)
  inspect(schedule.delay_at(0), content="10")
  inspect(schedule.delay_at(3), content="80")
  inspect(schedule.delay_at(8), content="80")
}
