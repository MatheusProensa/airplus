package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GamePlayerValueMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _value:int = 0;
      
      public function GamePlayerValueMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _value = param1.readInteger();
         return true;
      }
   }
}

