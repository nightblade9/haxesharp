import massive.munit.TestSuite;

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

		add(haxesharp.random.RandomTest);
		add(haxesharp.test.AssertTest);
	}
}
