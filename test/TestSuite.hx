import massive.munit.TestSuite;

import haxesharp.text.StringExtensionsTest;
import haxesharp.text.RegexTest;
import haxesharp.collections.LinqTest;
import haxesharp.collections.DictionaryTest;
import haxesharp.random.RandomTest;
import haxesharp.test.AssertTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(haxesharp.text.StringExtensionsTest);
		add(haxesharp.text.RegexTest);
		add(haxesharp.collections.LinqTest);
		add(haxesharp.collections.DictionaryTest);
		add(haxesharp.random.RandomTest);
		add(haxesharp.test.AssertTest);
	}
}
