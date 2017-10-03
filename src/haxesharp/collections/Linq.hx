package haxesharp.collections;

import haxesharp.random.Random;
import haxesharp.exceptions.InvalidOperationException;

/**
 *  LINQ-like extensions for arrays. To use, add: using haxesharp.collections.Linq;
 */
class Linq<T>
{
    /**
    Returns a copy of the array with elements shuffled. Uses the Fisher-Yates algorithm.
    If desired, you can pass in a random number generator; if not, a new one is generated.
    */
    // Mostly copied from https://stackoverflow.com/a/110570/8641842
    public static function shuffle<T>(array:Array<T>, ?rng:Random)
    {
        if (rng == null)
        {
            rng = new Random();
        }

        // Make a copy of the array
        var toReturn = new Array<T>();
        while (toReturn.length != array.length)
        {
            toReturn.push(array[toReturn.length]);
        }

        // Shuffle
        var n = toReturn.length;
        while (n > 1)
        {
            var k = rng.next(n);
            n--;
            var temp = toReturn[n];
            toReturn[n] = toReturn[k];
            toReturn[k] = temp;
        }

        return toReturn;
    }

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