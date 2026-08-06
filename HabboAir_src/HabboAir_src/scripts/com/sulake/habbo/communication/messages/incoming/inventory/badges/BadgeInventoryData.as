package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   [SecureSWF(rename="true")]
   public class BadgeInventoryData
   {
      private var _badgeId:int;
      
      private var _badgeCode:String;
      
      private var _ownerCount:int;
      
      private var _badgeRarityId:int;
      
      public function BadgeInventoryData(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         _badgeId = param1;
         _badgeCode = param2;
         _ownerCount = param3;
         _badgeRarityId = param4;
      }
      
      public function get badgeId() : int
      {
         return _badgeId;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get ownerCount() : int
      {
         return _ownerCount;
      }
      
      public function get badgeRarityId() : int
      {
         return _badgeRarityId;
      }
   }
}

