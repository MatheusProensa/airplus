package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class ColouredButton extends Button
   {
      public static const BUTTON_RED:String = "red";
      
      public static const BUTTON_GREEN:String = "gfreen";
      
      public static const BUTTON_YELLOW:String = "yellow";
      
      private static const button_green_png:Class = button_skin_green_1_png;
      
      private static const button_green_pressed_png:Class = button_skin_green_pressed_1_png;
      
      private static const button_green_inactive_png:Class = button_skin_green_inactive_1_png;
      
      private static const button_green_rollover_png:Class = button_skin_green_rollover_1_png;
      
      private static const button_red_png:Class = button_skin_pink_1_png;
      
      private static const button_red_pressed_png:Class = button_skin_pink_pressed_1_png;
      
      private static const button_red_rollover_png:Class = button_skin_pink_rollover_1_png;
      
      private static const button_red_inactive_png:Class = button_skin_pink_inactive_1_png;
      
      private static const button_yellow_png:Class = button_skin_yellow_1_png;
      
      private static const button_yellow_pressed_png:Class = button_skin_yellow_pressed_1_png;
      
      private static const button_yellow_rollover_png:Class = button_skin_yellow_rollover_1_png;
      
      private static const button_yellow_inactive_png:Class = button_skin_yellow_inactive_1_png;
      
      private static const icon_hc:Class = hc_small_1_png;
      
      private var defaultBg:DisplayObject;
      
      private var pressedBg:DisplayObject;
      
      private var inactiveBg:DisplayObject;
      
      private var rolloverBg:DisplayObject;
      
      private var _icon:Bitmap;
      
      public function ColouredButton(param1:String, param2:String, param3:Rectangle, param4:Boolean, param5:Function, param6:uint = 16777215)
      {
         switch(param1)
         {
            case "red":
               defaultBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_png()).bitmapData,new Rectangle(8,10,6,4));
               pressedBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_pressed_png()).bitmapData,new Rectangle(8,10,6,4));
               inactiveBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_inactive_png()).bitmapData,new Rectangle(8,10,6,4));
               rolloverBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_red_rollover_png()).bitmapData,new Rectangle(8,10,6,4));
               break;
            case "gfreen":
               defaultBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_png()).bitmapData,new Rectangle(8,10,6,4));
               pressedBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_pressed_png()).bitmapData,new Rectangle(8,10,6,4));
               inactiveBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_inactive_png()).bitmapData,new Rectangle(8,10,6,4));
               rolloverBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_green_rollover_png()).bitmapData,new Rectangle(8,10,6,4));
               break;
            case "yellow":
               defaultBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_png()).bitmapData,new Rectangle(8,10,6,4));
               pressedBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_pressed_png()).bitmapData,new Rectangle(8,10,6,4));
               inactiveBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_inactive_png()).bitmapData,new Rectangle(8,10,6,4));
               rolloverBg = LoaderUI.createScale9GridShapeFromImage(Bitmap(new button_yellow_rollover_png()).bitmapData,new Rectangle(8,10,6,4));
               _icon = Bitmap(new icon_hc());
         }
         super(param2,param3,param4,param5,param6);
      }
      
      override protected function get defaultBackground() : DisplayObject
      {
         return defaultBg;
      }
      
      override protected function get pressedBackground() : DisplayObject
      {
         return pressedBg;
      }
      
      override protected function get inactiveBackground() : DisplayObject
      {
         return inactiveBg;
      }
      
      override protected function get rolloverBackground() : DisplayObject
      {
         return rolloverBg;
      }
      
      override protected function get etching() : Boolean
      {
         return false;
      }
      
      override protected function get padding() : int
      {
         return 64;
      }
      
      override protected function get textColour() : uint
      {
         return 16777215;
      }
      
      override protected function get icon() : Bitmap
      {
         return _icon;
      }
   }
}

