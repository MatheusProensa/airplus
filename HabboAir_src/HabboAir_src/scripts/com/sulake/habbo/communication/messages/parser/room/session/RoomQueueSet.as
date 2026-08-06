package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class RoomQueueSet
   {
      private var _name:String;
      
      private var _target:int;
      
      private var _queues:Map;
      
      public function RoomQueueSet(param1:String, param2:int)
      {
         super();
         _name = param1;
         _target = param2;
         _queues = new Map();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get target() : int
      {
         return _target;
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

