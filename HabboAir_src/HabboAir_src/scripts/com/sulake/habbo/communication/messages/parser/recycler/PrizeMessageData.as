package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class PrizeMessageData
   {
      private var UnknownVarFromPrizeMessageData_Int_1:int = 1;
      
      private var _productCode:String;
      
      private var _subProducts:Array;
      
      private var _productItemType:String;
      
      private var _productItemTypeId:int;
      
      public function PrizeMessageData(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         _subProducts = [];
         super();
         _productCode = param1.readString();
         §_-yM§ = param1.readInteger();
         if(!isDeal)
         {
            _productItemType = param1.readString();
            _productItemTypeId = param1.readInteger();
         }
         else
         {
            while(_loc2_ < §_-yM§)
            {
               _subProducts.push(new PrizeMessageSubProduct(param1));
               _loc2_++;
            }
         }
      }
      
      public function get productItemType() : String
      {
         return _productItemType;
      }
      
      public function get productItemTypeId() : int
      {
         return _productItemTypeId;
      }
      
      public function get isDeal() : Boolean
      {
         return §_-yM§ > 1;
      }
      
      public function get subProducts() : Array
      {
         return _subProducts;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
   }
}

