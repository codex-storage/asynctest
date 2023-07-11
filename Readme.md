asynctest
=========

Complements the standard [unittest][1] module in Nim to allow testing of
asynchronous code.

Installation
------------

Use the [Nimble][2] package manager to add asynctest to an existing project.
Add the following to its .nimble file:

```nim
requires "asynctest >= 0.4.1 & < 0.5.0"
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
    # invoke await in each test setup:
    await someAsyncProc()

  teardown:
    # invoke await in each test teardown:
    await someAsyncProc()

  test "async test":
    # invoke await in tests:
    await someAsyncProc()

```

setupAll and teardownAll
------------------------

The `setup` and `teardown` code runs before and after every test, just like the
standard [unittest][1] module. In addition we provide `setupAll` and
`teardownAll`. The `setupAll` code runs once before all tests in the suite, and
the `teardownAll` runs once after all tests in the suite. Use these only as a
last resort when setting up the test environment is very costly. Be careful that
the tests do not modify the environment that you set up, lest you introduce
dependencies between tests.

check eventually
----------------

When you find yourself adding calls to `sleepAsync` to your tests, you might
want to consider using `check eventually` instead. It will repeatedly check
an expression until it becomes true. It has a built-in timeout of 5 seconds that
you can override.

```nim
var x: int

proc slowProcedure {.async.} =
  # perform a slow operation
  x = 42

let future = slowProcedure()
check eventually x == 42
await future
```

Unittest2
---------

The [unittest2][3] package is supported. Make sure that you
`import asynctest/unittest2` instead of the normal import.

[1]: https://nim-lang.org/docs/unittest.html
[2]: https://github.com/nim-lang/nimble
[3]: https://github.com/status-im/nim-unittest2
