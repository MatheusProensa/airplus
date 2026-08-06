package com.sulake.habbo.communication.messages.parser.room.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraSnapshotMessageParser implements IMessageParser
   {
      private var _roomType:String = "";
      
      private var _roomId:int = 0;
      
      public function CameraSnapshotMessageParser()
      {
         super();
      }
      
      public function get roomType() : String
      {
         return _roomType;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function flush() : Boolean
      {
         _roomType = "";
         _roomId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomType = param1.readString();
         _roomId = param1.readInteger();
         return true;
      }
   }
}

