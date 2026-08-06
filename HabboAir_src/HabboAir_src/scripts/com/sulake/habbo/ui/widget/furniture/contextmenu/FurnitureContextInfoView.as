package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextInfoView extends ButtonMenuView
   {
      protected var _roomObject:IRoomObject;
      
      protected var UnknownVarFromFurnitureContextInfoView_String_1:String;
      
      public function FurnitureContextInfoView(param1:UnknownIHabboUiWidgetContextmenu1)
      {
         super(param1);
      }
      
      public static function setup(param1:FurnitureContextInfoView, param2:IRoomObject, param3:String = "") : void
      {
         param1._roomObject = param2;
         param1.UnknownVarFromFurnitureContextInfoView_String_1 = param3;
         setupContext(param1);
      }
      
      protected function get roomObject() : IRoomObject
      {
         return _roomObject;
      }
      
      override public function dispose() : void
      {
         _roomObject = null;
         super.dispose();
      }
   }
}

