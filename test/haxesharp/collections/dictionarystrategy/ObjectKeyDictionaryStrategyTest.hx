package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.dictionarystrategy.ObjectKeyDictionaryStrategy;
using haxesharp.collections.Linq;
using haxesharp.test.Assert;

class ObjectKeyDictionaryStrategyTest
{
    @Test
    public function getGetsSetKey()
    {
        var expected = "Delicious";
        var d = new ObjectKeyDictionaryStrategy();
        var key = new ValueObject("Monkey");
        d.set(key, expected);
        Assert.that(d.get(key), Is.equalTo(expected));

        // Based on reference, not value
        var wrongKey = new ValueObject("Monkey");
        Assert.that(d.get(wrongKey), Is.equalTo(null));
    }

    @Test
    public function getGetsNullIfKeyIsNotSet()
    {
        var d = new ObjectKeyDictionaryStrategy();
        Assert.that(d.get(new ValueObject(17)), Is.equalTo(null));
    }       

    @Test
    public function setOverwritesKey()
    {
        var expected = "Yum";
        var key = new ValueObject("donkey");
        
        var d = new ObjectKeyDictionaryStrategy();
        d.set(key, "FAIL");
        d.set(key, expected);
        Assert.that(d.get(key), Is.equalTo(expected));
    }
    
    @Test
    public function containsKeyReturnsTrueForExistingKeys()
    {
        var key = new ValueObject("17 boxes!");
        var d = new ObjectKeyDictionaryStrategy();
        d.set(key, "Tasty");
        Assert.that(d.containsKey(key));
        Assert.that(d.containsKey(new ValueObject("17 bananas!")), Is.equalTo(false));
    }

    @Test
    public function removeRemovesKey()
    {
        var d = new ObjectKeyDictionaryStrategy();
        var key = new ValueObject("tiger");
        
        d.set(key, "Celery");
        d.remove(key);
        Assert.that(d.containsKey(key), Is.equalTo(false));
        Assert.that(d.get(key), Is.equalTo(null));
    }

    @Test
    public function removeDoesNotThrowIfKeyDoesntExist()
    {
        var d = new ObjectKeyDictionaryStrategy();
        d.remove("lion");
    }

    @Test
    public function keysGetsAllKeys()
    {
        var d = new ObjectKeyDictionaryStrategy();
        var key1 = new ValueObject("red");
        var key2 = new ValueObject("purple");
        
        d.set(key1, "Celery");
        d.set(key2, "Tasty");
        var actual = d.keys();

        Assert.that(actual.length, Is.equalTo(2));
        Assert.that(actual.contains(key1));
        Assert.that(actual.contains(key2));
    }
}

class ValueObject
{
    private var value:Any;

    public function new(value:Any)
    {
        this.value = value;
    }
}