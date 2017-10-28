package haxesharp.collections.dictionarystrategy;

import haxe.ds.StringMap;

@:dox(hide)
class StringKeyDictionaryStrategy<K, V> implements IDictionaryStrategy<K, V>
{
    private var data:StringMap<V>;

    public function new()
    {
         this.data = new haxe.ds.StringMap<V>();
    }

    public function get(key:K):V
    {
        var castKey:String = cast key;
        return this.data.get(castKey);
    }

    public function set(key:K, value:V):Void
    {
        var castKey:String = cast key;
        this.data.set(castKey, value);
    }

    public function remove(key:K):Bool
    {
        var castKey:String = cast key;
        return this.data.remove(castKey);
    }

    public function containsKey(key:K):Bool
    {
        var castKey:String = cast key;
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