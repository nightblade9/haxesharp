# HaxeSharp

Some helpers that make Haxe more "C# friendly." If you're a .NET developer, you will find these methods similar or identical to what the .NET APIs provide.

In general, we try to stick to Haxe-style conventions (eg. camel-case method names), while making APIs as familiar as possible for .NET APIs.

# API

## Exceptions

Simply `throw new Exception("HP should never be zero or less");` to throw an exception. You get a consistent stack-trace.

You can also subclass `Exception` to create your own exception hierarchy.

## Testing

The `Assert` class includes several methods similar to fluent assertions in .NET. For the full API, check the source code. Examples include:

- `Assert.that(actual, Is.equalTo(expected))`
- `Assert.that(x, Is.not(13))`