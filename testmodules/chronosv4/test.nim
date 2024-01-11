import pkg/asynctest/chronos/unittest

include ../common/testbody
include ../common/testfail

import std/times

suite "eventually and std/times":

  test "compiles when both chronos and std/times are imported":
    check eventually true

  test "compiles when the expression handed to eventually can raise Exception":
    proc aProc(): bool {.raises: [Exception].} = raise newException(
      Exception, "an exception")
    check:
      compiles:
        discard eventually aProc()
