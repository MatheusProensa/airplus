package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class RoomQueueStatusMessageParser implements IMessageParser
   {
      private var _flatId:int = 0;
      
      private var UnknownVarFromRoomQueueStatusMessageParser_Map_1:Map = new Map();
      
      private var _activeTarget:int = 0;
      
      public function RoomQueueStatusMessageParser()
      {
         super();
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get activeTarget() : int
      {
         return _activeTarget;
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromRoomQueueStatusMessageParser_Map_1.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc6_:RoomQueueSet = null;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         UnknownVarFromRoomQueueStatusMessageParser_Map_1.reset();
         _flatId = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc2_ = param1.readString();
            _loc5_ = param1.readInteger();
            if(_loc7_ == 0)
            {
               _activeTarget = _loc5_;
            }
            _loc6_ = new RoomQueueSet(_loc2_,_loc5_);
            _loc3_ = param1.readInteger();
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc6_.addQueue(param1.readString(),param1.readInteger());
               _loc8_++;
            }
            UnknownVarFromRoomQueueStatusMessageParser_Map_1.add(_loc6_.target,_loc6_);
            _loc7_++;
         }
         return true;
      }
      
      public function getQueueSetTargets() : Array
      {
         return UnknownVarFromRoomQueueStatusMessageParser_Map_1.getKeys();
      }
      
      public function getQueueSet(param1:int) : RoomQueueSet
      {
         return UnknownVarFromRoomQueueStatusMessageParser_Map_1.getValue(param1) as RoomQueueSet;
      }
   }
}

