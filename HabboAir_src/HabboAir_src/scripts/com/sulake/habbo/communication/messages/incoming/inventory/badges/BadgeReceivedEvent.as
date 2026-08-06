package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedParser;
   
   [SecureSWF(rename="true")]
   public class BadgeReceivedEvent extends MessageEvent
   {
      public function BadgeReceivedEvent(param1:Function)
      {
         super(param1,BadgeReceivedParser);
      }
      
      public function getParser() : BadgeReceivedParser
      {
         return _parser as BadgeReceivedParser;
      }
   }
}

