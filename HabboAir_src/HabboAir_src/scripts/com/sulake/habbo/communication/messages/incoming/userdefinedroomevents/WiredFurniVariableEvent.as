package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniVariableMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredFurniVariableEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredFurniVariableEvent(param1:Function)
      {
         super(param1,WiredFurniVariableMessageParser);
      }
      
      public function getParser() : WiredFurniVariableMessageParser
      {
         return this._parser as WiredFurniVariableMessageParser;
      }
   }
}

