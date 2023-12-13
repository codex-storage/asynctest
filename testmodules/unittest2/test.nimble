version = "0.1.0"
author = "Asynctest Authors"
description = "Asynctest tests for pkg/unittest2 and pkg/chronos"
license = "MIT"

requires "unittest2 <= 0.0.9"
requires "chronos"

task test, "Runs the test suite":
  exec "nim c -f -r --skipParentCfg test.nim"
