package haxesharp.exceptions;

/**
An exception indicating that the given arguments are not valid
*/
class ArgumentException extends Exception
{
    /**
    Constructs a new exception. If a message is not specified, the default is used.
    */
    public function new(?message:String)
    {
        if (message == null)
        {
            message = "Argument was not valid.";
        }

        super(message);
    }
}