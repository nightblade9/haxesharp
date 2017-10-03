package haxesharp.collections;

/**
 *  LINQ-like extensions for arrays. To use, add: using haxesharp.collections.Linq;
 */
class Linq<T>
{
    static public function where<T>(array:Array<T>, predicate:T->Bool):Array<T>
    {
        var toReturn = new Array();

        for (item in array)
        {
            if (predicate(item) == true)
            {
                toReturn.push(item);
            }
        }

        return toReturn;
    }
}