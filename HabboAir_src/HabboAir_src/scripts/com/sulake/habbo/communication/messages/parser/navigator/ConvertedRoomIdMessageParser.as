package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConvertedRoomIdMessageParser implements IMessageParser
   {
      private var _globalId:String;
      
      private var _convertedId:int;
      
      public function ConvertedRoomIdMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _globalId = param1.readString();
         _convertedId = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         _globalId = null;
         return true;
      }
      
      public function get globalId() : String
      {
         return _globalId;
      }
      
      public function get convertedId() : int
      {
         return _convertedId;
      }
   }
}

