package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.dictionarystrategy.IntegerKeyDictionaryStrategy;
using haxesharp.collections.Linq;
using haxesharp.test.Assert;

class IntegerKeyDictionaryStrategyTest
{
    @Test
    public function getGetsSetKey()
    {
        var expected = "Delicious";
        var d = new IntegerKeyDictionaryStrategy();
        d.set(123, expected);
        Assert.that(d.get(123), Is.equalTo(expected));
    }

    @Test
    public function getGetsNullIfKeyIsNotSet()
    {
        var d = new IntegerKeyDictionaryStrategy();
        Assert.that(d.get(999), Is.equalTo(null));
    }       

    @Test
    public function setOverwritesKey()
    {
        var expected = "Yum";
        var d = new IntegerKeyDictionaryStrategy();
        d.set(768, "FAIL");
        d.set(768, expected);
        Assert.that(d.get(768), Is.equalTo(expected));
    }
    
    @Test
    public function containsKeyReturnsTrueForExistingKeys()
    {
        var d = new IntegerKeyDictionaryStrategy();
        d.set(111, "Tasty");
        Assert.that(d.containsKey(111));
        Assert.that(d.containsKey(222), Is.equalTo(false));
    }

    @Test
    public function removeRemovesKey()
    {
        var d = new IntegerKeyDictionaryStrategy();
        d.set(-17, "Celery");
        d.remove(-17);
        Assert.that(d.containsKey(-17), Is.equalTo(false));
        Assert.that(d.get(-17), Is.equalTo(null));
    }

    @Test
    public function removeDoesNotThrowIfKeyDoesntExist()
    {
        var d = new IntegerKeyDictionaryStrategy();
        d.remove(-99);
    }

    @Test
    public function keysGetsAllKeys()
    {
        var d = new IntegerKeyDictionaryStrategy();
        d.set(128, "Celery");
        d.set(-127, "Tasty");

        var actual = d.keys();
        Assert.that(actual.length, Is.equalTo(2));
        Assert.that(actual.contains(128));
        Assert.that(actual.contains(-127));
        Assert.that(actual.contains(0), Is.equalTo(false));
    }
}