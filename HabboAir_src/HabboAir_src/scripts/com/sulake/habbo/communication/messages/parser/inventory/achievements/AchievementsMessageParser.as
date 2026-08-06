package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   
   [SecureSWF(rename="true")]
   public class AchievementsMessageParser implements IMessageParser
   {
      private var _achievements:Array;
      
      private var _defaultCategory:String;
      
      public function AchievementsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _achievements = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _achievements = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _achievements.push(new AchievementData(param1));
            _loc3_++;
         }
         _defaultCategory = param1.readString();
         return true;
      }
      
      public function get achievements() : Array
      {
         return _achievements;
      }
      
      public function get defaultCategory() : String
      {
         return _defaultCategory;
      }
   }
}

