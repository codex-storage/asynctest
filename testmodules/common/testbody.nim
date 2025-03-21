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

    check eventually(becomesTrue(), pollInterval=10)

  test "becomes false after timeout":

    proc remainsFalse: bool = false

    check not eventually(remainsFalse(), timeout=100, pollInterval=10)

  test "becomes true during timeout":

    proc slowTrue: bool =
      sleep(100)
      true

    check eventually(slowTrue(), timeout=50, pollInterval=10)

  test "works with async procedures":

    var x: int

    proc slowProcedure {.async.} =
      when compiles(await sleepAsync(100.milliseconds)):
        await sleepAsync(100.milliseconds) # chronos
      else:
        await sleepAsync(100) # asyncdispatch
      x = 42

    let future = slowProcedure()
    check eventually(x == 42, pollInterval=10)
    await future

  test "respects poll interval":
    var evaluations: int = 0

    # If we try to access this from the closure, it will crash later with
    # a segfault, so pass as var.
    proc expensivePredicate(counter: var int): bool =
      inc counter
      return false

    check not eventually(evaluations.expensivePredicate(), pollInterval=100, timeout=500)
    check 1 <= evaluations and evaluations <= 6

    evaluations = 0
    check not eventually(evaluations.expensivePredicate(), pollInterval=10, timeout=500)
    check 20 <= evaluations and evaluations <= 51
