package haxesharp.collections.dictionarystrategy;

import haxesharp.collections.Dictionary.InternalKeyType;
import haxesharp.collections.dictionarystrategy.EnumKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.IDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.IntegerKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.ObjectKeyDictionaryStrategy;
import haxesharp.collections.dictionarystrategy.StringKeyDictionaryStrategy;
import haxesharp.exceptions.InvalidOperationException;

@:dox(hide)
class DictionaryStrategyFactory
{
    public static function create<K, V>(typeOf:InternalKeyType):IDictionaryStrategy<K, V>
    {
        switch (typeOf) {
            case InternalKeyType.Integer:
                return new IntegerKeyDictionaryStrategy();
            case InternalKeyType.Enum:
                return new EnumKeyDictionaryStrategy();
            case InternalKeyType.String:
                return new StringKeyDictionaryStrategy();
            case InternalKeyType.Object:
                return new ObjectKeyDictionaryStrategy();
            default:
                throw new InvalidOperationException('Key type ${typeOf} is not supported');
        }
    }
}