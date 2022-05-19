proc someAsyncProc {.async.} =
  # perform some async operations using await
  discard

suite "test async proc":

  setup:
    # invoke await in the test setup:
    await someAsyncProc()

  teardown:
    # invoke await in the test teardown:
    await someAsyncProc()

  test "async test":
    # invoke await in tests:
    await someAsyncProc()

suite "setupAll and teardownAll":

  setupAll:
    # invoke await in the test setup:
    await someAsyncProc()

  teardownAll:
    # invoke await in the test teardown:
    await someAsyncProc()

  test "async test":
    # invoke await in tests:
    await someAsyncProc()

from std/os import sleep

suite "eventually":

  test "becomes true":

    var tries = 0

    proc becomesTrue: bool =
      inc tries
      tries == 3

    check eventually becomesTrue()

  test "becomes false after timeout":

    proc remainsFalse: bool = false

    check not eventually(remainsFalse(), timeout=100)

  test "becomes true during timeout":

    proc slowTrue: bool =
      sleep(100)
      true

    check eventually(slowTrue(), timeout=50)

  test "works with async procedures":

    var x: int

    proc slowProcedure {.async.} =
      when compiles(await sleepAsync(100.milliseconds)):
        await sleepAsync(100.milliseconds) # chronos
      else:
        await sleepAsync(100) # asyncdispatch
      x = 42

    let future = slowProcedure()
    check eventually x == 42
    await future
