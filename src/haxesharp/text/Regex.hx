package haxesharp.text;

import haxesharp.exceptions.Exception;

/**
A regular expression class for matching and grouping.
**/
class Regex
{
    private var regex:String;
    private var options:String;

    /**
    Find all matches of the given input against the given pattern.
    Optionally, with the given regex options (eg. `ig`)
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

        var regex = new EReg(pattern, options);
        
        var matches = [];
        while (regex.match(input))
        {
            // This is HORRIBLE. Haxe doesn't provide any way to get the number of groups.
            // With regexes with multiple groups (eg: (\d+) (\w+)), we have no recourse
            // except to keep calling .matched(n) until we get an exception. 
            var stop:Bool = false;
            var nextGroupNum:Int = 1;

            while (!stop)
            {
                try
                {
                    var match = regex.matched(nextGroupNum);
                    matches.push(match);
                    nextGroupNum++;                    
                }
                catch (e:Any)
                {
                    stop = true;
                }
            }
            
            // For expressions with multiple things to match (eg. \d+ vs. "11 22 3333"), keep
            // processing the rest of the input.
            input = regex.matchedRight();
        }
        return matches;
    }

    /**
    Creates a new regular expression, with options (optional).
    **/
    public function new(regex:String, ?options:String)
    {
        this.regex = regex;
        this.options = (options != null ? options : "");
    }

    /**
    Finds the first match of this regex on input and returns it.
    Use match.Success to tell if we found anything or not.
    Unlike C#, these are base-zero, not base-one.
    */
    public function match(input:String):Match
    {                
        var groups = Regex.matches(input, this.regex, this.options);
        return new Match(groups.length > 0, groups);
    }
}