package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   
   [SecureSWF(rename="true")]
   public class AchievementMessageParser implements IMessageParser
   {
      private var _achievement:AchievementData;
      
      public function AchievementMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _achievement = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _achievement = new AchievementData(param1);
         return true;
      }
      
      public function get achievement() : AchievementData
      {
         return _achievement;
      }
   }
}

