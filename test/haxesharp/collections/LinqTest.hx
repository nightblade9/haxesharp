package haxesharp.collections;

using haxesharp.collections.Linq;
using haxesharp.exceptions.InvalidOperationException;
using haxesharp.exceptions.ArgumentNullException;
using haxesharp.test.Assert;
using haxesharp.text.StringExtensions;

class LinqTest
{
    @Test
    public function addAddsElement()
    {
        var array = ["one"];
        array.add("two");
        array.add("three");
        array.add("one"); // duplicates. no worries.

        Assert.that(array.length, Is.equalTo(4));
        Assert.that(array.contains("two"));
        Assert.that(array.contains("three"));
    }

    @Test
    public function containsReturnsTrueOrFalseAppropriately()
    {
        var array = ["cat", "dog", "mouse"];
        Assert.that(array.contains("cat"), Is.equalTo(true));
        Assert.that(array.contains("CAT"), Is.equalTo(false)); // not equal strings
        Assert.that(array.contains("hare"), Is.equalTo(false));
    }

    @Test
    public function distinctReturnsUniqueItemsByValueForPrimitiveTypes()
    {
        var array = ["tomato", "carrot", "tomato", "celery", "carrot"];
        var actual = array.distinct();
        Assert.that(actual.length, Is.equalTo(3));
        Assert.that(actual.contains("tomato"));
        Assert.that(actual.contains("carrot"));
        Assert.that(actual.contains("celery"));
    }

    @Test
    public function distinctReturnsUniqueItemsByReferenceForClasses()
    {
        var array = [new Pineapple("Ahmad"), new Pineapple("Muhammad"), new Pineapple("Ahmad")];
        var actual = array.distinct();
        
        Assert.that(actual.length, Is.equalTo(3));
        Assert.that(actual.where((p) => p.name == "Ahmad").length, Is.equalTo(2));
    }

    @Test
    public function firstWithoutPredicateReturnsNullIfNoObjectsExist()
    {
        var a = [];
        var actual = a.first();
        Assert.that(actual, Is.equalTo(null));
    }

    
    @Test
    public function firstWithoutPredicateReturnsFirstObject()
    {
        var a = ["bell pepper", "tomato", "mushroom"];
        var actual = a.first();
        Assert.that(actual, Is.equalTo("bell pepper"));
    }

    @Test
    public function firstReturnsFirstMatchingObject()
    {
        var a = ["bell pepper", "tomato", "mushroom"];
        var actual = a.first((f) => f.length < 7);
        Assert.that(actual, Is.equalTo("tomato"));
    }

    @Test
    public function firstReturnsNullIfNoObjectsMatch()
    {
        var a = ["bell pepper", "tomato", "mushroom"];
        var actual = a.first((f) => f.contains("x"));
        Assert.that(actual, Is.equalTo(null));
    }

    @Test
    public function singleThrowsIfArrayIsNull()
    {
        Assert.throws(ArgumentNullException, (_) => Linq.single(null));
        Assert.throws(ArgumentNullException, (_) => Linq.single(null, (x) => true));
    }

    @Test
    public function singleWithoutPredicateThrowsIfArrayIsEmpty()
    {
        Assert.throws(InvalidOperationException, (_) => [].single());
    }

    @Test
    public function singleWithoutPredicateThrowsIfArrayContainsMultipleElements()
    {
        Assert.throws(InvalidOperationException, (_) => [1,2,3].single());
    }

    @Test
    public function singleWithoutPredicateReturnsTheElementInASingleElementArray()
    {
        Assert.that([1].single(), Is.equalTo(1));
    }

    @Test
    public function singleWithPredicateThrowsIfArrayIsEmpty()
    {
        Assert.throws(InvalidOperationException, (_) => [].single((x) => true));
    }

    @Test
    public function singleWithPredicateThrowsIfNoElementSatisfiesPredicate()
    {
        Assert.throws(InvalidOperationException, (_) => [1,2,3].single((x) => x == 4));
    }

    @Test
    public function singleWithPredicateThrowsIfMultipleElementsSatisfyPredicate()
    {
        Assert.throws(InvalidOperationException, (_) => [1,2,3,2].single((x) => x == 2));
    }

    @Test
    public function singleWithPredicateReturnsTheElementIfOnlyOneElementSatisfiesPredicate()
    {
        Assert.that([1,2,3].single((x) => x == 3), Is.equalTo(3));
    }

    @Test
    public function shuffleReturnsShuffledArray()
    {
        // If I fill an array with 1-10, shuffle, then compare the shuffled
        // integers to the original, there should be some differences. They
        // should never be exactly the same.

        var expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        var actual = expected.shuffle();

        var numChanged = 0;
        for (i in actual)
        {
            if (actual[i] != expected[i])
            {
                numChanged++;
            }
        }

        Assert.that(numChanged > 0);
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
    public function anyReturnsTrueIfAnyElementsMatch()
    {
        var input = ["apple", "pear", "orange"];
        // Only one contains "g"
        Assert.that(input.any((fruit) => fruit.contains("g")), Is.equalTo(true));
        // All three contain "a"
        Assert.that(input.any((fruit) => fruit.contains("a")), Is.equalTo(true));
        Assert.that(input.any((fruit) => fruit.contains("x")), Is.equalTo(false));
    }
    
    @Test
    public function anyReturnsTrueIfAnyElementsExistWhenPredicateIsNull()
    {
        Assert.that(["apple", "pear", "orange"].any(), Is.equalTo(true));
        Assert.that([].any(), Is.equalTo(false));
    }
}

class Pineapple {
    public var name(default, null):String;
    public function new(name:String) {
        this.name = name;
    }
}