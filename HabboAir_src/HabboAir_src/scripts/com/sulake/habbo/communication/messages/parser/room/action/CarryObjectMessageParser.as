package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CarryObjectMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _itemType:int;
      
      public function CarryObjectMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get itemType() : int
      {
         return _itemType;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         _itemType = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _itemType = param1.readInteger();
         return true;
      }
   }
}

