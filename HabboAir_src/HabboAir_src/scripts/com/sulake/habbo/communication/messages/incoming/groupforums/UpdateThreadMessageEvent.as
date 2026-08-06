package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.UpdateThreadMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateThreadMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UpdateThreadMessageEvent(param1:Function)
      {
         super(param1,UpdateThreadMessageParser);
      }
      
      public function getParser() : UpdateThreadMessageParser
      {
         return this._parser as UpdateThreadMessageParser;
      }
   }
}

