package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.UserChangeMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserChangeMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserChangeMessageEvent(param1:Function)
      {
         super(param1,UserChangeMessageParser);
      }
      
      public function get id() : int
      {
         return (_parser as UserChangeMessageParser).id;
      }
      
      public function get figure() : String
      {
         return (_parser as UserChangeMessageParser).figure;
      }
      
      public function get sex() : String
      {
         return (_parser as UserChangeMessageParser).sex;
      }
      
      public function get customInfo() : String
      {
         return (_parser as UserChangeMessageParser).customInfo;
      }
      
      public function get achievementScore() : int
      {
         return (_parser as UserChangeMessageParser).achievementScore;
      }
      
      public function get badgesRank() : int
      {
         return (_parser as UserChangeMessageParser).badgesRank;
      }
   }
}

