package haxesharp.exceptions;

/**
The exception that is thrown when a null reference is passed to a method that does not accept it as a valid argument.
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
            message = "Argument was null.";
        }

        super(message);
    }
}