version = "0.1.0"
author = "Asynctest Authors"
description = "Asynctest tests for std/unittest and pkg/chronos"
license = "MIT"

requires "chronos >= 3.2.0 & < 4.0.0"

task test, "Runs the test suite":
  exec "nim c -f -r --skipParentCfg test.nim"
