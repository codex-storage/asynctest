import pkg/chronos
import pkg/chronos/config

when compiles(config.chronosHandleException): # detect chronos v4

  template runAsync*(body): untyped =
    let asyncProc = proc {.async: (raises: [Exception]).} = body
    waitFor asyncProc()

else:

  template runAsync*(body): untyped =
    let asyncProc = proc {.async.} = body
    waitFor asyncProc()
