package com.sulake.habbo.session.product
{
   public class ProductData implements IProductData
   {
      private var _type:String;
      
      private var _name:String;
      
      private var _description:String = "";
      
      public function ProductData(param1:String, param2:String)
      {
         super();
         _type = param1;
         _name = param2;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _description;
      }
   }
}

