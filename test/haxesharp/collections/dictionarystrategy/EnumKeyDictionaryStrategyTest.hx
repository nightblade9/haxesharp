package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.dictionarystrategy.EnumKeyDictionaryStrategy;
using haxesharp.collections.Linq;
using haxesharp.test.Assert;

class EnumKeyDictionaryStrategyTest
{
    @Test
    public function getGetsSetKey()
    {
        var expected = "Delicious";
        var d = new EnumKeyDictionaryStrategy();
        d.set(Vegetables.Turnip, expected);
        Assert.that(d.get(Vegetables.Turnip), Is.equalTo(expected));
    }

    @Test
    public function getGetsNullIfKeyIsNotSet()
    {
        var d = new EnumKeyDictionaryStrategy();
        Assert.that(d.get(Vegetables.Celery), Is.equalTo(null));
    }       

    @Test
    public function setOverwritesKey()
    {
        var expected = "Yum";
        var d = new EnumKeyDictionaryStrategy();
        d.set(Vegetables.Carrot, "FAIL");
        d.set(Vegetables.Carrot, expected);
        Assert.that(d.get(Vegetables.Carrot), Is.equalTo(expected));
    }
    
    @Test
    public function containsKeyReturnsTrueForExistingKeys()
    {
        var d = new EnumKeyDictionaryStrategy();
        d.set(Vegetables.Turnip, "Tasty");
        Assert.that(d.containsKey(Vegetables.Turnip));
        Assert.that(d.containsKey(Vegetables.Carrot), Is.equalTo(false));
    }

    @Test
    public function removeRemovesKey()
    {
        var d = new EnumKeyDictionaryStrategy();
        d.set(Vegetables.Celery, "Celery");
        d.remove(Vegetables.Celery);
        Assert.that(d.containsKey(Vegetables.Celery), Is.equalTo(false));
        Assert.that(d.get(Vegetables.Celery), Is.equalTo(null));
    }

    @Test
    public function removeDoesNotThrowIfKeyDoesntExist()
    {
        var d = new EnumKeyDictionaryStrategy();
        d.remove(Vegetables.Celery);
    }

    @Test
    public function keysGetsAllKeys()
    {
        var d = new EnumKeyDictionaryStrategy();
        d.set(Vegetables.Celery, "Celery");
        d.set(Vegetables.Turnip, "Tasty");
        var actual = d.keys();

        Assert.that(actual.contains(Vegetables.Celery));
        Assert.that(actual.contains(Vegetables.Turnip));
        Assert.that(actual.contains(Vegetables.Carrot), Is.equalTo(false));
    }
}

enum Vegetables
{
    Turnip;
    Carrot;
    Celery;
}