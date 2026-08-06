package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.users.UnknownHabboCommunicationMessagesParserUsers1;
   
   [SecureSWF(rename="true")]
   public class HabboGroupBadgesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function HabboGroupBadgesMessageEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserUsers1);
      }
      
      public function get badges() : Map
      {
         return (_parser as UnknownHabboCommunicationMessagesParserUsers1).badges;
      }
   }
}

