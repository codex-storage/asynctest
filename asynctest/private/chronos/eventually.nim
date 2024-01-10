import pkg/chronos

template eventually*(expression: untyped, timeout=5000): bool =
  bind Moment, now, milliseconds

  proc eventually: Future[bool] {.async.} =
    let endTime = Moment.now() + timeout.milliseconds
    while not expression:
      if endTime < Moment.now():
        return false
      await sleepAsync(10.milliseconds)
    return true

  await eventually()
