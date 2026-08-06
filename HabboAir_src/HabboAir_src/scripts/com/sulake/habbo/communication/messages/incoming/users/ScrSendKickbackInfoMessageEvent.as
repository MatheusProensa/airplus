package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendKickbackInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendKickbackInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ScrSendKickbackInfoMessageEvent(param1:Function)
      {
         super(param1,ScrSendKickbackInfoMessageParser);
      }
      
      public function getParser() : ScrSendKickbackInfoMessageParser
      {
         return _parser as ScrSendKickbackInfoMessageParser;
      }
   }
}

