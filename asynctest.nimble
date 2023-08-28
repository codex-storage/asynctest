version = "0.4.1"
author = "asynctest Authors"
description = "Test asynchronous code"
license = "MIT"

task test, "Runs the test suite":
  for module in ["stdlib", "chronos", "unittest2"]:
    withDir "testmodules/" & module:
      delEnv "NIMBLE_DIR" # use nimbledeps dir
      exec "nimble install -d -y"
      exec "nimble test -y"
