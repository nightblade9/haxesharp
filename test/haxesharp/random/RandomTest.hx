package haxesharp.random;

import haxesharp.test.Assert;
import haxesharp.exceptions.Exception;

class RandomTest
{
    private static inline var NUM_ITERATIONS:Int = 10;

    @Test
    public function nextGeneratesIntegerUpToMaxInt()
    {
        var r =  new Random();
        
        var triesLeft = NUM_ITERATIONS;
        while(triesLeft-- > 0)
        {
            Assert.that(r.next() <= Random.MAX_INT);
            Assert.that(r.next() >= 0);
        }
    }

    @Test
    public function nextGeneratesIntegerUpToN()
    {
        var r = new Random();
        
        var triesLeft = NUM_ITERATIONS;
        while(triesLeft-- > 0)
        {
            Assert.that(r.next(234) < 234);
        }
    }

    @Test
    public function nextThrowsWithNIfNIsNegative()
    {
        var r = new Random();
        try
		{
			r.next(-100);
			throw new Exception("r.next(-n) didn't throw!");
		}
		catch (e:Exception)
		{
			// Pass!
		}
    }

    @Test
    public function nextGeneratesIntegerInRange()
    {
        var r = new Random();
        
        var triesLeft = NUM_ITERATIONS;
        while(triesLeft-- > 0)
        {
            var actual = r.next(10, 100);
            Assert.that(actual >= 10);
            Assert.that(actual < 100);
        }

        var n = r.next(-10, 10);
        Assert.that(n >= -10 && n < 10);

        n = r.next(-100, -200);
        Assert.that(n >= -200 && n < -100);
    }
}