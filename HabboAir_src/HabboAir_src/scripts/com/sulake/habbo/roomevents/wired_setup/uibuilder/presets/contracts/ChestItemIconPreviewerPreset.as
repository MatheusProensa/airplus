package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.ChestItemTypeRenderableWrapper;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class ChestItemIconPreviewerPreset extends WiredUIPreset
   {
      private var _window:UnknownICoreWindowComponents6;
      
      private var _item:ChestItemType;
      
      public function ChestItemIconPreviewerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _window = param3.createProductIconPreviewer();
         (widgetWindow.widget as IProductIconWidget).unknownImageUri = "";
      }
      
      public function set item(param1:ChestItemType) : void
      {
         _item = param1;
         var _loc2_:ChestItemTypeRenderableWrapper = null;
         if(param1 != null)
         {
            _loc2_ = new ChestItemTypeRenderableWrapper(param1);
         }
         (widgetWindow.widget as IProductIconWidget).productInfo = _loc2_;
      }
      
      public function get item() : ChestItemType
      {
         return _item;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _window.width;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
      }
      
      private function get widgetWindow() : IWidgetWindowController
      {
         return _window.findChildByName("icon_preview") as IWidgetWindowController;
      }
   }
}

