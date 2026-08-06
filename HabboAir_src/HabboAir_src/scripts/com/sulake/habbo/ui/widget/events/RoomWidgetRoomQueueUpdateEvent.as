package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const VISITOR_QUEUE_STATUS:String = "RWRQUE_VISITOR_QUEUE_STATUS";
      
      public static const SPECTATOR_QUEUE_STATUS:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
      
      private var _position:int;
      
      private var _hasHabboClub:Boolean;
      
      private var _isActive:Boolean;
      
      private var _isClubQueue:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         _position = param2;
         _hasHabboClub = param3;
         _isActive = param4;
         _isClubQueue = param5;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return _hasHabboClub;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get isClubQueue() : Boolean
      {
         return _isClubQueue;
      }
   }
}

