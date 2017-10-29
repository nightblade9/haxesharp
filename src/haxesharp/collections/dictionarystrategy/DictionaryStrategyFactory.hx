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
        // Tried a switch here but the default never seems to execute
        // Could be related to: https://github.com/HaxeFoundation/haxe/issues/4387
        // Still seems like an issue in Haxe 3.4. If/else works fine.
        if (typeOf == InternalKeyType.Integer)
        {
            return new IntegerKeyDictionaryStrategy();
        }
        else if (typeOf == InternalKeyType.Enum)
        {
            return new EnumKeyDictionaryStrategy();
        }
        else if (typeOf == InternalKeyType.String)
        {
            return new StringKeyDictionaryStrategy();
        }
        else if (typeOf == InternalKeyType.Object)
        {
            return new ObjectKeyDictionaryStrategy();
        }
        else
        {
            throw new InvalidOperationException('Key type ${typeOf} is not supported');
        }
    }
}