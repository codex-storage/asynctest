import std/asyncdispatch
import std/times

template eventually*(expression: untyped, timeout=5000, pollInterval=1000): bool =

  proc eventually: Future[bool] {.async.} =
    let endTime = getTime() + initDuration(milliseconds=timeout)
    while not expression:
      if endTime < getTime():
        return false
      await sleepAsync(pollInterval)
    return true

  await eventually()
