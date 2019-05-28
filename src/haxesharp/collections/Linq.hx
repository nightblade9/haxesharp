package haxesharp.collections;

using haxesharp.collections.Linq;
import haxesharp.exceptions.InvalidOperationException;
import haxesharp.exceptions.ArgumentNullException;

/**
 *  LINQ-like extensions for arrays. To use, add: using haxesharp.collections.Linq;
 */
class Linq<T>
{
    /**
     *  For convenience.
     */
    
    public static function add<T>(array:Array<T>, item:T):Void
    {
        array.push(item);
    }

    /**
    Returns true if there are any elements that match the predicate.
    If you pass in a null predicate, checks if there are any elements in the array.
    */
    public static function any<T>(array:Array<T>, ?predicate:T->Bool):Bool
    {
        if (predicate == null)
        {
            return array.length > 0;
        }
        else
        {
            var matchingObjects = array.where(function(object)
            {
                return predicate(object) == true;
            });
            return matchingObjects.length > 0;
        }
    }
    
    /**
    Returns true if the array contains the target item. Uses equality by reference.
    */
    public static function contains<T>(array:Array<T>, object:T):Bool
    {
        return array.indexOf(object) > -1;
    }

    /**
     *  Returns all the unique elements in the array. Uses indexOf/contains under the hood
     *  to check for object equality.
     */
    public static function distinct<T>(array:Array<T>):Array<T>
    {
        var toReturn = new Array<T>();
        for (item in array)
        {
            if (!toReturn.contains(item))
            {
                toReturn.add(item);
            }
        }

        return toReturn;
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
    If a predicate is supplied, returns the only element to satisfy the predicate.  Throws an exception if more than one such element exists.
    If a predicate is not supplied, return the only element in the array.  Throws an exception if the array contains more than one element.
    In both cases, and exception is thrown if the provided array is null.
    */
    public static function single<T>(array:Array<T>, ?predicate:T->Bool):T
    {
        if (array == null)
        {
            throw new ArgumentNullException('"array" argument cannot be null.');
        }

        if (predicate == null)
        {
            if (array.length == 1)
            {
                return array[0];
            }
            else if (array.length == 0)
            {
                throw new InvalidOperationException('"array" length cannot be 0.');
            }
            else
            {
                throw new InvalidOperationException('"array" length cannot be greater than 1.');                
            }
        }
        else
        {
            var found:T = null;
            for (a in array)
            {
                if (predicate(a))
                {
                    if (found == null)
                    {
                        found = a;
                    }
                    else
                    {
                        throw new InvalidOperationException('More than one element satisfies the condition in predicate.');
                    }
                }
            }

            if (found == null)
            {
                throw new InvalidOperationException('No element satisfies the condition in predicate.');
            }

            return found;
        }
    }

    /**
    Returns a copy of the array with elements shuffled. Uses the Fisher-Yates algorithm.
    If desired, you can pass in a random number generator; if not, a new one is generated.
    */
    // Mostly copied from https://stackoverflow.com/a/110570/8641842
    public static function shuffle<T>(array:Array<T>):Array<T>
    {
        // Make a copy of the array
        var toReturn = new Array<T>();
        while (toReturn.length != array.length)
        {
            toReturn.add(array[toReturn.length]);
        }

        // Shuffle
        var n = toReturn.length;
        while (n > 1)
        {
            var k = Math.floor(Math.random() * n);
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
                toReturn.add(array[i]);
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
                toReturn.add(item);
            }
        }

        return toReturn;
    }
}