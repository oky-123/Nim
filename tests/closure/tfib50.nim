discard """
  output: "20365011074"
"""

import tables

proc memoize(f: proc (a: int): int): proc (a: int): int =
    var previous = initTable[int, int]()
    return proc(i: int): int =
        if not previous.hasKey i:
            previous[i] = f(i)
        return previous[i]

var fib: proc(a: int): int

fib = memoize(proc (i: int): int =
    if i == 0 or i == 1:
        return 1
    return fib(i-1) + fib(i-2)
)

echo fib(50)
