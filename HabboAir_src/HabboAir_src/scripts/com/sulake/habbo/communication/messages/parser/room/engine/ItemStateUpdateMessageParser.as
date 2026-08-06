package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemStateUpdateMessageParser implements IMessageParser
   {
      private var _id:int = 0;
      
      private var _itemData:String;
      
      private var _state:int;
      
      public function ItemStateUpdateMessageParser()
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
      
      public function get state() : int
      {
         return _state;
      }
      
      public function flush() : Boolean
      {
         _id = 0;
         _itemData = "";
         _state = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _id = param1.readInteger();
         _itemData = param1.readString();
         _state = 0;
         var _loc2_:Number = parseFloat(_itemData);
         if(!isNaN(_loc2_))
         {
            _state = int(_itemData);
         }
         return true;
      }
   }
}

