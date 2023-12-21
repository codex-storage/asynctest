import pkg/chronos
import pkg/chronos/config

when compiles(config.chronosHandleException): # detect chronos v4

  template runAsync*(body): untyped =
    # The unittest module from stdlib can still raise a bare Exception,
    # so we allow chronos to convert it to an AsyncExceptionError, and
    # we disable the ensuing BareExcept warning.
    {.push warning[BareExcept]:off.}
    let asyncProc =
      proc {.async: (handleException: true, raises: [AsyncExceptionError]).} =
        body
    {.pop.}
    waitFor asyncProc()

else:

  template runAsync*(body): untyped =
    let asyncProc = proc {.async.} = body
    waitFor asyncProc()
