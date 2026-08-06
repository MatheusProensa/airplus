package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CanCreateRoomMessageParser implements IMessageParser
   {
      public static const UnknownConstFromCanCreateRoomMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromCanCreateRoomMessageParser_Int_2:int = 1;
      
      private var _resultCode:int;
      
      private var _roomLimit:int;
      
      public function CanCreateRoomMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._resultCode = param1.readInteger();
         this._roomLimit = param1.readInteger();
         return true;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get roomLimit() : int
      {
         return _roomLimit;
      }
   }
}

