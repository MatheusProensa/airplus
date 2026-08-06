package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.notifications.AchievementLevelUpData;
   
   [SecureSWF(rename="true")]
   public class HabboAchievementNotificationMessageParser implements IMessageParser
   {
      private var _data:AchievementLevelUpData;
      
      public function HabboAchievementNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new AchievementLevelUpData(param1);
         return true;
      }
      
      public function get data() : AchievementLevelUpData
      {
         return _data;
      }
   }
}

