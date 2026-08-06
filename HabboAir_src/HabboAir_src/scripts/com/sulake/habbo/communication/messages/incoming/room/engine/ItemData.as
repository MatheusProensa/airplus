package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class ItemData
   {
      private var _id:int = 0;
      
      private var _itemData:String;
      
      private var _state:int;
      
      public function ItemData(param1:int, param2:String)
      {
         super();
         _id = param1;
         _itemData = param2;
         var _loc3_:Number = parseFloat(_itemData);
         if(!isNaN(_loc3_))
         {
            _state = int(_itemData);
         }
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
   }
}

