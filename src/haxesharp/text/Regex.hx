package haxesharp.text;

import haxesharp.exceptions.Exception;

class Regex
{
    private var regex:String;
    private var options:String;

    /**
    Find all matches of the given input against the given pattern.
    Optionally, with the given regex options (eg. ig)
    Returns a list of matched substrings. Note that the regex must use grouping.    
    */
    public static function matches(input:String, pattern:String, ?options:String):Array<String>
    {
        if (pattern.indexOf("(") == -1 || pattern.indexOf(")") == -1)
        {
            throw new Exception('Regex.matches(...) requires an expression with grouping; was: ${pattern}');
        }

        if (options == null)
        {
            options = "";
        }
        
        if (options.indexOf("g") == -1)
        {
            options += "g";
        }

        //var regEx = ~/([0-9]+)/;
        var regex = new EReg(pattern, options);
        
        var matches = [];
        while (regex.match(input))
        {
            var match = regex.matched(1);
            matches.push(match);
            input = regex.matchedRight();
        }
        return matches;
    }

    public function new(regex:String, ?options:String)
    {
        this.regex = regex;
        this.options = (options != null ? options : "");
    }

    /**
    Finds the first match of this regex on input and returns it.
    Use match.Success to tell if we found anything or not.
    */
    public function match(input:String):Match
    {                
        var groups = Regex.matches(input, this.regex, this.options);
        return new Match(groups.length > 0, groups);
    }
}