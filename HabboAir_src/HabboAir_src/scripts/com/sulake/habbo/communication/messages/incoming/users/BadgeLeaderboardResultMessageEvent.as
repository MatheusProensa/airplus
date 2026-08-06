package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BadgeLeaderboardResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class BadgeLeaderboardResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BadgeLeaderboardResultMessageEvent(param1:Function)
      {
         super(param1,BadgeLeaderboardResultMessageParser);
      }
      
      public function getParser() : BadgeLeaderboardResultMessageParser
      {
         return _parser as BadgeLeaderboardResultMessageParser;
      }
   }
}

