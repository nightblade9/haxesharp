package haxesharp.test;

import haxe.PosInfos;
import haxesharp.exceptions.AssertionFailedException;

/**
 Used to provide NUnit-style `Assert.that(...)` helpers. Example usages:
 - `Assert.that(x == y)`
 - `Assert.that(x, Is.equalTo(y))`
 - `Assert.that(x, Is.not(y))`
*/
class Assert
{
    /**
    Assert that an actual and expected object are equal.
    - Typical usage is `Assert.that(x, Is.equalTo(y))`.
    - You can also use `Assert.that(x == y)`.
    **/
    public static function that(actual:Any, ?is:Is):Void
    {
        if (is == null && actual != true)
        {
            throw new AssertionFailedException("Expected true, got false");
        }
        else if (is != null && !is.evaluate(actual))
        {
            throw new AssertionFailedException('Expected ${is.expected} but got ${actual}');
        }
    }

    /**
    Cause a test to fail immediately. Throws an `AssertionFailedException` 
    with the specified message.
    **/
    public static function fail(message:String):Void
    {
        throw new AssertionFailedException(message);
    }

    public static function throws(expectedType:Dynamic, code:Dynamic, ?info:PosInfos):Dynamic
    {
        // TODO: refactor into "massive.munit.Assert.throws" after 2.1.3+ is released.
        try
		{
			code();
			fail("Expected exception wasn't thrown!");
			return null; // needed to compile
		}
		catch (e:Dynamic)
		{
			if (Std.is(e, expectedType))
			{
				return e;
			}
			else
			{
				Assert.fail('Expected exception of type ${Type.getClassName(expectedType)} but got ${Type.getClassName(Type.getClass(e))}: ${e}');
				return null; // needed to compile
			}
		}
    }
}

// Extension method
/**
Helper class, used in `Assert.that(x, Is.foo)`
**/
class Is
{
    @:dox(hide)
    public var expected(default, null):Any;

    @:dox(hide)    
    public var evaluate(default, null):Any->Bool;

    @:dox(hide)
    public function new(expected:Any, evaluate:Any->Bool)
    {
        this.expected = expected;
        this.evaluate = evaluate;
    }

    /**
    Assert that a value is equal to the expected value.
    **/
    public static function equalTo(expected:Any):Is
    {
        return new Is(expected, function(actual)
        {
            return expected == actual;
        });
    }

    /**
    Assert that a value is not equal to the expected value.
    **/
    public static function not(expected:Any):Is
    {
        return new Is(expected, function(actual)
        {
            return expected != actual;
        });
    }
}