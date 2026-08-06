package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMultipleMessageParser implements IMessageParser
   {
      private var _itemIds:Array;
      
      private var _pickerId:int;
      
      public function ItemRemoveMultipleMessageParser()
      {
         super();
      }
      
      public function get itemIds() : Array
      {
         return _itemIds;
      }
      
      public function get pickerId() : int
      {
         return _pickerId;
      }
      
      public function flush() : Boolean
      {
         _itemIds = [];
         _pickerId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = param1.readInteger();
         _itemIds = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            itemIds.push(param1.readInteger());
            _loc3_++;
         }
         _pickerId = param1.readInteger();
         return true;
      }
   }
}

