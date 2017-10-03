package haxesharp.text;

using haxesharp.test.Assert;
using haxesharp.text.StringExtensions;

class StringExtensionsTest
{
    @Test
    public function containsReturnsTrueOrFalseAppropriately()
    {
        // TODO: unicode testing?
        Assert.that("hello world".contains("o"), Is.equalTo(true));
        Assert.that("true test".contains("e"), Is.equalTo(true));
        Assert.that("negative case".contains("x"), Is.equalTo(false));
        Assert.that("another negative".contains("z"), Is.equalTo(false));
    }
}