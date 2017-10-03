# HaxeSharp

[![Build Status](https://travis-ci.org/nightblade9/haxesharp.svg?branch=master)](https://travis-ci.org/nightblade9/haxesharp)

HaxeSharp brings functionality to Haxe that is inspried by some of the best of what .NET has to offer. If you're a .NET developer, you will find these methods similar to what the .NET APIs provide. At the same time, they're written following the Haxe style and conventions.

In some cases, language functions make it difficult to achieve .NET's design (eg. Haxe doesn't support multiple constructors). We try to work around these cases, or in the worst case, provide some other alternative.

HaxeSharp also tries to follow the principle of least surprise in cases where .NET doesn't; for example, we may throw exceptions for invalid cases (eg. `new Array<Int>() [1, 2, 3].take(17)`) even though .NET doesn't.

# Installation

Installation is available from Git only, via `haxelib`.

```
haxelib git https://github.com/nightblade9/haxesharp.git
```

For now, `hxslam` is required for short lambdas (and LINQ). To add it, add `-lib hxslam` to your `.hxml` file.

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