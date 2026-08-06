package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ColorButton extends Button
   {
      private static const button_coloritem_png:Class = color_chip_round_default_1_png;
      
      private static const button_color_hover_png:Class = color_chip_round_press_1_png;
      
      private static const button_color_selected_png:Class = color_chip_round_selected_1_png;
      
      private static const button_color_inside_png:Class = color_round_chip_in_1_png;
      
      private var _index:int = 0;
      
      private var _club:Boolean = false;
      
      private var _color:Number = -1;
      
      private var _mainSprite:Sprite;
      
      private var _colorBmd:BitmapData;
      
      public function ColorButton(param1:int, param2:int, param3:Function, param4:uint = 16777215, param5:Number = 16777215)
      {
         _color = param5;
         super("",new Rectangle(param1,param2,44,46),false,param3,param4);
      }
      
      public function setColor(param1:Number) : void
      {
         _color = param1;
         _mainSprite = new Sprite();
         var _loc2_:BitmapData = new button_color_inside_png().bitmapData;
         var _loc3_:ColorTransform = new ColorTransform();
         _loc3_.color = param1;
         _loc2_.colorTransform(new Rectangle(0,0,_loc2_.width,_loc2_.height),_loc3_);
         _colorBmd = _loc2_;
      }
      
      override protected function onAddedToStage(param1:Event = null) : void
      {
         super.onAddedToStage(param1);
         if(_color > 0)
         {
            setColor(_color);
         }
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set club(param1:Boolean) : void
      {
         _club = param1;
      }
      
      public function get club() : Boolean
      {
         return _club;
      }
      
      override protected function get defaultBackground() : DisplayObject
      {
         var _loc2_:BitmapData = Bitmap(new button_coloritem_png()).bitmapData;
         var _loc1_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,_color);
         _loc1_.copyPixels(_colorBmd,_colorBmd.rect,new Point(0,0));
         _loc1_.copyPixels(_loc2_,_loc2_.rect,new Point(0,0),null,null,true);
         return new Bitmap(_loc1_);
      }
      
      override protected function get pressedBackground() : DisplayObject
      {
         var _loc2_:BitmapData = Bitmap(new button_color_selected_png()).bitmapData;
         var _loc1_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,_color);
         _loc1_.copyPixels(_colorBmd,_colorBmd.rect,new Point(0,0));
         _loc1_.copyPixels(_loc2_,_loc2_.rect,new Point(0,0),null,null,true);
         return new Bitmap(_loc1_);
      }
      
      override protected function get inactiveBackground() : DisplayObject
      {
         var _loc2_:BitmapData = Bitmap(new button_coloritem_png()).bitmapData;
         var _loc1_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,_color);
         _loc1_.copyPixels(_colorBmd,_colorBmd.rect,new Point(0,0));
         _loc1_.copyPixels(_loc2_,_loc2_.rect,new Point(0,0),null,null,true);
         return new Bitmap(_loc1_);
      }
      
      override protected function get rolloverBackground() : DisplayObject
      {
         var _loc2_:BitmapData = Bitmap(new button_color_hover_png()).bitmapData;
         var _loc1_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,_color);
         _loc1_.copyPixels(_colorBmd,_colorBmd.rect,new Point(0,0));
         _loc1_.copyPixels(_loc2_,_loc2_.rect,new Point(0,0),null,null,true);
         return new Bitmap(_loc1_);
      }
   }
}

