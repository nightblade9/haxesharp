package haxesharp.collections;

import haxesharp.exceptions.ArgumentException;
import haxesharp.exceptions.KeyNotFoundException;
import haxesharp.exceptions.InvalidOperationException;

abstract Dictionary<K,V>(haxe.Constraints.IMap<K, V>)
{
    // Only one of these is used at any given type (depends what K is).
    // We use reflection to determine the type at runtime.
    // We can't determine at compile time, and there's no way
    // to inspect the K type in the constructor, so we're stuck
    // keeping four instances.
    //
    // We also can't easily keep state, i.e. note down somewhere that
    // the key type we're using is X, until we actually get/set a key.
    // There may be some optimization here (eg. keep the key type name
    // as null and set it on first get/set to avoid having to re-check
    // the key types with reflection on every get/set operation).
    private var ints = new haxe.ds.IntMap<V>();
    private var enums = new haxe.ds.EnumValueMap<EnumValue, V>();
    private var strings = new haxe.ds.StringMap<V>();
    private var objects = new haxe.ds.ObjectMap<{}, V>();

    /**
    Constructs an empty Dictionary
    */
    inline public function new(?map:Map<K,V>)
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
    @:arrayAccess
    public function get(key:K):V
    {
        var keyType = definitivelyDetermineType(key);

        if (keyType == InternalKeyType.Integer)
        {
            var intK:Int = cast key;
            return ints.get(intK);
        }
        else if (keyType == InternalKeyType.Enum)
        {
            var enumK:EnumValue = cast key;
            return enums.get(enumK);
        }
        else if (keyType == InternalKeyType.String)
        {
            var stringK:String = cast key;
            return strings.get(stringK);
        }
        else if (keyType == InternalKeyType.Object)
        {
            var constrainedK:{} = cast key;
            return objects.get(constrainedK);
        }
        else
        {
            throw new InvalidOperationException('Invalid key type: ${keyType}');
        }
    }

    /**
    Sets the given key with the given value.
    If the key already exists, the existing value is overwritten.
    */
    @:arrayAccess
    public function set(key:K, value:V)
    {
        var keyType = definitivelyDetermineType(key);
        
        if (keyType == InternalKeyType.Integer)
        {
            var intK:Int = cast key;
            return ints.get(intK);
        }
        else if (keyType == InternalKeyType.Enum)
        {
            var enumK:EnumValue = cast key;
            return enums.get(enumK);
        }
        else if (keyType == InternalKeyType.String)
        {
            var stringK:String = cast key;
            return strings.get(stringK);
        }
        else if (keyType == InternalKeyType.Object)
        {
            var constrainedK:{} = cast key;
            return objects.get(constrainedK);
        }
        else
        {
            throw new InvalidOperationException('Invalid key type: ${keyType}');
        }

        // return value;
    }

    /**
    Sets the given key with the given value.
    If the key already exists, an ArgumentException is thrown.
    */
    public function add(key:K, value:V)
    {
        if (containsKey(key))
        {
            throw new ArgumentException('The key "${key}" is already present in the Dictionary');
        }

        set(key, value);
    }

    /**
    If the key is in the Dictionary, removes it and returns true, otherwise returns false. 
    */
    public function remove(key:K):Bool
    {
        definitivelyDetermineType(key);
        return this.remove(key);
    }

    /**
    Returns true if the Dictionary contains the given key, otherwise returns false.
    */
    public function containsKey(key:K):Bool
    {
        var keyType = this.definitivelyDetermineType(key);
        
        if (keyType == InternalKeyType.Integer)
        {
            var intK:Int = cast key;
            return ints.exists(intK);
        }
        else if (keyType == InternalKeyType.Enum)
        {
            var enumK:EnumValue = cast key;
            return enums.exists(enumK);
        }
        else if (keyType == InternalKeyType.String)
        {
            var stringK:String = cast key;
            return strings.exists(stringK);
        }
        else if (keyType == InternalKeyType.Object)
        {
            var constrainedK:{} = cast key;
            return objects.exists(constrainedK);
        }
        else
        {
            throw new InvalidOperationException('Invalid key type: ${keyType}');
        }
    }

    /**
    Returns true if the Dictionary contains the given value, otherwise returns false.
    */
    public function containsValue(value:V):Bool
    {
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
    public function keys()
    {
        // Can't rely on one of these being null or empty to know if
        // we're actually using that internal dictionary (because we
        // don't know at constructor runtime what K really is).
        // This is hideous, but should work if we only ever use one of
        // these internal dictionaries at a time, ever.
        var toReturn = new Array<Any>();

        for (i in this.ints.keys())
        {
            toReturn.push(i);
        }
        for (s in this.strings.keys())
        {
            toReturn.push(s);
        }
        for (e in this.enums.keys())
        {
            toReturn.push(e);
        }
        for (o in this.objects.keys())
        {
            toReturn.push(o);
        }

        return toReturn;
    }

    /**
    Returns an Array of all the values in the Dictionary
    */
    public function values()
    {
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
        // can't remove from Dictionary while iterating through keys, so retrieve list of all keys here first
        var allKeys = keys();

        for (key in allKeys)
        {
            remove(key);
        }
    }

    /**
    Returns the number of elements in the Dictionary
    Note that this is an O(N) operation.
    */
    public function count()
    {
        return this.keys().length;
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
        if (!this.containsKey(key))
        {
            throw new KeyNotFoundException('The given key (${key}) was not present in the Dictionary.');
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