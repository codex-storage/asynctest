version = "0.1.0"
author = "Asynctest Authors"
description = "Asynctest tests for std/unittest and std/asyncdispatch"
license = "MIT"

task test, "Runs the test suite":
  exec "nim c -f -r --skipParentCfg test.nim"
