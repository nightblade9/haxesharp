# HaxeSharp

[![Build Status](https://travis-ci.org/nightblade9/haxesharp.svg?branch=master)](https://travis-ci.org/nightblade9/haxesharp)

HaxeSharp brings functionality to Haxe that is inspried by some of the best of what .NET has to offer. If you're a .NET developer, you will find these methods similar to what the .NET APIs provide. 

To see the full list of available classes and functions, please [consult the API](https://nightblade9.github.io/haxesharp/).

# Design Philosophy

While HaxeSharp copies the .NET API in many cases, at the same time, they're written following the Haxe style and conventions.

In some cases, language functions make it difficult to achieve .NET's design (eg. Haxe doesn't support multiple constructors). We try to work around these cases, or in the worst case, provide some other alternative.

HaxeSharp also tries to follow the principle of least surprise in cases where .NET doesn't; for example, we may throw exceptions for invalid cases (eg. `[1, 2, 3].take(17)`) even though .NET doesn't.

# Installation

Installation is available through Git and `haxelib` only:

```
haxelib git https://github.com/nightblade9/haxesharp.git
```

# API Highlights

To see the full list of APIs available, check [the API docs](https://nightblade9.github.io/haxesharp/). Some of the most important functionality includes the following.

## Exceptions

HaxeSharp ships with a `haxesharp.exceptions.Exception` class you can use and throw like any other .NET exception (eg. `throw new Exception("HP should never be zero or less");`). You get a consistent stack-trace across all Haxe targets.

You can also subclass `Exception` to create your own; the only requirement is a constructor that accepts a single string `message` parameter.

HaxeSharp includes several exceptions familiar to .NET developers, such as `InvalidOperationException`.

## LINQ and Lambdas

With our LINQ helpers, you can write LINQ-like queries on arrays:

```
using haxesharp.collections.Linq;

var numbers = [1, 2, 3, 4, 5, 6, 7];
var even = numbers.where((n) => n % 2 == 0);
trace(even); // [2, 4, 6]
```

These are implemented as static extensions; you need to write `using haxesharp.collections.Linq`, not `import haxesharp.collections.Linq`.

C#-style short-lambdas are available via the excellent [hxslam](https://github.com/bynuff/hxslam) library, which HaxeSharp consumes.

## Random

You can use the `Random` class to generate random numbers, optionally passing in a seed if you want deterministic random. APIs:
- `new Random()` creates a random generator; `new Random(seed)` creates a seeded random generator.
- `Random.next()` returns an integer
- `Random.next(n)` returns an integer in the range [0..n) (excludes `n`)
- `Random.next(a, b)` returns a number `n` that satisfies `a <= n < b`

## Regex

Haxe ships with an `EReg` class which lacks in terms of usability. HaxeSharp provides a regular `Regex` class with a few useful methods:

- `Regex.matches(pattern, text)` returns an array of all matches (groups) of `pattern` inside `text`.
- `new Regex(...).match(...)` returns a `Match` instance, which includes a `groups` field (array of matches as strings).

## .Contains

Like .NET, you can write `x.contains(...)` on both strings and arrays.

## Testing

In line with some of the NUnit fluent APIs, HaxeSharp includes an `Assert` class with several methods. Some of the most-commonly-used ones include:

- `Assert.that(actual, Is.equalTo(expected))`
- `Assert.that(x, Is.not(13))`