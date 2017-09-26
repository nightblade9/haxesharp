// Mostly copy-pasted from thx.core.Error
package haxesharp;

import haxe.PosInfos;
import haxe.CallStack;

/**
Defines a generic Error type. When the target platform is JS, `Error` extends the native
`js.Error` type.
**/
class Exception #if js extends js.Error #end {
#if !js
/**
The text message associated with the error.
**/
  public var message(default, null): String;
#end
/**
The location in code where the error has been instantiated.
**/
  public var pos(default, null): PosInfos;

/**
The collected error stack.
**/
  public var stackItems(default, null): Array<StackItem>;

/**
The constructor only requires a string message. `stack` and `pos` are automatically
populated, but can be provided if preferred.
**/
  public function new(message: String, ?stack: Array<StackItem>, ?pos: PosInfos) {
#if js
    super(message);
#end
    this.message = message;

    if(null == stack) {
      stack = try CallStack.exceptionStack() catch(e: Dynamic) [];
      if(stack.length == 0)
        stack = try CallStack.callStack() catch(e: Dynamic) [];
    }
    this.stackItems = stack;
    this.pos = pos;
  }

  public function toString()
    return message + "\nfrom: " + getPosition() + "\n\n" + stackToString();

  public function getPosition()
    return pos.className + "." + pos.methodName + "() at " + pos.lineNumber;

  public function stackToString()
    return CallStack.toString(stackItems);
}