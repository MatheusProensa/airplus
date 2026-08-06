package com.sulake.habbo.communication.messages.parser.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.LiftedRoomData;
   
   [SecureSWF(rename="true")]
   public class NavigatorLiftedRoomsParser implements IMessageParser
   {
      private var _liftedRooms:Vector.<LiftedRoomData>;
      
      public function NavigatorLiftedRoomsParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _liftedRooms = new Vector.<LiftedRoomData>();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _liftedRooms.push(new LiftedRoomData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get liftedRooms() : Vector.<LiftedRoomData>
      {
         return _liftedRooms;
      }
   }
}

