package haxesharp.text;

/**
Static extensions to the `String` class. Consume via a `using` statement (`using haxesharp.text.StringExtensions`).
**/
class StringExtensions
{
    /**
    Check if a string contains a value.
    **/
    public static function contains(s:String, substring:String):Bool
    {
        return s.indexOf(substring) > -1;
    }
}