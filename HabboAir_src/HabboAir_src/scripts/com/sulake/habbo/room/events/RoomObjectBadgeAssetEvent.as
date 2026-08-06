package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectBadgeAssetEvent extends RoomObjectEvent
   {
      public static const LOAD_BADGE:String = "ROGBE_LOAD_BADGE";
      
      private var _badgeId:String;
      
      private var _groupBadge:Boolean;
      
      public function RoomObjectBadgeAssetEvent(param1:String, param2:IRoomObject, param3:String, param4:Boolean = true, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         _badgeId = param3;
         _groupBadge = param4;
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get groupBadge() : Boolean
      {
         return _groupBadge;
      }
   }
}

