package com.sulake.habbo.ui.widget.furniture.video
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureVimeoDisplayWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import com.vimeo.api.VimeoPlayer;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class VimeoDisplayWidget extends RoomWidgetBase
   {
      private static const UnknownConstFromVimeoDisplayWidget_String_1:String = "9a106b76302cbce891b714afdc6a0c93";
      
      private var UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1:VimeoPlayer;
      
      private var _window:IWindowController_1;
      
      private var _roomObject:IRoomObject;
      
      public function VimeoDisplayWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         ownHandler.widget = this;
      }
      
      private function get ownHandler() : FurnitureVimeoDisplayWidgetHandler
      {
         return _widgetHandler as FurnitureVimeoDisplayWidgetHandler;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _window;
      }
      
      public function show(param1:IRoomObject, param2:Boolean, param3:int) : void
      {
         _roomObject = param1;
         createWindow(param2,param3);
         _window.visible = true;
      }
      
      private function createWindow(param1:Boolean, param2:int) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = windowManager.buildFromXML(XML(assets.getAssetByName("vimeo_viewer_xml").content)) as IWindowController_1;
         _window.findChildByName("video_id_editor").visible = param1;
         _window.findChildByName("video_wrapper").visible = param2 > 0;
         _window.procedure = windowProcedure;
         _window.center();
         var _loc3_:IDisplayObjectWrapperController = IDisplayObjectWrapperController(_window.findChildByName("video_wrapper"));
         UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1 = new VimeoPlayer("9a106b76302cbce891b714afdc6a0c93",param2,_loc3_.width,_loc3_.height);
         _loc3_.setDisplayObject(UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1);
         UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1.addEventListener("mouseUp",onVideoMouseEvent);
         UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1.addEventListener("mouseMove",onVideoMouseEvent);
      }
      
      private function onVideoMouseEvent(param1:MouseEvent) : void
      {
         if(_window != null)
         {
            DisplayObject(param1.target).stage.dispatchEvent(param1);
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         switch(param1.type)
         {
            case "WME_CLICK":
               var _loc4_:* = param2.name;
               if("header_button_close" === _loc4_)
               {
                  hide(_roomObject);
               }
               break;
            case "WE_RESIZE":
               _loc4_ = param2.name;
               if("video_wrapper" === _loc4_)
               {
                  if(UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1 != null)
                  {
                     UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1.setSize(param2.width,param2.height);
                  }
               }
               break;
            case "WKE_KEY_DOWN":
               if(WindowKeyboardEvent(param1).charCode == 13)
               {
                  _loc3_ = int(_window.findChildByName("video_id").caption);
                  ownHandler.setVideo(_roomObject,_loc3_);
                  _window.findChildByName("video_wrapper").visible = _loc3_ > 0;
                  UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1.loadVideo(_loc3_);
               }
         }
      }
      
      public function hide(param1:IRoomObject) : void
      {
         if(_roomObject != param1)
         {
            return;
         }
         if(UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1 != null)
         {
            UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1.destroy();
            UnknownVarFromVimeoDisplayWidget_VimeoPlayer_1 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _roomObject = null;
      }
   }
}

