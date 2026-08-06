package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class ProductDisplayWrapper implements IProductDisplayInfo
   {
      private var UnknownVarFromProductDisplayWrapper_IProduct_1:IProduct;
      
      public function ProductDisplayWrapper(param1:IProduct)
      {
         super();
         UnknownVarFromProductDisplayWrapper_IProduct_1 = param1;
      }
      
      public static function isSupported(param1:String) : Boolean
      {
         return param1 == "chat_style" || param1 == "r";
      }
      
      public function get productTypeId() : int
      {
         switch(UnknownVarFromProductDisplayWrapper_IProduct_1.productType)
         {
            case "chat_style":
               return 9;
            case "r":
               return 6;
            default:
               return 0;
         }
      }
      
      public function get itemTypeId() : String
      {
         return UnknownVarFromProductDisplayWrapper_IProduct_1.extraParam;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get botFigureString() : String
      {
         return UnknownVarFromProductDisplayWrapper_IProduct_1.extraParam;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return undefined;
      }
      
      public function get extraData() : String
      {
         return "";
      }
   }
}

