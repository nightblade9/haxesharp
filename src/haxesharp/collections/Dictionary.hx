package haxesharp.collections;

import haxesharp.collections.dictionarystrategy.DictionaryStrategyFactory;
import haxesharp.collections.dictionarystrategy.IDictionaryStrategy;
import haxesharp.exceptions.ArgumentException;
import haxesharp.exceptions.ArgumentNullException;
import haxesharp.exceptions.KeyNotFoundException;
import haxesharp.exceptions.InvalidOperationException;

// Ensures all the fields of the concrete class can be accessed from the abstract
@:forward
/**
A dictionary class that can accept arbitrary keys.
Uses efficient storage (`IntMap`, etc.) internally depending on the key type.
**/
abstract Dictionary<K,V>(AbstractDictionary<K,V>)
{
    inline public function new(?map:Map<K,V>)
    {
        this = new AbstractDictionary<K,V>(map);
    }

    @:arrayAccess
    inline public function setValue(key:K, val:V)
    {
        this.set(key, val);
        return val;
    }

    @:arrayAccess
    inline public function getValue(key:K)
    {
        return this.get(key);
    }
}

/**
An internal dictionary type. Required for `Dictionary` to have array accessors.
**/
class AbstractDictionary<K,V>
{
    private var strategy:IDictionaryStrategy<K, V>;

    /**
    Constructs an empty Dictionary.
    */
    inline public function new(?map:Map<K,V> = null)
    {
        if (map != null)
        {
            for (key in map.keys())
            {
                this.set(key, map[key]);
            }
        }
    }

    /**
    Returns the value for the given key.
    If the key is not found, a KeyNotFoundException is thrown.
    */
    public function get(key:K):V
    {
        this.initializeStrategy(key);

        if (!this.containsKey(key))
        {
            throw new KeyNotFoundException('The given key (${key}) was not present in the Dictionary.');
        }

        return this.strategy.get(key);
    }

    /**
    Sets the given key with the given value.
    If the key already exists, the existing value is overwritten.
    */
    public function set(key:K, value:V):Void
    {
        this.initializeStrategy(key);
        return this.strategy.set(key, value);
    }

    /**
    Sets the given key with the given value.
    If the key already exists, an ArgumentException is thrown.
    */
    public function add(key:K, value:V)
    {
        if (this.containsKey(key))
        {
            throw new ArgumentException('The key "${key}" is already present in the Dictionary');
        }

        this.set(key, value);
    }

    /**
    If the key is in the Dictionary, removes it and returns true; otherwise,
    returns false. 
    */
    public function remove(key:K):Bool
    {
        this.initializeStrategy(key);
        return this.strategy.remove(key);
    }

    /**
    Returns true if the Dictionary contains the given key; otherwise, returns false.
    */
    public function containsKey(key:K):Bool
    {
        this.initializeStrategy(key);
        return this.strategy.containsKey(key);
    }

    /**
    Returns true if the Dictionary contains the given value; otherwise returns false.
    */
    public function containsValue(value:V):Bool
    {
        if (this.strategy == null)
        {
            return false;
        }

        for (key in this.keys())
        {
            var v = this.get(key);
            if (v == value)
            {
                return true;
            }
        }

        return false;
    }

    /**
    Returns an Array of all the keys in the Dictionary
    */
    public function keys():Array<K>
    {
        if (this.strategy == null)
        {
           return new Array<K>();
        }

        return this.strategy.keys();
    }

    /**
    Returns an Array of all the values in the Dictionary
    */
    public function values():Array<V>
    {
        if (this.strategy == null)
        {
            return new Array<V>();
        }

        var toReturn = new Array<V>();

        for (key in this.keys())
        {
            toReturn.push(this.get(key));
        }

        return toReturn;
    }

    /**
    Removes all key-value pairs from the Dictionary
    */
    public function clear()
    {
        if (this.strategy != null)
        {
            // can't remove from Dictionary while iterating through keys, so retrieve list of all keys here first
            var allKeys = keys();

            for (key in allKeys)
            {
                this.remove(key);
            }
        }
    }

    /**
    Returns the number of elements in the Dictionary
    Note that this is an O(N) operation.
    */
    public function count()
    {
        if (this.strategy == null)
        {
            return 0;
        }

        return this.keys().length;
    }

    private function initializeStrategy(key:K):Void
    {
        if (this.strategy == null)
        {
            var typeOf = this.definitivelyDetermineType(key);
            this.strategy = DictionaryStrategyFactory.create(typeOf);
        }
    }

    /**
    Given a key type that's only available as a compile-time constant, determine
    what it is at runtime. We use a combination of Type.getType and Type.getClass
    to figure this out.
    
    The actual values are probably internal Haxe implementation details, and may
    change from target to target or at runtime.
    **/
    private inline function definitivelyDetermineType(key:K):InternalKeyType
    {
        if (key == null)
        {
            throw new ArgumentNullException("key");
        }

        var typeOf = Type.typeof(key).getName();
        if (typeOf == "TInt")
        {
            return InternalKeyType.Integer;
        }
        else if (typeOf == "TFloat")
        {
            throw new InvalidOperationException("Keys of type float are not supported. You can use strings instead (eg. '12.381').");
        }
        else if (typeOf == "TEnum")
        {
            return InternalKeyType.Enum;
        }
        else if (typeOf == "TClass")
        {
            var className = Type.getClassName(Type.getClass(key));
            if (className == "String")
            {
                return InternalKeyType.String;
            }
            else
            {
                // Could return className here instead
                return InternalKeyType.Object;
            }
        }
        else
        {
            throw new InvalidOperationException('Keys of type ${typeOf} are not supported.');
        }
    }
}

// Internally supported types of keys.
@:dox(hide)
enum InternalKeyType
{
    Integer;
    Enum;
    String;
    Object;
}