package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HeaderPreset extends WiredUIPreset
   {
      public static const UnknownConstFromHeaderPreset_Int_1:int = 0;
      
      public static const UnknownConstFromHeaderPreset_Int_2:int = 1;
      
      public static const BUTTON_MODE_VARIABLE_MENU:int = 2;
      
      public static const UnknownConstFromHeaderPreset_Int_3:int = 3;
      
      private var _buttonMode:int;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromHeaderPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var _button:WiredUIPreset;
      
      protected var _width:int;
      
      public function HeaderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:UnknownIHabboRoomeventsWired_Setup1, param6:int, param7:Function, param8:Function, param9:Function)
      {
         super(param1,param2,param3);
         _buttonMode = param6;
         _container = param2.createLayout("container_view") as IWindowController_1;
         var _loc10_:Array = [];
         var _loc11_:WiredUIPreset = createTopHeaderElement(param4,param5);
         _loc10_.push(_loc11_);
         _button = null;
         if(param6 == 1)
         {
            _button = param2.createTextualButtonPreset(loc("wiredfurni.applysnapshot"),param7);
         }
         else if(param6 == 2)
         {
            _button = param2.createTextualButtonPreset(loc("wiredfurni.view_in_menu"),param8);
         }
         else if(param6 == 3)
         {
            _button = param2.createTextualButtonPreset(loc("wiredfurni.params.write_to_logs.view"),param9);
         }
         if(_button != null)
         {
            _button = _button.alignCenter();
            _loc10_.push(_button);
         }
         UnknownVarFromHeaderPreset_SimpleListViewPreset_1 = param2.createSimpleListView(true,_loc10_);
         _container.addChild(UnknownVarFromHeaderPreset_SimpleListViewPreset_1.window);
         UnknownVarFromHeaderPreset_SimpleListViewPreset_1.window.x = UnknownVarFromWiredUIPreset_WiredStyle_1.headerMargin;
         UnknownVarFromHeaderPreset_SimpleListViewPreset_1.window.y = UnknownVarFromWiredUIPreset_WiredStyle_1.headerMargin;
      }
      
      protected function createTopHeaderElement(param1:String, param2:UnknownIHabboRoomeventsWired_Setup1) : WiredUIPreset
      {
         return null;
      }
      
      public function updateName(param1:String) : void
      {
      }
      
      public function set buttonVisible(param1:Boolean) : void
      {
         if(_button.visible != param1)
         {
            _button.visible = param1;
            resizeToWidth(_width);
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _width = param1;
         var _loc2_:int = UnknownVarFromWiredUIPreset_WiredStyle_1.headerMargin + (_button == null || !_button.visible ? UnknownVarFromWiredUIPreset_WiredStyle_1.headerMargin : UnknownVarFromWiredUIPreset_WiredStyle_1.headerBottomMarginWithLink);
         UnknownVarFromHeaderPreset_SimpleListViewPreset_1.resizeToWidth(param1 - UnknownVarFromWiredUIPreset_WiredStyle_1.headerMargin * 2);
         _container.width = param1;
         _container.height = Util.getLowestPointList(UnknownVarFromHeaderPreset_SimpleListViewPreset_1.window as IItemListWindow) + _loc2_;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromHeaderPreset_SimpleListViewPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromHeaderPreset_SimpleListViewPreset_1 = null;
      }
   }
}

