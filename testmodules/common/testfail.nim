template tryImport(module) = import module
when compiles tryImport std/exitprocs:
  import std/exitprocs
else:
  template getProgramResult: auto = programResult
  template setProgramResult(value) = programResult = value

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
      except CatchableError:
        discard

    test "should fail, but not crash":
      if true:
        raise newException(ValueError, "This exception is expected")
