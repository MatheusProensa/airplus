package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.BanInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class BanInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BanInfoMessageEvent(param1:Function)
      {
         super(param1,BanInfoMessageParser);
      }
      
      public function getParser() : BanInfoMessageParser
      {
         return _parser as BanInfoMessageParser;
      }
   }
}

