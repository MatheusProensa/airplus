package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomThumbnailUpdateResultMessageParser implements IMessageParser
   {
      private var _flatId:int;
      
      private var _resultCode:int;
      
      public function RoomThumbnailUpdateResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         this._resultCode = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}

