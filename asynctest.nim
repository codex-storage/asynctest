import unittest
export unittest except suite, test

template suite*(name, body) =
  suite name:

    template setup(setupBody) =
      setup:
        let asyncproc = proc {.async.} = setupBody
        waitFor asyncproc()

    template teardown(teardownBody) =
      teardown:
        let asyncproc = proc {.async.} = teardownBody
        waitFor asyncproc()

    let suiteproc = proc = body # Avoids GcUnsafe2 warnings with chronos
    suiteproc()

template test*(name, body) =
  test name:
    let asyncproc = proc {.async.} = body
    waitFor asyncproc()
