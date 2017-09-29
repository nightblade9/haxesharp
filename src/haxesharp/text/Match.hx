package haxesharp.text;

class Match
{
    public var success(default, null):Bool = false;
    public var groups(default, null):Array<String>;

    public function new(success:Bool, groups:Array<String>)
    {
        this.success = success;
        this.groups = groups;
    }
}