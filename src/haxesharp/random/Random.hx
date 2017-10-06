package haxesharp.random;

import haxesharp.exceptions.Exception;
import de.polygonal.core.math.random.ParkMiller;

/**
A random number generator. No guarantees on anything (don't use it for security!)
*/
class Random
{
    private static inline var MAX_INT:Int = 2147483647; // 2^31 - 1
    private var randomGenerator:ParkMiller;

    /**
     *  Creates a new random number generator. If you specify a seed, that seed gets used.
     */
    public function new(?seed:Int)
    {
        if (seed == null)
        {
            seed = Math.floor(Math.random() * MAX_INT);
        }

        this.randomGenerator = new ParkMiller(seed);
    }

    /**
    - If no parameters are specified, generates a random integer in the range `[0 ... 2^31)` (max is `2^31 - 1`)
    - If only one parameter is specified, generates a random integer in the range `[0 ... n)` (excludes `n`)
    - If two parameters are specified, generates a random integer in the range `[a ... b)` (excludes `b`)
    */
    public function next(?a:Int, ?b:Int):Int
    {
        if (a == null && b == null)
        {
            return Math.floor(this.randomGenerator.randomFloat() * MAX_INT);
        }
        else if (a != null && b == null)
        {
            if (a >= 0)
            {
                return Math.floor(this.randomGenerator.randomFloat() * a);
            }
            else
            {
                throw new Exception('rand(a) requires a >= 0; was: ${a}');
            }
        }
        else if (a != null && b != null)
        {
            var min:Int = a < b ? a : b;
            var max:Int = min == a ? b : a;
            var diff:Int = max - min;
            return Math.floor(this.randomGenerator.randomFloat() * diff) + min;
        }
        else
        {
            throw new Exception("Invalid use of random.next");
        }
    }
}