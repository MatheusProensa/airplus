package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMessageParser implements IMessageParser
   {
      private var _itemId:int = 0;
      
      private var _pickerId:int = -1;
      
      public function ItemRemoveMessageParser()
      {
         super();
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get pickerId() : int
      {
         return _pickerId;
      }
      
      public function flush() : Boolean
      {
         _itemId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _itemId = int(param1.readString());
         _pickerId = param1.readInteger();
         return true;
      }
   }
}

