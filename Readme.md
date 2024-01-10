asynctest
=========

Complements the standard [unittest][1] module in Nim to allow testing of
asynchronous code.

Installation
------------

Use the [Nimble][2] package manager to add asynctest to an existing project.
Add the following to its .nimble file:

```nim
requires "asynctest >= 0.5.1 & < 0.6.0"
```

Usage
-----

Replace `import unittest` with one of the following imports, and you can await
asynchronous calls in tests, setup and teardown.

When you use Nim's standard library only ([asyncdispatch][4] and [unittest][1]):
```nim
import asynctest/asyncdispatch/unittest
```

When you use [chronos][5] or [unittest2][3], pick the import that matches your
choices:

```nim
import asynctest/asyncdispatch/unittest2  # standard async and unittest2
import asynctest/chronos/unittest         # chronos and standard unittest
import asynctest/chronos/unittest2        # chronos and unittest2
```

Example
-------

```nim

import asynctest/asyncdispatch/unittest

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

setupAll and teardownAll
------------------------

The `setup` and `teardown` code runs before and after every test, just like the
standard [unittest][1] module. In addition we provide `setupAll` and
`teardownAll`. The `setupAll` code runs once before all tests in the suite, and
the `teardownAll` runs once after all tests in the suite. Use these only as a
last resort when setting up the test environment is very costly. Be careful that
the tests do not modify the environment that you set up, lest you introduce
dependencies between tests.


[1]: https://nim-lang.org/docs/unittest.html
[2]: https://github.com/nim-lang/nimble
[3]: https://github.com/status-im/nim-unittest2
[4]: https://nim-lang.org/docs/asyncdispatch.html
[5]: https://github.com/status-im/nim-chronos/
