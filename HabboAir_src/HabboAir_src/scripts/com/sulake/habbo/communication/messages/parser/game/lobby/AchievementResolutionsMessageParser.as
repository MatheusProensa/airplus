package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementResolutionData;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionsMessageParser implements IMessageParser
   {
      private var _stuffId:int;
      
      private var _achievements:Vector.<AchievementResolutionData>;
      
      private var _endTime:int;
      
      public function AchievementResolutionsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         for each(var _loc1_ in _achievements)
         {
            _loc1_.dispose();
         }
         _achievements = new Vector.<AchievementResolutionData>(0);
         _endTime = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _stuffId = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _achievements.push(new AchievementResolutionData(param1));
            _loc2_++;
         }
         _endTime = param1.readInteger();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get achievements() : Vector.<AchievementResolutionData>
      {
         return _achievements;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
   }
}

