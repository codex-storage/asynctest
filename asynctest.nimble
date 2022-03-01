version = "0.3.1"
author = "asynctest Authors"
description = "Test asynchronous code"
license = "MIT"

requires "nim >= 1.2.0 & < 2.0.0"

task test, "Runs the test suite":
  for module in ["stdlib", "chronos", "unittest2"]:
    withDir "testmodules/" & module:
      exec "nimble install -d -y"
      exec "nimble test -y"
