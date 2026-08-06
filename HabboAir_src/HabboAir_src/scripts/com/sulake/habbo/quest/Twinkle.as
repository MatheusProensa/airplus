package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class Twinkle implements AnimationObject, IComponentInterfaceQueue
   {
      private static const FRAME_DURATION_IN_MSECS:int = 100;
      
      private static const FRAME_NOT_STARTED:int = -1;
      
      private static const FRAME_FINISHED:int = -2;
      
      private static const FRAME_SEQUENCE:Array = [1,2,3,4,5,6,5,4,3,2,1];
      
      private static const UnknownConstFromTwinkle_Point_1:Point = new Point(44,44);
      
      private var _twinkleImages:TwinkleImages;
      
      private var UnknownVarFromTwinkle_Int_1:int;
      
      private var _position:Point;
      
      public function Twinkle(param1:TwinkleImages, param2:int)
      {
         super();
         _twinkleImages = param1;
         UnknownVarFromTwinkle_Int_1 = param2;
      }
      
      public function dispose() : void
      {
         _twinkleImages = null;
         _position = null;
      }
      
      public function get disposed() : Boolean
      {
         return _twinkleImages == null;
      }
      
      public function onAnimationStart() : void
      {
         _position = new Point(Math.round(Math.random() * UnknownConstFromTwinkle_Point_1.x),Math.round(Math.random() * UnknownConstFromTwinkle_Point_1.y));
      }
      
      public function getPosition(param1:int) : Point
      {
         return _position;
      }
      
      public function isFinished(param1:int) : Boolean
      {
         return getFrame(param1) == -2;
      }
      
      public function getBitmap(param1:int) : BitmapData
      {
         var _loc3_:int = getFrame(param1);
         return _twinkleImages.getImage(FRAME_SEQUENCE[_loc3_]);
      }
      
      private function getFrame(param1:int) : int
      {
         var _loc2_:int = param1 - UnknownVarFromTwinkle_Int_1;
         if(_loc2_ < 0)
         {
            return -1;
         }
         var _loc3_:int = Math.floor(_loc2_ / 100);
         if(_loc3_ >= FRAME_SEQUENCE.length)
         {
            return -2;
         }
         return _loc3_;
      }
   }
}

