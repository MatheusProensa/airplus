package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DiceValueMessageParser implements IMessageParser
   {
      private var _id:int;
      
      private var _value:int;
      
      public function DiceValueMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _value = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _id = param1.readInteger();
         _value = param1.readInteger();
         return true;
      }
   }
}

