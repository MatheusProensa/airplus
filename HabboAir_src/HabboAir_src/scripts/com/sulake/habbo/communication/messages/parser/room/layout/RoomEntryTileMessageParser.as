package com.sulake.habbo.communication.messages.parser.room.layout
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryTileMessageParser implements IMessageParser
   {
      private var _x:int;
      
      private var _y:int;
      
      private var _dir:uint;
      
      public function RoomEntryTileMessageParser()
      {
         super();
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get dir() : uint
      {
         return _dir;
      }
      
      public function flush() : Boolean
      {
         _x = 0;
         _y = 0;
         _dir = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _x = param1.readInteger();
         _y = param1.readInteger();
         _dir = param1.readInteger();
         return true;
      }
   }
}

