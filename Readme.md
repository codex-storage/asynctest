asynctest
=========

Complements the standard [unittest][1] module in Nim to allow testing of
asynchronous code.

Installation
------------

Use the [Nimble][2] package manager to add asynctest to an existing project.
Add the following to its .nimble file:

```nim
requires "asynctest >= 0.2.0 & < 0.3.0"
```

Usage
-----

Simply replace `import unittest` with `import asynctest`, and you can await
asynchronous calls in tests, setup and teardown.

Example
-------

```nim

import asynctest
import asyncdispatch # alternatively: import chronos

proc someAsyncProc {.async.} =
  # perform some async operations using await

suite "test async proc":

  setup:
    # invoke await in the test setup:
    await someAsyncProc()

  teardown:
    # invoke await in the test teardown:
    await someAsyncProc()

  test "async test":
    # invoke await in tests:
    await someAsyncProc()

```

Unittest2
---------

The [unittest2][3] package is supported. Make sure that you
`import asynctest/unittest2` instead of the normal import.

[1]: https://nim-lang.org/docs/unittest.html
[2]: https://github.com/nim-lang/nimble
[3]: https://github.com/status-im/nim-unittest2
