package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.Dictionary.InternalKeyType;
import haxesharp.collections.dictionarystrategy.EnumKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.IDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.IntegerKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.ObjectKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.StringKeyDictionaryStrategy;
import haxesharp.exceptions.InvalidOperationException;
using haxesharp.test.Assert;

class DictionaryStrategyFactoryTest
{
    @Test
    public function createCreatesIntegerKeyDictionaryStrategyWithIntegerParameter()
    {
        var actual = DictionaryStrategyFactory.create(InternalKeyType.Integer);
        Assert.that(Type.getClass(actual) == IntegerKeyDictionaryStrategy);
    }

    @Test
    public function createCreatesEnumKeyDictionaryStrategyWithEnumParameter()
    {
        var actual = DictionaryStrategyFactory.create(InternalKeyType.Enum);
        Assert.that(Type.getClass(actual) == EnumKeyDictionaryStrategy);
    }

    @Test
    public function createCreatesStringKeyDictionaryStrategyWithStringParameter()
    {
        var actual = DictionaryStrategyFactory.create(InternalKeyType.String);
        Assert.that(Type.getClass(actual) == StringKeyDictionaryStrategy);
    }

    @Test
    public function createCreateObjectKeyDictionaryStrategyWithObjectParameter()
    {
        var actual = DictionaryStrategyFactory.create(InternalKeyType.Object);
        Assert.that(Type.getClass(actual) == ObjectKeyDictionaryStrategy);
    }

    @Test
    public function createThrowsWithInvalidParameter()
    {
        var keyType:InternalKeyType = cast "Invalid";
        Assert.throws(InvalidOperationException, (_) => {
            var ds = DictionaryStrategyFactory.create(keyType);
        });
    }
}