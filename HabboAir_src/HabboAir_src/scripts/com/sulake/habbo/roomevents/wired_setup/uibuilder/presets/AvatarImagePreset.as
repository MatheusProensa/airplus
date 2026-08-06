package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class AvatarImagePreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var _avatarWidget:IAvatarImageWidget;
      
      public function AvatarImagePreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("avatar_image_view") as IWindowController_1;
         var _loc4_:IWidgetWindowController = _container.findChildByName("avatar_image") as IWidgetWindowController;
         if(_loc4_ != null)
         {
            _avatarWidget = _loc4_.widget as IAvatarImageWidget;
         }
      }
      
      public function set figure(param1:String) : void
      {
         if(_avatarWidget != null)
         {
            _avatarWidget.figure = param1;
         }
      }
      
      public function get figure() : String
      {
         return _avatarWidget?.figure;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
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
         _avatarWidget = null;
      }
   }
}

