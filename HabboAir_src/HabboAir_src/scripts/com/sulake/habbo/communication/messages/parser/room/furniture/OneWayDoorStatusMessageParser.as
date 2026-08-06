package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OneWayDoorStatusMessageParser implements IMessageParser
   {
      private var _id:int;
      
      private var _status:int;
      
      public function OneWayDoorStatusMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _status = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _id = param1.readInteger();
         _status = param1.readInteger();
         return true;
      }
   }
}

