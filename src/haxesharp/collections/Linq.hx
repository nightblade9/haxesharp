package haxesharp.collections;

import haxesharp.exceptions.InvalidOperationException;

/**
 *  LINQ-like extensions for arrays. To use, add: using haxesharp.collections.Linq;
 */
class Linq<T>
{
    public static function take<T>(array:Array<T>, n:Int):Array<T>
    {
        if (n < 0)
        {
            throw new InvalidOperationException('n must be non-negative!');
        }
        else if (n > array.length)
        {
            throw new InvalidOperationException('Cannot take ${n} elements when the array only has ${array.length} elements.');
        }
        else
        {
            var toReturn = new Array<T>();
            for (i in 0 ... n)
            {
                toReturn.push(array[i]);
            }
            return toReturn;
        }        
    }

    public static function where<T>(array:Array<T>, predicate:T->Bool):Array<T>
    {
        var toReturn = new Array<T>();

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