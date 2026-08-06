package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModeratorMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ModeratorMessageEvent(param1:Function)
      {
         super(param1,ModeratorMessageParser);
      }
      
      public function getParser() : ModeratorMessageParser
      {
         return _parser as ModeratorMessageParser;
      }
   }
}

