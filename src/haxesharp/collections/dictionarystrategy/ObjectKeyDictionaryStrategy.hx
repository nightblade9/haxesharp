package haxesharp.collections.dictionarystrategy;

import haxe.ds.ObjectMap;

@:dox(hide)
class ObjectKeyDictionaryStrategy<K, V> implements IDictionaryStrategy<K, V>
{
    private var data:ObjectMap<{}, V>;
    
    public function new()
    {
        this.data = new ObjectMap<{}, V>();        
    }
    public function get(key:K):V
    {
        var castKey:{} = cast key;
        return this.data.get(castKey);
    }

    public function set(key:K, value:V):Void
    {
        var castKey:{} = cast key;
        this.data.set(castKey, value);
    }

    public function remove(key:K):Bool
    {
        var castKey:{} = cast key;
        return this.data.remove(castKey);
    }

    public function containsKey(key:K):Bool
    {
        var castKey:{} = cast key;
        return this.data.exists(castKey);        
    }

    public function keys():Array<K>
    {
        var toReturn = new Array<Any>();

        for (key in this.data.keys())
        {
            toReturn.push(key);
        }
        return cast toReturn;
    }
}