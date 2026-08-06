package com.sulake.habbo.communication.messages.parser.advertisement
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomAdErrorMessageParser implements IMessageParser
   {
      private var _errorCode:int = 0;
      
      private var _filteredText:String;
      
      public function RoomAdErrorMessageParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
      
      public function get filteredText() : String
      {
         return _filteredText;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readInteger();
         _filteredText = param1.readString();
         return true;
      }
   }
}

