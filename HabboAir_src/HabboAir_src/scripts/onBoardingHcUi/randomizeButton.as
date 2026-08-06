package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class randomizeButton extends Button
   {
      private static const rnd_button_png:Class = rnd_button_2_png;
      
      public function randomizeButton(param1:int, param2:int, param3:Function, param4:uint = 16777215)
      {
         super("",new Rectangle(param1,param2,50,52),false,param3,param4);
      }
      
      override protected function onAddedToStage(param1:Event = null) : void
      {
         super.onAddedToStage(param1);
      }
      
      override protected function get defaultBackground() : DisplayObject
      {
         return new rnd_button_png() as Bitmap;
      }
      
      override protected function get pressedBackground() : DisplayObject
      {
         return new rnd_button_png() as Bitmap;
      }
      
      override protected function get inactiveBackground() : DisplayObject
      {
         return new rnd_button_png() as Bitmap;
      }
      
      override protected function get rolloverBackground() : DisplayObject
      {
         return new rnd_button_png() as Bitmap;
      }
   }
}

