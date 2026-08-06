package com.sulake.room.events
{
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class RoomObjectEvent extends Event
   {
      private var _object:IRoomObject;
      
      public function RoomObjectEvent(param1:String, param2:IRoomObject, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _object = param2;
      }
      
      public function get object() : IRoomObject
      {
         return _object;
      }
      
      public function get objectId() : int
      {
         if(_object != null)
         {
            return _object.getId();
         }
         return -1;
      }
      
      public function get objectType() : String
      {
         if(_object != null)
         {
            return _object.getType();
         }
         return null;
      }
   }
}

