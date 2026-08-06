package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage
   {
      public static const PREVIEW:String = "RWDPM_PREVIEW_DIMMER_PRESET";
      
      private var _color:uint;
      
      private var _brightness:int;
      
      private var _bgOnly:Boolean;
      
      public function RoomWidgetDimmerPreviewMessage(param1:uint, param2:int, param3:Boolean)
      {
         super("RWDPM_PREVIEW_DIMMER_PRESET");
         _color = param1;
         _brightness = param2;
         _bgOnly = param3;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : int
      {
         return _brightness;
      }
      
      public function get bgOnly() : Boolean
      {
         return _bgOnly;
      }
   }
}

