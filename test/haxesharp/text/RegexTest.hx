package haxesharp.text;

import haxesharp.exceptions.Exception;
import haxesharp.test.Assert;
import haxesharp.text.Regex;

class RegexTest
{
    @Test
    public function matchesThrowsIfBracketsAreMissing()
    {
        var cases = ["(a-z", ")a-Z", "hi"];
        for (expr in cases)
        {
            try
            {
                Regex.matches("", expr);
                Assert.fail('Regex did not throw on expression with missing brackets: ${expr}');
            }
            catch (e:Exception)
            {
                // Pass
            }
        }
    }

    @Test
    public function matchesMatchesAllMatchesInInput()
    {
        var input = "1 22 cat dog 333 mouse 44 5 elephant";
        var regex = "(\\d+)";
        var actual:Array<String> = Regex.matches(input, regex);

        Assert.that(actual.length, Is.equalTo(5));
        Assert.that(actual[0], Is.equalTo("1"));
        Assert.that(actual[1], Is.equalTo("22"));
        Assert.that(actual[2], Is.equalTo("333"));
        Assert.that(actual[3], Is.equalTo("44"));
        Assert.that(actual[4], Is.equalTo("5"));
    }
}