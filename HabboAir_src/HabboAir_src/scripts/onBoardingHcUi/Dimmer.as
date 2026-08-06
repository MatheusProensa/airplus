package onBoardingHcUi
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Dimmer extends Sprite
   {
      private var _fill:BitmapData;
      
      public function Dimmer()
      {
         super();
         var _loc4_:Number = 0.75;
         var _loc3_:Number = 0.06;
         var _loc1_:Number = 1 - (1 - _loc4_) * (1 - _loc3_);
         var _loc2_:uint = 255 * _loc3_ / _loc1_;
         _fill = new BitmapData(2,2,true,uint(_loc4_ * 255) << 24);
         _fill.setPixel32(0,0,(uint(_loc1_ * 255) << 24) + _loc2_ * 65793);
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         stage.removeEventListener("resize",onStageResize);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         stage.addEventListener("resize",onStageResize);
         onStageResize(null);
      }
      
      private function onStageResize(param1:Event) : void
      {
         graphics.clear();
         graphics.beginBitmapFill(_fill);
         graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         graphics.endFill();
         width = stage.stageWidth;
         height = stage.stageHeight;
         x = -(int(width / 2));
         y = -(int(height / 2));
      }
   }
}

