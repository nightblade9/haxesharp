package haxesharp.test;

/**
 * Used to provide NUnit-style Assert.That(...) and Assert.AreEqual helpers.
*/
class Assert
{
    // Assert.that(x, Is.EqualTo(y))
    // Assert.that(x, Is.Not.Null)
    // Assert.that(x, Is.Not.EqualTo(y))
    public static function that(actual:Any, is:Is):Void
    {
        if (!is.evaluate(actual))
        {
            throw new Exception('Expected ${is.expected} but got ${actual}');
        }
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