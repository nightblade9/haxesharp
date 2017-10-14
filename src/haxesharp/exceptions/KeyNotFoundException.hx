package haxesharp.exceptions;

/**
The exception that is thrown when the key specified for accessing an
element in a collectiondoes not match any key in the collection.
**/
class KeyNotFoundException extends Exception
{
    /**
    Constructs a new exception. If a message is not specified, the default is used.
    */
    public function new(?message:String)
    {
        if (message == null)
        {
            message = "The given key was not present in the collection";
        }

        super(message);
    }
}