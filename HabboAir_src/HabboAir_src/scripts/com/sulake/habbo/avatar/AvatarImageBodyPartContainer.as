package com.sulake.habbo.avatar
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AvatarImageBodyPartContainer
   {
      private var _image:BitmapData;
      
      private var _regPoint:Point;
      
      private var _offset:Point = new Point(0,0);
      
      private var _isCacheable:Boolean;
      
      private var _faceOffset:Point;
      
      public function AvatarImageBodyPartContainer(param1:BitmapData, param2:Point, param3:Boolean, param4:Point = null)
      {
         super();
         _image = param1;
         _regPoint = param2;
         _isCacheable = param3;
         _faceOffset = param4;
         cleanPoints();
      }
      
      public function get isCacheable() : Boolean
      {
         return _isCacheable;
      }
      
      public function dispose() : void
      {
         if(_image)
         {
            _image.dispose();
         }
         _image = null;
         _regPoint = null;
         _offset = null;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get regPoint() : Point
      {
         return _regPoint.add(_offset);
      }
      
      public function set offset(param1:Point) : void
      {
         _offset = param1;
         cleanPoints();
      }
      
      public function get faceOffset() : Point
      {
         return _faceOffset;
      }
      
      private function cleanPoints() : void
      {
         _regPoint.x = int(_regPoint.x);
         _regPoint.y = int(_regPoint.y);
         _offset.x = int(_offset.x);
         _offset.y = int(_offset.y);
      }
   }
}

