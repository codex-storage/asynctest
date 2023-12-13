template launderExceptions(body: typed) =
  ## Chronos V4 requires that all procs which raise Exception annotate it
  ## with {.async: (raises: [Exception]).}, but this construct does not
  ## exist in asyncdispatch. We therefore launder all real instances of
  ## Exception into CatchableError and make Chronos happy while not losing
  ## context information for the remainder of the exception types.
  try:
    body
  except Defect as ex:
    raise ex
  except CatchableError as ex:
    raise ex
  except Exception as ex:
    raise newException(CatchableError, ex.msg, ex)

template suite*(name, body) =

  suite name:

    ## Runs before all tests in the suite
    template setupAll(setupAllBody) {.used.} =
      let b = proc {.async.} = setupAllBody
      waitFor b()

    ## Runs after all tests in the suite
    template teardownAll(teardownAllBody) {.used.} =
      template teardownAllIMPL: untyped {.inject.} =
        let a = proc {.async.} = launderExceptions: teardownAllBody
        waitFor a()

    template setup(setupBody) {.used.} =
      setup:
        let asyncproc = proc {.async.} = launderExceptions: setupBody
        waitFor asyncproc()

    template teardown(teardownBody) {.used.} =
      teardown:
        let exception = getCurrentException()
        let asyncproc = proc {.async.} = launderExceptions: teardownBody
        waitFor asyncproc()
        setCurrentException(exception)

    let suiteproc = proc = # Avoids GcUnsafe2 warnings with chronos
      body

      when declared(teardownAllIMPL):
        teardownAllIMPL()

    suiteproc()

template test*(name, body) =
  test name:
    let asyncproc = proc {.async.} = launderExceptions: body
    waitFor asyncproc()
