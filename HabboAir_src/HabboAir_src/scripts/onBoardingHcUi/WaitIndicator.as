package onBoardingHcUi
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class WaitIndicator extends Sprite implements IComponentInterfaceQueue
   {
      private static const DOT_COUNT:int = 8;
      
      private var _disposed:Boolean;
      
      private var _style:int;
      
      public function WaitIndicator(param1:int)
      {
         var _loc4_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc6_:Number = NaN;
         super();
         _style = param1;
         var _loc3_:Number = 4294967295;
         var _loc2_:BitmapData = new BitmapData(4,4,true,0);
         _loc2_.setVector(new Rectangle(0,0,4,4),new <uint>[0,_loc3_,_loc3_,0,_loc3_,_loc3_,_loc3_,_loc3_,_loc3_,_loc3_,_loc3_,_loc3_,0,_loc3_,_loc3_,0]);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc5_ = new Bitmap(_loc2_);
            addChild(_loc5_);
            _loc6_ = param1 == 1 ? 12 : 8;
            _loc5_.x = int(_loc6_ * Math.sin(_loc4_ * 3.141592653589793 * 2 / 8)) - 3;
            _loc5_.y = int(_loc6_ * Math.cos(_loc4_ * 3.141592653589793 * 2 / 8)) - 3;
            _loc4_++;
         }
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function circleShade(param1:int) : ColorTransform
      {
         var _loc2_:Number = param1 / 8 - getTimer() * 0.001;
         _loc2_ -= Math.floor(_loc2_);
         _loc2_ = _style == 1 ? 48 + 192 * _loc2_ / 255 : _loc2_;
         return _style == 1 ? new ColorTransform(_loc2_,_loc2_,_loc2_) : new ColorTransform(1,1,1,_loc2_);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         stage.addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         graphics.clear();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            getChildAt(_loc2_).transform.colorTransform = circleShade(_loc2_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(stage != null)
         {
            stage.removeEventListener("enterFrame",onEnterFrame);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

