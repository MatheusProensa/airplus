package com.sulake.habbo.room.utils
{
   import com.sulake.room.object.IRoomObjectController;
   
   [SecureSWF(rename="true")]
   public class RoomObjectFurniIconImageAssetListener
   {
      private var _object:IRoomObjectController;
      
      public function RoomObjectFurniIconImageAssetListener(param1:IRoomObjectController)
      {
         super();
         _object = param1;
      }
      
      public function get object() : IRoomObjectController
      {
         return _object;
      }
   }
}

