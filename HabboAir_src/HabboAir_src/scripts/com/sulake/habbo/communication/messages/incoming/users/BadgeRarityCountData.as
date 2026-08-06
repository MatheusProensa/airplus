package com.sulake.habbo.communication.messages.incoming.users
{
   [SecureSWF(rename="true")]
   public class BadgeRarityCountData
   {
      private var _rarityId:int;
      
      private var _count:int;
      
      public function BadgeRarityCountData(param1:int, param2:int)
      {
         super();
         _rarityId = param1;
         _count = param2;
      }
      
      public function get rarityId() : int
      {
         return _rarityId;
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}

