package haxesharp.collections;

using haxesharp.collections.Linq;
using haxesharp.exceptions.InvalidOperationException;
using haxesharp.test.Assert;

class LinqTest
{
    @Test
    public function whereReturnsArrayOfMatchingItems()
    {
        var input = ["one", "two", "three"];
        var output = input.where((s) => s.indexOf("o") > -1);
        Assert.that(output.length, Is.equalTo(2));
        Assert.that(output[0], Is.equalTo("one"));
        Assert.that(output[1], Is.equalTo("two"));
    }

    @Test
    public function whereReturnsEmptyArrayIfNothingMatches()
    {
        var input = ["one", "two", "three"];
        var empty = input.where((s) => s.length == 4);
        Assert.that(empty.length, Is.equalTo(0));
    }

    @Test
    public function takeTakesNEelementsFromTheStartOfTheArray()
    {
        var input = ["apple", "bag", "cat", "dog", "egg"];
        var actual = input.take(2);
        Assert.that(actual[0], Is.equalTo("apple"));
        Assert.that(actual[1], Is.equalTo("bag"));
    }

    @Test
    public function takeReturnsEmptyArrayIfNIsZero()
    {
        var input = [1, 2, 3];
        var actual = input.take(0);
        Assert.that(actual.length, Is.equalTo(0));
    }

    @Test
    public function takeThrowsIfNIsNegative()
    {
        var input = [1, 2];
        try
        {
            input.take(-1);
            Assert.fail("array.take(-1) didn't throw!");
        }
        catch (e:InvalidOperationException)
        {
            // Pass
        }
    }

    @Test
    public function takeThrowsIfNIsBiggerThanTheArray()
    {
        var input = [1, 2];
        try
        {
            input.take(10);
            Assert.fail("array.take didn't throw when N was larger than the array!");
        }
        catch (e:InvalidOperationException)
        {
            // Pass
        }
    }
}