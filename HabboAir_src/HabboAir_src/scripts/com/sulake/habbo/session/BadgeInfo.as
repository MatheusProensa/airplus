package com.sulake.habbo.session
{
   import flash.display.BitmapData;
   
   public class BadgeInfo
   {
      private var _image:BitmapData;
      
      private var _placeHolder:Boolean;
      
      public function BadgeInfo(param1:BitmapData, param2:Boolean)
      {
         super();
         _image = param1;
         _placeHolder = param2;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get placeHolder() : Boolean
      {
         return _placeHolder;
      }
   }
}

