package haxesharp.collections.dictionarystrategy;

// A side-effect of not being able to instantiate something given a generic type T.
// From this, we have four internal dictionaries, and need to do things differently
// based on what the actual key type is, which we know after the first get/set call.
@:dox(hide)
interface IDictionaryStrategy<K, V>
{
    public function get(key:K):V;
    public function set(key:K, value:V):Void;
    public function remove(key:K):Bool;
    public function containsKey(key:K):Bool;
    public function keys():Array<K>;
}