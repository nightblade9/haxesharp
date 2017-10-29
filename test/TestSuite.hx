import massive.munit.TestSuite;

import haxesharp.collections.dictionarystrategy.DictionaryStrategyFactoryTest;
import haxesharp.collections.dictionarystrategy.EnumKeyDictionaryStrategyTest;
import haxesharp.collections.DictionaryTest;
import haxesharp.collections.LinqTest;
import haxesharp.random.RandomTest;
import haxesharp.test.AssertTest;
import haxesharp.text.RegexTest;
import haxesharp.text.StringExtensionsTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(haxesharp.collections.dictionarystrategy.DictionaryStrategyFactoryTest);
		add(haxesharp.collections.dictionarystrategy.EnumKeyDictionaryStrategyTest);
		add(haxesharp.collections.DictionaryTest);
		add(haxesharp.collections.LinqTest);
		add(haxesharp.random.RandomTest);
		add(haxesharp.test.AssertTest);
		add(haxesharp.text.RegexTest);
		add(haxesharp.text.StringExtensionsTest);
	}
}
