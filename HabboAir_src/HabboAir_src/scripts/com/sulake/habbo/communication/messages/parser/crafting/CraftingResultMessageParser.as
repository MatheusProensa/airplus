package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftingResultMessageParser implements IMessageParser
   {
      private var _success:Boolean;
      
      private var _productData:FurnitureProductItem;
      
      public function CraftingResultMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _success = param1.readBoolean();
         if(_success)
         {
            _productData = new FurnitureProductItem(param1);
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _success = false;
         return true;
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get productData() : FurnitureProductItem
      {
         return _productData;
      }
   }
}

