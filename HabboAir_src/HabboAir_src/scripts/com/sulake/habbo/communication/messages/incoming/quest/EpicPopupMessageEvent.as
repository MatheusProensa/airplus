package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.EpicPopupMessageParser;
   
   [SecureSWF(rename="true")]
   public class EpicPopupMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function EpicPopupMessageEvent(param1:Function)
      {
         super(param1,EpicPopupMessageParser);
      }
      
      public function getParser() : EpicPopupMessageParser
      {
         return _parser as EpicPopupMessageParser;
      }
   }
}

