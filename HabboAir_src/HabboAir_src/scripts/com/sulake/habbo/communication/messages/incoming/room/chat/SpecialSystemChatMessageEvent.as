package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.SpecialSystemChatMessageParser;
   
   [SecureSWF(rename="true")]
   public class SpecialSystemChatMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SpecialSystemChatMessageEvent(param1:Function)
      {
         super(param1,SpecialSystemChatMessageParser);
      }
      
      public function getParser() : SpecialSystemChatMessageParser
      {
         return _parser as SpecialSystemChatMessageParser;
      }
   }
}

