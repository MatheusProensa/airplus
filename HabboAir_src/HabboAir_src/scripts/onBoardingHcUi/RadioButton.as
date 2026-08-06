package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class RadioButton extends Sprite
   {
      private var radio_button_off_png:Class = radio_button_off_1_png;
      
      private var radio_button_on_png:Class = radio_button_on_1_png;
      
      private var radio_button_off_hitch_png:Class = radio_button_off_hitch_1_png;
      
      private var radio_button_on_hitch_png:Class = radio_button_on_hitch_1_png;
      
      private var _caption:String;
      
      private var _group:RadioButtonGroup;
      
      private var _radioMark:Bitmap;
      
      private var _captionElement:TextField;
      
      private var _selected:Boolean;
      
      private var _skinOn:BitmapData;
      
      private var _skinOff:BitmapData;
      
      private var _unselectedFontColor:uint;
      
      private var _style:int;
      
      public function RadioButton(param1:String, param2:RadioButtonGroup, param3:int = 1, param4:BitmapData = null, param5:BitmapData = null, param6:uint = 0)
      {
         super();
         _caption = param1;
         _group = param2;
         _style = param3;
         mouseChildren = false;
         buttonMode = true;
         _unselectedFontColor = param6;
         var _loc7_:* = param3 == 2;
         _captionElement = LoaderUI.createTextField(_caption,20,param3 == 2 ? 15201722 : 0,true,false,false,_loc7_);
         _captionElement.alpha = param3 == 2 ? 0.7 : 1;
         if(param3 == 1)
         {
            LoaderUI.addEtching(_captionElement);
         }
         switch(param3 - 1)
         {
            case 0:
               _skinOn = param4 ?? Bitmap(new radio_button_on_png()).bitmapData;
               _skinOff = param5 ?? Bitmap(new radio_button_off_png()).bitmapData;
               break;
            case 1:
               _skinOn = param4 ?? Bitmap(new radio_button_on_hitch_png()).bitmapData;
               _skinOff = param5 ?? Bitmap(new radio_button_off_hitch_png()).bitmapData;
         }
         _radioMark = new Bitmap(_skinOff);
         addChild(_radioMark);
         _radioMark.y = int((_captionElement.height - _radioMark.height) / 2);
         _radioMark.alpha = param3 == 2 ? 0.8 : 1;
         addChild(_captionElement);
         _captionElement.x = _radioMark.width + 6;
         if(_group != null && _group.buttons.indexOf(this) < 0)
         {
            _group.buttons.push(this);
         }
         addEventListener("mouseDown",onMouseDown);
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         addEventListener("mouseUp",onMouseUp);
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         removeEventListener("mouseUp",onMouseUp);
         selected = true;
      }
      
      public function get group() : RadioButtonGroup
      {
         return _group;
      }
      
      public function set group(param1:RadioButtonGroup) : void
      {
         if(_group == param1)
         {
            return;
         }
         if(_group != null && _group.buttons.indexOf(this) >= 0)
         {
            _group.buttons.splice(_group.buttons.indexOf(this),1);
         }
         _group = param1;
         selected = false;
      }
      
      public function setUnselectedFontColor(param1:uint) : void
      {
         _unselectedFontColor = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected && _group != null)
         {
            for each(var _loc2_ in _group.buttons)
            {
               if(_loc2_ != this)
               {
                  _loc2_.selected = false;
                  if(_unselectedFontColor)
                  {
                     _loc2_._captionElement.textColor = _unselectedFontColor;
                     _loc2_._captionElement.alpha = 0.6;
                  }
               }
               else
               {
                  _loc2_._captionElement.textColor = _style == 2 ? 15201722 : 0;
                  _loc2_._captionElement.alpha = 0.7;
               }
            }
            _group.performSelectedAction();
         }
         _radioMark.bitmapData = _selected ? _skinOn : _skinOff;
      }
   }
}

