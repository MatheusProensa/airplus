package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionQueueEvent extends RoomSessionEvent
   {
      public static const QUEUE_STATUS:String = "RSQE_QUEUE_STATUS";
      
      public static const UnknownConstFromRoomSessionQueueEvent_String_1:String = "c";
      
      public static const QUEUE_TYPE_NORMAL:String = "d";
      
      public static const UnknownConstFromRoomSessionQueueEvent_Int_1:int = 2;
      
      public static const UnknownConstFromRoomSessionQueueEvent_Int_2:int = 1;
      
      private var _name:String;
      
      private var _queueSetTarget:int;
      
      private var _queues:Map;
      
      private var _isActive:Boolean;
      
      private var UnknownVarFromRoomSessionQueueEvent_String_1:String;
      
      public function RoomSessionQueueEvent(param1:IRoomSession, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSQE_QUEUE_STATUS",param1,param5,param6);
         _name = param2;
         _queueSetTarget = param3;
         _queues = new Map();
         _isActive = param4;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get queueSetName() : String
      {
         return _name;
      }
      
      public function get queueSetTarget() : int
      {
         return _queueSetTarget;
      }
      
      public function get queueTypes() : Array
      {
         return _queues.getKeys();
      }
      
      public function getQueueSize(param1:String) : int
      {
         return _queues.getValue(param1);
      }
      
      public function addQueue(param1:String, param2:int) : void
      {
         _queues.add(param1,param2);
      }
   }
}

