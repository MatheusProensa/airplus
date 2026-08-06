package com.sulake.habbo.communication.messages.incoming.room.layout
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomOccupiedTilesMessageEvent extends MessageEvent
   {
      public function RoomOccupiedTilesMessageEvent(param1:Function)
      {
         super(param1,RoomOccupiedTilesMessageParser);
      }
      
      public function getParser() : RoomOccupiedTilesMessageParser
      {
         return _parser as RoomOccupiedTilesMessageParser;
      }
   }
}

