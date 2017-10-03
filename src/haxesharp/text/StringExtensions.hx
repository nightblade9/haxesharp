package haxesharp.text;

class StringExtensions
{
    public static function contains(s:String, substring:String):Bool
    {
        return s.indexOf(substring) > -1;
    }
}