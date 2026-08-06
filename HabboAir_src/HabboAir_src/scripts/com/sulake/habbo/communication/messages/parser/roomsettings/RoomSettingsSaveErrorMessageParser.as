package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsSaveErrorMessageParser implements IMessageParser
   {
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_4:int = 4;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_5:int = 5;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_6:int = 6;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_7:int = 7;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_8:int = 8;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_9:int = 9;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_10:int = 10;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_11:int = 11;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_12:int = 12;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_13:int = 13;
      
      public static const UnknownConstFromRoomSettingsSaveErrorMessageParser_Int_14:int = 16;
      
      private var _roomId:int;
      
      private var _errorCode:int;
      
      private var _info:String;
      
      public function RoomSettingsSaveErrorMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         _errorCode = param1.readInteger();
         _info = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
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
      
      public function get info() : String
      {
         return _info;
      }
   }
}

