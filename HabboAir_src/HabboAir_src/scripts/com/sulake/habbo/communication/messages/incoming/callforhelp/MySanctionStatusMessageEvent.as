package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class MySanctionStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function MySanctionStatusMessageEvent(param1:Function)
      {
         super(param1,MySanctionStatusMessageParser);
      }
      
      public function getParser() : MySanctionStatusMessageParser
      {
         return _parser as MySanctionStatusMessageParser;
      }
   }
}

