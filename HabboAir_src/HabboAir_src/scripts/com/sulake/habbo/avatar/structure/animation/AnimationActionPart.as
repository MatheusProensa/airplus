package com.sulake.habbo.avatar.structure.animation
{
   public class AnimationActionPart
   {
      private var _frames:Array;
      
      public function AnimationActionPart(param1:XML)
      {
         var _loc2_:int = 0;
         super();
         _frames = [];
         for each(var _loc3_ in param1.frame)
         {
            _frames.push(new AnimationFrame(_loc3_));
            _loc2_ = parseInt(_loc3_.@repeats);
            if(_loc2_ > 1)
            {
               while(true)
               {
                  _loc2_--;
                  if(_loc2_ <= 0)
                  {
                     break;
                  }
                  _frames.push(_frames[_frames.length - 1]);
               }
            }
         }
      }
      
      public function get frames() : Array
      {
         return _frames;
      }
   }
}

