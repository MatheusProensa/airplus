package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   
   [SecureSWF(rename="true")]
   public class ClubGiftSelectedParser implements IMessageParser
   {
      private var _productCode:String;
      
      private var _products:Array;
      
      public function ClubGiftSelectedParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _products = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _products = [];
         _productCode = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _products.push(new CatalogPageMessageProductData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get products() : Array
      {
         return _products;
      }
   }
}

