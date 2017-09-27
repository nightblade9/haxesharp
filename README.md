# HaxeSharp

[![Build Status](https://travis-ci.org/nightblade9/haxesharp.svg?branch=master)](https://travis-ci.org/nightblade9/haxesharp)

Some helpers that make Haxe more "C# friendly." If you're a .NET developer, you will find these methods similar or identical to what the .NET APIs provide.

In general, we try to stick to Haxe-style conventions (eg. camel-case method names), while making APIs as familiar as possible for .NET APIs.

# API

## Exceptions

Simply `throw new Exception("HP should never be zero or less");` to throw an exception. You get a consistent stack-trace.

You can also subclass `Exception` to create your own exception hierarchy.

## Random

You can use the `Random` class to generate random numbers:

- `Random.next()` returns an integer
- `Random.next(n)` returns an integer in the range [0..n) (excludes `n`)
- `Random.next(a, b)` returns a number `n` that satisfies `a <= n < b`

## Testing

The `Assert` class includes several methods similar to fluent assertions in .NET. For the full API, check the source code. Examples include:

- `Assert.that(actual, Is.equalTo(expected))`
- `Assert.that(x, Is.not(13))`