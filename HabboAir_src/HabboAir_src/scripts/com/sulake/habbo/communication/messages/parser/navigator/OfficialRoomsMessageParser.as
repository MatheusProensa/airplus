package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
   import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.PromotedRoomsData;
   
   [SecureSWF(rename="true")]
   public class OfficialRoomsMessageParser implements IMessageParser
   {
      private var _data:OfficialRoomsData;
      
      private var _adRoom:OfficialRoomEntryData;
      
      private var _promotedRooms:PromotedRoomsData;
      
      public function OfficialRoomsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new OfficialRoomsData(param1);
         var _loc2_:int = param1.readInteger();
         if(_loc2_ > 0)
         {
            _adRoom = new OfficialRoomEntryData(param1);
         }
         _promotedRooms = new PromotedRoomsData(param1);
         return true;
      }
      
      public function get data() : OfficialRoomsData
      {
         return _data;
      }
      
      public function get adRoom() : OfficialRoomEntryData
      {
         return _adRoom;
      }
      
      public function get promotedRooms() : PromotedRoomsData
      {
         return _promotedRooms;
      }
   }
}

