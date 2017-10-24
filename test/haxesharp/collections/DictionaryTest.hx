package haxesharp.collections;

using haxesharp.collections.Dictionary;
using haxesharp.test.Assert;
using haxesharp.exceptions.ArgumentException;
using haxesharp.exceptions.ArgumentNullException;
using haxesharp.exceptions.KeyNotFoundException;

class DictionaryTest
{
    @Test
    public function dictionaryAllowsIntKeys()
    {
        testDictionaryGetSetAndRemove(1, 1, 7);
        testDictionaryMapConstructor([
            1 => 1,
            2 => 2,
            3 => 3
        ]);
    }

    @Test
    public function dictionaryAllowsStringKeys()
    {
        testDictionaryGetSetAndRemove("foo", "bar", "key that doesn't exist");
        testDictionaryMapConstructor([
            "1" => 1,
            "2" => 2,
            "3" => 3
        ]);
    }

    @Test
    public function dictionaryAllowsEnumValueKeys()
    {
        testDictionaryGetSetAndRemove(TestEnum.OneValue, 1, TestEnum.TwoValue);
        testDictionaryMapConstructor([
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
        testDictionaryMapConstructor([
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

        try
        {
            testKeyNotFoundDictionary.get(2);
            Assert.fail("testKeyNotFoundDictionary.get(2) did not throw!");
        }
        catch (e:KeyNotFoundException)
        {
            //Pass
        }
    }

    @Test
    public function addThrowsArgumentExceptionOnDuplicateKey()
    {
        var key = 1;
        var value = 1;
        var testAdd = new Dictionary<Int,Int>();
        testAdd.add(key, value);

        try
        {
            testAdd.add(key, value);
            Assert.fail('2nd Dictionary.add(${key}, ${value}) did not throw!');
        }
        catch (e:ArgumentException)
        {
            //Pass
        }
    }

    @Test
    public function setThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        try
        {
            dictionary.set(null, 1);
        }
        catch (e:ArgumentNullException)
        {
            //Pass
        }
    }

    @Test
    public function getThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        try
        {
            dictionary.get(null);
        }
        catch (e:ArgumentNullException)
        {
            //Pass
        }
    }

    @Test
    public function containsKeyThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        try
        {
            dictionary.containsKey(null);
        }
        catch (e:ArgumentNullException)
        {
            //Pass
        }
    }

    @Test
    public function removeThrowsArgumentNullExceptionOnNullKey()
    {
        var dictionary = new Dictionary<Int,Int>(); 

        try
        {
            dictionary.remove(null);
        }
        catch (e:ArgumentNullException)
        {
            //Pass
        }
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
        var dictionary = new Dictionary<Int,Int>();

        // dictionary starts empty
        Assert.that(dictionary.count(), Is.equalTo(0));

        dictionary[1] = 1;

        Assert.that(dictionary.count(), Is.equalTo(1));

        dictionary[1] = 2;
        // count is still 1
        Assert.that(dictionary.count(), Is.equalTo(1));
        
        dictionary.remove(2);
        // count is still 1
        Assert.that(dictionary.count(), Is.equalTo(1));

        dictionary.remove(1);
        Assert.that(dictionary.count(), Is.equalTo(0));
    }

    private function testDictionaryGetSetAndRemove<K,V>(key:K, value:V, keyToNotFind:K)
    {
        // test get/set and remove
        var testGetSetDictionary = new Dictionary<K,V>();
        testGetSetDictionary.set(key, value);

        // try to remove key that isn't present
        Assert.that(testGetSetDictionary.remove(keyToNotFind), Is.equalTo(false));
        
        Assert.that(testGetSetDictionary.get(key), Is.equalTo(value));
        // try to remove key that is present
        Assert.that(testGetSetDictionary.remove(key), Is.equalTo(true));
        // the removed key should no longer exist in the Dictionary
        Assert.that(testGetSetDictionary.containsKey(key), Is.equalTo(false));

        // test indexer get/set
        var testIndexerDictionary = new Dictionary<K,V>();
        testIndexerDictionary[key] = value; // allows for indexer access

        Assert.that(testIndexerDictionary[key], Is.equalTo(value));
    }

    private function testDictionaryMapConstructor<K,V>(map:Map<K,V>)
    {
        new Dictionary(map);
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