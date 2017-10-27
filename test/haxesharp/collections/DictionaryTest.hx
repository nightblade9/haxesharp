package haxesharp.collections;

using haxesharp.collections.Dictionary;
using haxesharp.test.Assert;
using haxesharp.exceptions.ArgumentException;
using haxesharp.exceptions.ArgumentNullException;
using haxesharp.exceptions.KeyNotFoundException;
using haxesharp.exceptions.InvalidOperationException;

class DictionaryTest
{
    @Test
    public function dictionaryAllowsIntKeys()
    {
        testDictionaryGetSetAndRemove(1, 1, 7);
        new Dictionary([
            1 => 1,
            2 => 2,
            3 => 3
        ]);
    }

    @Test
    public function dictionaryAllowsStringKeys()
    {
        testDictionaryGetSetAndRemove("foo", "bar", "key that doesn't exist");
        new Dictionary([
            "1" => 1,
            "2" => 2,
            "3" => 3
        ]);
    }

    @Test
    public function dictionaryAllowsEnumValueKeys()
    {
        testDictionaryGetSetAndRemove(TestEnum.OneValue, 1, TestEnum.TwoValue);
        new Dictionary([
            TestEnum.OneValue => 1,
            TestEnum.TwoValue => 2,
            TestEnum.ThreeValue => 3
        ]);
    }

    @Test
    public function dictionaryAllowsObjectKeys()
    {
        // dictionary uses reference equality
        testDictionaryGetSetAndRemove(new TestObject(), 1, new TestObject());
        var obj1 = new TestObject();
        var obj2 = new TestObject();
        var obj3 = new TestObject();
        new Dictionary([
            obj1 => 1,
            obj2 => 2,
            obj3 => 3
        ]);
    }

    @Test
    public function getThrowsKeyNotFoundExceptionWhenKeyDoesNotExist()
    {
        var testKeyNotFoundDictionary = new Dictionary<Int,Int>();
        testKeyNotFoundDictionary.set(1, 1);

        Assert.throws(KeyNotFoundException, (_) => testKeyNotFoundDictionary.get(2));
    }

    @Test
    public function addThrowsArgumentExceptionOnDuplicateKey()
    {
        var key = 1;
        var value = 1;
        var testAdd = new Dictionary<Int,Int>();
        testAdd.add(key, value);

        Assert.throws(ArgumentException, (_) => testAdd.add(key, value));
    }

    @Test
    public function setThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        Assert.throws(ArgumentNullException, (_) => dictionary.set(null, 1));
    }

    @Test
    public function getThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        Assert.throws(ArgumentNullException, (_) => dictionary.get(null));
    }

    @Test
    public function containsKeyThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        Assert.throws(ArgumentNullException, (_) => dictionary.containsKey(null));
    }

    @Test
    public function removeThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 
        Assert.throws(ArgumentNullException, (_) => dictionary.remove(null));
    }

    @Test
    public function keysReturnsAllKeysInTheDictionary()
    {
        var dictionary = new Dictionary([
            1 => 1,
            2 => 2,
            3 => 3
        ]);

        Assert.that(dictionary.keys().length, Is.equalTo(3));
    }

    @Test
    public function valuesReturnsAllValuesInTheDictionary()
    {
        var dictionary = new Dictionary([
            1 => 1,
            2 => 1,
            3 => 1
        ]);

        Assert.that(dictionary.values().length, Is.equalTo(3));
    }

    @Test
    public function clearRemovesAllKeysAndValues()
    {
        var dictionary = new Dictionary([
            1 => 1,
            2 => 1,
            3 => 1
        ]);
        var dictionary2 = dictionary; // shared reference (should also be cleared)
        dictionary.clear();
        Assert.that(dictionary.count(), Is.equalTo(0));
        Assert.that(dictionary2.count(), Is.equalTo(0));
    }

    @Test
    public function dictionaryCountIsAccurate()
    {
        var dictionary = new Dictionary<Int, String>();

        // dictionary starts empty
        Assert.that(dictionary.count(), Is.equalTo(0));

        dictionary.set(1, "one");

        Assert.that(dictionary.count(), Is.equalTo(1));

        dictionary.set(1, "two");
        // count is still 1
        Assert.that(dictionary.count(), Is.equalTo(1));
        
        dictionary.remove(2);
        // count is still 1
        Assert.that(dictionary.count(), Is.equalTo(1));

        dictionary.remove(1);
        Assert.that(dictionary.count(), Is.equalTo(0));
    }

    @Test
    public function getGetsIdenticalValuesSetWithObjectsAsKeys()
    {
        var m1 = new Monster(7);
        var m2 = new Monster(3);
        var m3 = new Monster(3);
        var m4 = new Monster(3);

        var dictionary = new Dictionary<Monster, Int>();
        dictionary.set(m1, 0);
        dictionary.set(m2, 0);
        dictionary.set(m3, 0);
        dictionary.set(m4, 0);
        
        Assert.that(dictionary.get(m1), Is.equalTo(0));
        Assert.that(dictionary.get(m2), Is.equalTo(0));
        Assert.that(dictionary.get(m3), Is.equalTo(0));
        Assert.that(dictionary.get(m4), Is.equalTo(0));
    }

    @Test
    public function setThrowsIfKeyIsFloat()
    {
        var dictionary = new Dictionary<Float, String>();
        Assert.throws(InvalidOperationException, (_) => dictionary.set(1.234, "Fail"));
    }

    private function testDictionaryGetSetAndRemove<K,V>(key:K, value:V, keyToNotFind:K)
    {
        // test get/set and remove
        var dictionary = new Dictionary<K,V>();
        dictionary.set(key, value);

        // try to remove key that isn't present
        Assert.that(dictionary.remove(keyToNotFind), Is.equalTo(false));
        
        Assert.that(dictionary.get(key), Is.equalTo(value));
        // try to remove key that is present
        Assert.that(dictionary.remove(key), Is.equalTo(true));
        
        // the removed key should no longer exist in the Dictionary
        Assert.that(dictionary.containsKey(key), Is.equalTo(false));
    }
}

enum TestEnum
{
    OneValue;
    TwoValue;
    ThreeValue;
}

class TestObject
{
    public function new() { }
}

class Monster
{
    private var value:Int;

    public function new(value:Int)
    {
        this.value = value;
    }
}