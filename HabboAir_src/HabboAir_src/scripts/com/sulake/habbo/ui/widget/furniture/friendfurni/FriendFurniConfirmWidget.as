package com.sulake.habbo.ui.widget.furniture.friendfurni
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FriendFurniConfirmWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class FriendFurniConfirmWidget extends RoomWidgetBase
   {
      private var _stuffId:int = -1;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromFriendFurniConfirmWidget_Int_1:int = -1;
      
      public function FriendFurniConfirmWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         confirmWidgetHandler.widget = this;
      }
      
      override public function dispose() : void
      {
         _stuffId = -1;
         destroyWindow();
         super.dispose();
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _window;
      }
      
      public function open(param1:int, param2:Boolean) : void
      {
         if(_window && _window.visible && _stuffId != -1)
         {
            confirmWidgetHandler.sendLockConfirm(_stuffId,false);
            destroyWindow();
         }
         _stuffId = param1;
         createWindow();
         if(!param2)
         {
            _window.findChildByName("other_locked_container").height = 0;
         }
         else
         {
            _window.findChildByName("other_locked_container").height = UnknownVarFromFriendFurniConfirmWidget_Int_1;
            _window.findChildByName("message").visible = false;
         }
         mainWindow.visible = true;
      }
      
      public function close(param1:int) : void
      {
         if(param1 == _stuffId)
         {
            destroyWindow();
         }
      }
      
      public function otherConfirmed(param1:int) : void
      {
         if(_window != null && param1 == _stuffId)
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("lock")).assetUri = "${image.library.url}furniextras/locked_image.png";
            _window.findChildByName("message").visible = true;
         }
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IFrameController(windowManager.buildFromXML(XML(assets.getAssetByName("lock_confirm_xml").content)));
         _window.procedure = windowProcedure;
         UnknownVarFromFriendFurniConfirmWidget_Int_1 = _window.findChildByName("other_locked_container").height;
         _window.center();
      }
      
      private function destroyWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function get confirmWidgetHandler() : FriendFurniConfirmWidgetHandler
      {
         return FriendFurniConfirmWidgetHandler(_widgetHandler);
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "cancel_button":
                  confirmWidgetHandler.sendLockConfirm(_stuffId,false);
                  destroyWindow();
                  break;
               case "confirm_button":
                  confirmWidgetHandler.sendLockConfirm(_stuffId,true);
                  destroyWindow();
            }
         }
      }
   }
}

