package com.sulake.core.window.graphics.renderer
{
   import flash.geom.Rectangle;
   
   public class SkinTemplateEntity implements ISkinTemplateEntity
   {
      protected var _id:uint;
      
      protected var _name:String;
      
      protected var _type:String;
      
      protected var _region:Rectangle;
      
      public function SkinTemplateEntity(param1:String, param2:String, param3:uint, param4:Rectangle)
      {
         super();
         _id = param3;
         _name = param1;
         _type = param2;
         _region = param4;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get region() : Rectangle
      {
         return _region;
      }
   }
}

