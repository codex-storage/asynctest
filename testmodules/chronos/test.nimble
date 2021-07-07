version = "0.1.0"
author = "Asynctest Authors"
description = "Asynctest tests for std/unittest and pkg/chronos"
license = "MIT"

requires "chronos"

task test, "Runs the test suite":
  exec "nim c -f -r test.nim"
