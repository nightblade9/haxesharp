package haxesharp.text;

/**
A class representing a regex match on some string.
**/
class Match
{
    public var success(default, null):Bool = false;
    public var groups(default, null):Array<String>;

    @:dox(hide)
    public function new(success:Bool, groups:Array<String>)
    {
        this.success = success;
        this.groups = groups;
    }
}