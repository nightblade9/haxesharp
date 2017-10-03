package haxesharp.collections;

using haxesharp.collections.Linq;
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
}