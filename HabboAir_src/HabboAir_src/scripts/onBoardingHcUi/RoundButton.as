package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class RoundButton extends Button
   {
      private static const button_round_png:Class = button_grid_1_png;
      
      private static const button_round_pressed_png:Class = button_grid_selected_inactive_1_png;
      
      private static const button_round_over_png:Class = button_grid_over_1_png;
      
      private static const button_grid_currently_active_png:Class = button_grid_selected_active_1_png;
      
      private var _icon:BitmapData;
      
      public function RoundButton(param1:int, param2:int, param3:Function, param4:uint = 16777215)
      {
         super("",new Rectangle(param1,param2,50,53),false,param3,param4);
      }
      
      public function addIcon(param1:BitmapData) : void
      {
         _icon = param1;
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.x = (width - _loc2_.width) / 2;
         _loc2_.y = (height - _loc2_.height) / 2;
         addChild(_loc2_);
      }
      
      override protected function onAddedToStage(param1:Event = null) : void
      {
         super.onAddedToStage(param1);
         if(_icon)
         {
            addIcon(_icon);
         }
      }
      
      override protected function get defaultBackground() : DisplayObject
      {
         return new button_round_png() as Bitmap;
      }
      
      override protected function get pressedBackground() : DisplayObject
      {
         return new button_round_pressed_png() as Bitmap;
      }
      
      override protected function get inactiveBackground() : DisplayObject
      {
         return new button_round_png() as Bitmap;
      }
      
      override protected function get rolloverBackground() : DisplayObject
      {
         return new button_round_over_png() as Bitmap;
      }
      
      override protected function get currentlyActive() : DisplayObject
      {
         return new button_grid_currently_active_png() as Bitmap;
      }
   }
}

