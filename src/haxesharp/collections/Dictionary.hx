package haxesharp.collections;

import haxe.ds.BalancedTree;
import haxesharp.exceptions.ArgumentException;
import haxesharp.exceptions.ArgumentNullException;
import haxesharp.exceptions.KeyNotFoundException;

/**
 * Represents a collection of keys and values.
 */
@:forward(count)
abstract Dictionary<K,V>(BalancedTree<K,V>)
{
    /**
    Constructs an empty Dictionary
    */
    inline public function new(?map:Map<K,V>)
    {
        this = new BalancedTree<K,V>();

        if (map != null)
        {
            for (key in map.keys())
            {
                set(key, map[key]);
            }
        }
    }

    /**
    Returns the value for the given key.
    If the key is not found, a KeyNotFoundException is thrown.
    */
    @:arrayAccess
    public function get(key:K)
    {
        handleNullKey(key);

        if (!containsKey(key))
        {
            throw new KeyNotFoundException('The given key (${key}) was not present in the Dictionary.');
        }

        return this.get(key);
    }

    /**
    Sets the given key with the given value.
    If the key already exists, the existing value is overwritten.
    */
    @:arrayAccess
    public function set(key:K, value:V)
    {
        handleNullKey(key);
        this.set(key, value);
        return value;
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
    public function remove(key:K)
    {
        handleNullKey(key);
        return this.remove(key);
    }

    /**
    Returns true if the Dictionary contains the given key, otherwise returns false.
    */
    public function containsKey(key:K)
    {
        handleNullKey(key);
        return this.exists(key);
    }

    /**
    Returns true if the Dictionary contains the given value, otherwise returns false.
    */
    public function containsValue(value:V)
    {
        for (existingValue in this)
        {
            if (existingValue == value)
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
        return [
            for (key in this.keys()) { key; }
        ];
    }

    /**
    Returns an Array of all the values in the Dictionary
    */
    public function values()
    {
        return [
            for (value in this) { value; }
        ];
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
    Note that this is an O(N) operation
    */
    public function count()
    {
        var count = 0;
        for (value in this)
        {
            count++;
        }
        return count;
    }

    private inline function handleNullKey(key:K)
    {
        if (key == null)
        {
            throw new ArgumentNullException("key was null");
        }
    }
}