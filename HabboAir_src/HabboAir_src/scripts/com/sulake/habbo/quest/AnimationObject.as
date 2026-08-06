package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public interface AnimationObject extends IComponentInterfaceQueue
   {
      function getPosition(param1:int) : Point;
      
      function getBitmap(param1:int) : BitmapData;
      
      function isFinished(param1:int) : Boolean;
      
      function onAnimationStart() : void;
   }
}

