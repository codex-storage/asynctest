asynctest
=========

Complements the standard [unittest][1] module in Nim to allow testing of
asynchronous code.

Installation
------------

Use the [Nimble][2] package manager to add asynctest to an existing project.
Add the following to its .nimble file:

```nim
requires "asynctest >= 0.1.0 & < 0.2.0"
```

Usage
-----

Simply replace `test` with `asynctest` when you need to await asynchronous calls
in the test. The same holds for `asyncsetup` and `asyncteardown`, which allow
you to await asynchronous calls during test setup and teardown.

Example
-------

```nim

import unittest
import asynctest
import asyncdispatch # alternatively: import chronos

proc someAsyncProc {.async.} =
  # perform some async operations using await

suite "test async proc":

  asyncsetup:
    # invoke await in the test setup:
    await someAsyncProc()

  asyncteardown:
    # invoke await in the test teardown:
    await someAsyncProc()

  asynctest "some test":
    # invoke await in tests:
    await someAsyncProc()

```

[1]: https://nim-lang.org/docs/unittest.html
[2]: https://github.com/nim-lang/nimble
