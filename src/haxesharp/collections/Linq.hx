package haxesharp.collections;

import haxesharp.random.Random;
import haxesharp.exceptions.InvalidOperationException;

/**
 *  LINQ-like extensions for arrays. To use, add: using haxesharp.collections.Linq;
 */
class Linq<T>
{
    /**
    Returns true if the array contains the target item. Uses equality by reference.
    */
    public static function contains<T>(array:Array<T>, object:T):Bool
    {
        return array.indexOf(object) > -1;
    }

    /**
    If a predicate is supplied, returns the first element matching the predicate (or null if none are found).
    If a predicate is not supplied, returns the first element in the array (or null).
    */
    public static function first<T>(array:Array<T>, ?predicate:T->Bool):T
    {
        if (predicate == null)
        {
            return array[0];
        }
        else
        {
            for (a in array)
            {
                if (predicate(a))
                {
                    return a;
                }
            }

            return null;
        }
    }

    /**
    Returns a copy of the array with elements shuffled. Uses the Fisher-Yates algorithm.
    If desired, you can pass in a random number generator; if not, a new one is generated.
    */
    // Mostly copied from https://stackoverflow.com/a/110570/8641842
    public static function shuffle<T>(array:Array<T>, ?rng:Random):Array<T>
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

    /**
    Takes N elements from the start of the array and returns them in a new array.
    Throws if N is invalid (non-negative, bigger than the array, etc.)
    */
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

    /**
    Returns a new array containing all items that match the predicate.
    If no items match, you get back an empty array.
    */
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