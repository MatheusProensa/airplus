package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SellablePetPalettesParser implements IMessageParser
   {
      private var _productCode:String = "";
      
      private var _sellablePalettes:Array = [];
      
      public function SellablePetPalettesParser()
      {
         super();
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get sellablePalettes() : Array
      {
         return _sellablePalettes.slice();
      }
      
      public function flush() : Boolean
      {
         _productCode = "";
         _sellablePalettes = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _productCode = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _sellablePalettes.push(new SellablePetPaletteData(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

