package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserRemoveMessageParser implements IMessageParser
   {
      private var _id:int = 0;
      
      public function UserRemoveMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function flush() : Boolean
      {
         _id = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _id = int(param1.readString());
         return true;
      }
   }
}

