import std/unittest
import std/asyncdispatch
import pkg/asynctest

suite "async tests":

  proc asyncproc {.async.} = discard

  asyncsetup: # allows await in setup
    await asyncproc()

  asyncteardown: # allows await in teardown
    await asyncproc()

  asynctest "allows await in tests":
    await asyncproc()
