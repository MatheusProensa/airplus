package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeMessageSubProduct
   {
      private var _productItemType:String;
      
      private var _productItemTypeId:int;
      
      public function PrizeMessageSubProduct(param1:IMessageDataWrapper)
      {
         super();
         _productItemType = param1.readString();
         _productItemTypeId = param1.readInteger();
      }
      
      public function get productItemType() : String
      {
         return _productItemType;
      }
      
      public function get productItemTypeId() : int
      {
         return _productItemTypeId;
      }
   }
}

