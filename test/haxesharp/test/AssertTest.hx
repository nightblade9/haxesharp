package haxesharp.test;

import haxesharp.test.Assert;
import haxesharp.exceptions.AssertionFailedException;

// Doesn't follow our usual style of using haxesharp's Asserts, because
// we want to make sure these tests fail if there's a problem with our code.
class AssertTest 
{
	@Test
	public function assertThatPassesIfValueIsTrue():Void
	{
		// Doesn't throw
		Assert.that(true);
	}

	@Test
	public function assertThatThrowsIfValueIsFalse():Void
	{
		try
		{
			Assert.that(false);
			throw "Assert.that(false) didn't throw";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
	}

	@Test
	public function assertThatIsEqualToPassesIfValuesAreEqual():Void
	{
		var x = 13;
		var y = 13;

		// Doesn't throw
		Assert.that(x, Is.equalTo(y));
		Assert.that(-1, Is.equalTo(-1));
		Assert.that("whee!", Is.equalTo("whee!"));
	}

	@Test
	public function assertThatIsEqualToThrowsIfValuesDiffer():Void
	{
		try
		{
			Assert.that(1, Is.equalTo(2));
			throw "integer equality passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
		try
		{
			Assert.that("hi", Is.equalTo("he"));
			throw "string equality passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
		var e1 = new EReg(".*", "g");
		var e2 = new EReg("\\d+", "g");

		try
		{
			Assert.that(e1, Is.equalTo(e2));
			throw "object equality passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
	}

	@Test
	public function assertThatIsEqualToThrowsIfArraysAreIdentical():Void
	{

		var a1:Array<Int> = [1, 2, 3];
		var a2:Array<Int> = [1, 2, 3];
		try
		{
			Assert.that(a1, Is.equalTo(a2));
			throw "Array equality passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		catch (e:Any)
		{
			throw 'Assertions should throw an AssertionFailedException but threw a ${Type.getClassName(Type.getClass(e))} instead';
		}
	}

	@Test
	public function assertThatIsNotPassesIfValuesAreDifferent():Void
	{
		var x = 13;
		var y = 14;

		// Doesn't throw
		Assert.that(x, Is.not(y));
		Assert.that(-1, Is.not(1));
		Assert.that("whee!", Is.not("whoo!"));
	}

	@Test
	public function assertThatIsNotThrowsIfValuesAreTheSame():Void
	{
		try
		{
			Assert.that(1, Is.not(1));
			throw "integer negation passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
		try
		{
			Assert.that("hi", Is.not("hi"));
			throw "string negation passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
		var e1 = new EReg(".*", "g");

		try
		{
			Assert.that(e1, Is.not(e1));
			throw "object negation passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		
	}

	@Test
	public function assertThatIsNotThrowsIfArraysAreIdentical():Void
	{

		var a:Array<Int> = [1, 2, 3];
		try
		{
			Assert.that(a, Is.not(a));
			throw "Array negation passed instead of failing";
		}
		catch (e:AssertionFailedException)
		{
			// Pass!
		}
		catch (e:Any)
		{
			throw 'Assertions should throw an AssertionFailedException but threw a ${Type.getClassName(Type.getClass(e))} instead';
		}
	}

	@Test
	public function assertFailFailsImmediatelyWithMessage()
	{
		var expected = "Invalid operationz";

		try
		{
			Assert.fail(expected);
			throw 'Assert.fail did not fail!';
		}
		catch (e:AssertionFailedException)
		{
			// Pass
		}
	}
}