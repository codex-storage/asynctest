import std/exitprocs

template silent(body) =

  let exitcode = getProgramResult()
  resetOutputFormatters()
  addOutputFormatter(OutputFormatter())

  body

  resetOutputFormatters()
  addOutputFormatter(defaultConsoleFormatter())
  setProgramResult(exitcode)

suite "reports unhandled exception when teardown handles exceptions too":

  silent:

    proc someAsyncProc {.async.} = discard

    teardown:
      try:
        await someAsyncProc()
      except:
        discard

    test "should fail, but not crash":
      raise newException(ValueError, "This exception is expected")
