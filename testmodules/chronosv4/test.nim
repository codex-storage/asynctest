import pkg/asynctest/chronos/unittest

include ../common/testbody
include ../common/testfail

import std/times

suite "eventually and std/times":

  test "compiles when both chronos and std/times are imported":
    check eventually true
