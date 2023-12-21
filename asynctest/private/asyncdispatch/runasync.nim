import std/asyncdispatch

template runAsync*(body): untyped =
  let asyncProc = proc {.async.} = body
  waitFor asyncProc()
