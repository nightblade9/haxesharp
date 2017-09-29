package haxesharp.exceptions;

class InvalidOperationException extends Exception
{
    public function new(?message:String)
    {
        if (message == null)
        {
            message = "The method call is invalid for the object's current state.";
        }

        super(message);
    }
}