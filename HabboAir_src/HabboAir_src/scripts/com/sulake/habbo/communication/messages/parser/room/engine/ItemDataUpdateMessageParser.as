package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemDataUpdateMessageParser implements IMessageParser
   {
      private var _id:int = 0;
      
      private var _itemData:String;
      
      public function ItemDataUpdateMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get itemData() : String
      {
         return _itemData;
      }
      
      public function flush() : Boolean
      {
         _id = 0;
         _itemData = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = param1.readString();
         _id = int(_loc2_);
         _itemData = param1.readString();
         return true;
      }
   }
}

