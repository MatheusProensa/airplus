package com.sulake.habbo.room.utils
{
   import com.sulake.room.object.IRoomObjectController;
   
   [SecureSWF(rename="true")]
   public class RoomObjectBadgeImageAssetListener
   {
      private var _object:IRoomObjectController;
      
      private var _groupBadge:Boolean;
      
      public function RoomObjectBadgeImageAssetListener(param1:IRoomObjectController, param2:Boolean)
      {
         super();
         _object = param1;
         _groupBadge = param2;
      }
      
      public function get object() : IRoomObjectController
      {
         return _object;
      }
      
      public function get groupBadge() : Boolean
      {
         return _groupBadge;
      }
   }
}

