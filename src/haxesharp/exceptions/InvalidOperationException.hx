package haxesharp.exceptions;

/**
An exception indicating that an object is in an invalid state for an operation/method call.
*/
class InvalidOperationException extends Exception
{
    /**
    Constructs a new exception. If a message is not specified, the default is used.
    */
    public function new(?message:String)
    {
        if (message == null)
        {
            message = "The method call is invalid for the object's current state.";
        }

        super(message);
    }
}