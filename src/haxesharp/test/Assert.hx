package haxesharp.test;

import haxesharp.exceptions.AssertionFailedException;

/**
 * Used to provide NUnit-style Assert.that(...) helpers. Example usages:
 * `Assert.that(x, Is.equalTo(y))`
 * `Assert.that(x, Is.not.equalTo(y))`
*/
class Assert
{
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

    public static function fail(message:String):Void
    {
        throw new AssertionFailedException(message);
    }
}

// Extension method
class Is
{
    public var expected(default, null):Any;
    public var evaluate(default, null):Any->Bool;

    public function new(expected:Any, evaluate:Any->Bool)
    {
        this.expected = expected;
        this.evaluate = evaluate;
    }

    public static function equalTo(expected:Any):Is
    {
        return new Is(expected, function(actual)
        {
            return expected == actual;
        });
    }

    public static function not(expected:Any):Is
    {
        return new Is(expected, function(actual)
        {
            return expected != actual;
        });
    }
}