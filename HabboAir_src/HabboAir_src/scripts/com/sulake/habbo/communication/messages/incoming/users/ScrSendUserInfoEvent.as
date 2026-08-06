package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendUserInfoEvent extends MessageEvent implements IMessageEvent
   {
      public function ScrSendUserInfoEvent(param1:Function)
      {
         super(param1,ScrSendUserInfoMessageParser);
      }
      
      public function getParser() : ScrSendUserInfoMessageParser
      {
         return this._parser as ScrSendUserInfoMessageParser;
      }
   }
}

