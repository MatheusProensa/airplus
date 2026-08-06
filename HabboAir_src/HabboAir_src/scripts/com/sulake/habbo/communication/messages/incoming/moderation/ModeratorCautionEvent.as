package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.ModerationCautionParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorCautionEvent extends MessageEvent implements IMessageEvent
   {
      public function ModeratorCautionEvent(param1:Function)
      {
         super(param1,ModerationCautionParser);
      }
      
      public function getParser() : ModerationCautionParser
      {
         return _parser as ModerationCautionParser;
      }
   }
}

