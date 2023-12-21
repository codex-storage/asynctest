template suite*(name, body) =

  suite name:
    let suiteproc = proc =

      ## Runs before all tests in the suite
      template setupAll(setupAllBody) {.used.} =
        runAsync setupAllBody

      ## Runs after all tests in the suite
      template teardownAll(teardownAllBody) {.used.} =
        template teardownAllIMPL: untyped {.inject.} =
          runAsync teardownAllBody

      template setup(setupBody) {.used.} =
        setup:
          runAsync setupBody

      template teardown(teardownBody) {.used.} =
        teardown:
          let exception = getCurrentException()
          runAsync teardownBody
          setCurrentException(exception)

      body

      when declared(teardownAllIMPL):
        teardownAllIMPL()

    suiteproc()

template test*(name, body) =
  test name:
    runAsync body
