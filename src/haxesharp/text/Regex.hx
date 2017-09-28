package haxesharp.text;

import haxesharp.exceptions.Exception;

class Regex
{
    public static function matches(input:String, pattern:String):Array<String>
    {
        if (pattern.indexOf("(") == -1 || pattern.indexOf(")") == -1)
        {
            throw new Exception('Regex.matches(...) requires an expression with grouping; was: ${pattern}');
        }

        //var regEx = ~/([0-9]+)/;
        var regex = new EReg(pattern, "g");
        
        var matches = [];
        while (regex.match(input))
        {
            var match = regex.matched(1);
            matches.push(match);
            input = regex.matchedRight();
        }
        return matches;
    }
}