package com.sulake.habbo.communication.messages.incoming.users
{
   [SecureSWF(rename="true")]
   public class SelectedBadgeData
   {
      private var _badgeIndex:int;
      
      private var _badgeCode:String;
      
      private var _ownerCount:int;
      
      private var _badgeRarityId:int;
      
      public function SelectedBadgeData(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         _badgeIndex = param1;
         _badgeCode = param2;
         _ownerCount = param3;
         _badgeRarityId = param4;
      }
      
      public function get badgeIndex() : int
      {
         return _badgeIndex;
      }
      
      public function get slotIndex() : int
      {
         return _badgeIndex - 1;
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

