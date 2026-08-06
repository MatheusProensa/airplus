package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionCompletedMessageParser implements IMessageParser
   {
      private var _stuffCode:String;
      
      private var _badgeCode:String;
      
      public function AchievementResolutionCompletedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffCode = "";
         _badgeCode = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffCode = param1.readString();
         _badgeCode = param1.readString();
         return true;
      }
      
      public function get stuffCode() : String
      {
         return _stuffCode;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
   }
}

