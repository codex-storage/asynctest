import std/unittest
import std/asyncdispatch
import pkg/asynctest

proc someAsyncProc {.async.} =
  # perform some async operations using await
  discard

suite "test async proc":

  asyncsetup:
    # invoke await in the test setup:
    await someAsyncProc()

  asyncteardown:
    # invoke await in the test teardown:
    await someAsyncProc()

  asynctest "async test":
    # invoke await in tests:
    await someAsyncProc()
