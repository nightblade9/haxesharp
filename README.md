# HaxeSharp

[![Build Status](https://travis-ci.org/nightblade9/haxesharp.svg?branch=master)](https://travis-ci.org/nightblade9/haxesharp)

Some helpers that make Haxe more "C# friendly." If you're a .NET developer, you will find these methods similar or identical to what the .NET APIs provide.

In general, we try to stick to Haxe-style conventions (eg. camel-case method names), while making APIs as familiar as possible for .NET APIs.

# API

## Exceptions

Simply `throw new Exception("HP should never be zero or less");` to throw an exception. You get a consistent stack-trace.

You can also subclass `Exception` to create your own exception hierarchy.

## LINQ and Lambdas

With our LINQ helpers, you can write LINQ-like queries:

```
using haxesharp.collections.Linq;

var numbers = [1, 2, 3, 4, 5, 6, 7];
var even = numbers.where((n) => n % 2 == 0);
trace(even); // [2, 4, 6]
```

C#-style short-lambdas are available via the excellent [hxslam](https://github.com/bynuff/hxslam) library.

## Random

You can use the `Random` class to generate random numbers, optionally passing in a seed if you want deterministic random. APIs:
- `new Random()` creates a random generator; `new Random(seed)` creates a seeded random generator.
- `Random.next()` returns an integer
- `Random.next(n)` returns an integer in the range [0..n) (excludes `n`)
- `Random.next(a, b)` returns a number `n` that satisfies `a <= n < b`

## Testing

The `Assert` class includes several methods similar to fluent assertions in .NET. For the full API, check the source code. Examples include:

- `Assert.that(actual, Is.equalTo(expected))`
- `Assert.that(x, Is.not(13))`