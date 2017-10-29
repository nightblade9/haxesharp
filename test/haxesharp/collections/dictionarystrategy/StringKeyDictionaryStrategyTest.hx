package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.dictionarystrategy.StringKeyDictionaryStrategy;
using haxesharp.collections.Linq;
using haxesharp.test.Assert;

class StringKeyDictionaryStrategyTest
{
    @Test
    public function getGetsSetKey()
    {
        var expected = "Delicious";
        var d = new StringKeyDictionaryStrategy();
        d.set("monkey", expected);
        Assert.that(d.get("monkey"), Is.equalTo(expected));
    }

    @Test
    public function getGetsNullIfKeyIsNotSet()
    {
        var d = new StringKeyDictionaryStrategy();
        Assert.that(d.get("Monkey"), Is.equalTo(null));
    }       

    @Test
    public function setOverwritesKey()
    {
        var expected = "Yum";
        var d = new StringKeyDictionaryStrategy();
        d.set("1234", "FAIL");
        d.set("1234", expected);
        Assert.that(d.get("1234"), Is.equalTo(expected));
    }
    
    @Test
    public function containsKeyReturnsTrueForExistingKeys()
    {
        // also tests case sensitivity
        var d = new StringKeyDictionaryStrategy();
        d.set("key with spaces", "Tasty");
        Assert.that(d.containsKey("key with spaces"));
        Assert.that(d.containsKey("KEY with SPACES"), Is.equalTo(false));
    }

    @Test
    public function removeRemovesKey()
    {
        var d = new StringKeyDictionaryStrategy();
        d.set("tiger", "Celery");
        d.remove("tiger");
        Assert.that(d.containsKey("tiger"), Is.equalTo(false));
        Assert.that(d.get("tiger"), Is.equalTo(null));
    }

    @Test
    public function removeDoesNotThrowIfKeyDoesntExist()
    {
        var d = new StringKeyDictionaryStrategy();
        d.remove("lion");
    }

    @Test
    public function keysGetsAllKeys()
    {
        var d = new StringKeyDictionaryStrategy();
        d.set("polar bear", "Celery");
        d.set("BROWN BEAR", "Tasty");
        
        var actual = d.keys();
        Assert.that(actual.length, Is.equalTo(2));
        Assert.that(actual.contains("polar bear"));
        Assert.that(actual.contains("BROWN BEAR"));
        Assert.that(actual.contains("desert bear?!1"), Is.equalTo(false));
    }
}