package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.HabboUserBadgesMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboUserBadgesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function HabboUserBadgesMessageEvent(param1:Function)
      {
         super(param1,HabboUserBadgesMessageParser);
      }
      
      public function get selectedBadges() : Array
      {
         return (_parser as HabboUserBadgesMessageParser).selectedBadges;
      }
      
      public function get userId() : int
      {
         return (_parser as HabboUserBadgesMessageParser).userId;
      }
   }
}

