package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateMessageMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateMessageMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UpdateMessageMessageEvent(param1:Function)
      {
         super(param1,UpdateMessageMessageParser);
      }
      
      public function getParser() : UpdateMessageMessageParser
      {
         return this._parser as UpdateMessageMessageParser;
      }
   }
}

