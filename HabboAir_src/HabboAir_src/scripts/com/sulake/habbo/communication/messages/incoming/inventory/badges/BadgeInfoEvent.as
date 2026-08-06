package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeInfoParser;
   
   [SecureSWF(rename="true")]
   public class BadgeInfoEvent extends MessageEvent
   {
      public function BadgeInfoEvent(param1:Function)
      {
         super(param1,BadgeInfoParser);
      }
      
      public function getParser() : BadgeInfoParser
      {
         return _parser as BadgeInfoParser;
      }
   }
}

