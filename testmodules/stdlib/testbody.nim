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

suite "test async setupAll and teardownAll, allow multiple suites":

  setupAll:
    # invoke await in the test setup:
    await someAsyncProc()

  teardownAll:
    # invoke await in the test teardown:
    await someAsyncProc()

  test "async test":
    # invoke await in tests:
    await someAsyncProc()
