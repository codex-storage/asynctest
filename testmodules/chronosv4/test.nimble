version = "0.1.0"
author = "Asynctest Authors"
description = "Asynctest tests for std/unittest and pkg/chronos"
license = "MIT"

requires "chronos#head" # TODO: use "chronos >= 4.0.0 & < 5.0.0" once it's released

task test, "Runs the test suite":
  exec "nim c -f -r --skipParentCfg test.nim"
