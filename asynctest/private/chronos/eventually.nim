import pkg/chronos
import pkg/chronos/config

template eventuallyProcSignature(body: untyped): untyped =
  when compiles(config.chronosHandleException):
    proc eventually: Future[bool] {.async: (handleException: true,
        raises: [AsyncExceptionError, CancelledError]).} =
      body
  else:
    proc eventually: Future[bool] {.async.} =
      body

template eventually*(expression: untyped, timeout=5000): bool =
  bind Moment, now, milliseconds

  eventuallyProcSignature:
    let endTime = Moment.now() + timeout.milliseconds
    while not expression:
      if endTime < Moment.now():
        return false
      await sleepAsync(10.milliseconds)
    return true

  await eventually()
