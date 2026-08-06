package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsErrorMessageParser implements IMessageParser
   {
      private var _roomId:int;
      
      private var _errorCode:int;
      
      public function RoomSettingsErrorMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         _errorCode = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         _roomId = 0;
         _errorCode = 0;
         return true;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
   }
}

