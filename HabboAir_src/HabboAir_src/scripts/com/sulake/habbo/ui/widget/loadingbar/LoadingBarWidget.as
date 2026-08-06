package com.sulake.habbo.ui.widget.loadingbar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class LoadingBarWidget extends RoomWidgetBase
   {
      private var _window:UnknownICoreWindowComponents6;
      
      private var _config:IComponent_1;
      
      private var UnknownVarFromLoadingBarWidget_BitmapData_1:BitmapData;
      
      private var UnknownVarFromLoadingBarWidget_String_1:String = "";
      
      private var UnknownVarFromLoadingBarWidget_Sprite_1:Sprite = null;
      
      public function LoadingBarWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1)
      {
         super(param1,param2,param3,param4);
         _config = param5;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromLoadingBarWidget_Sprite_1 != null)
         {
            UnknownVarFromLoadingBarWidget_Sprite_1.removeEventListener("click",clickHandler);
            UnknownVarFromLoadingBarWidget_Sprite_1 = null;
         }
         if(UnknownVarFromLoadingBarWidget_BitmapData_1 != null)
         {
            UnknownVarFromLoadingBarWidget_BitmapData_1.dispose();
            UnknownVarFromLoadingBarWidget_BitmapData_1 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _config = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWLBUE_SHOW_LOADING_BAR",onShowLoadingBar);
         param1.addEventListener("RWLBUW_HIDE_LOADING_BAR",onHideLoadingBar);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWLBUE_SHOW_LOADING_BAR",onShowLoadingBar);
         param1.removeEventListener("RWLBUW_HIDE_LOADING_BAR",onShowLoadingBar);
         param1.removeEventListener("RWLBUW_HIDE_LOADING_BAR",onHideLoadingBar);
      }
      
      private function onShowLoadingBar(param1:RoomWidgetLoadingBarUpdateEvent) : void
      {
         if(param1 == null || param1.type != "RWLBUE_SHOW_LOADING_BAR")
         {
            return;
         }
         if(!createWindow())
         {
            return;
         }
         _window.visible = true;
         _window.center();
      }
      
      private function onHideLoadingBar(param1:RoomWidgetLoadingBarUpdateEvent) : void
      {
         if(param1 == null || param1.type != "RWLBUW_HIDE_LOADING_BAR")
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function createWindow() : Boolean
      {
         var _loc4_:int = 0;
         if(_window != null)
         {
            return true;
         }
         var _loc2_:XmlAsset = assets.getAssetByName("room_loading_bar") as XmlAsset;
         if(_loc2_ == null)
         {
            return false;
         }
         _window = windowManager.buildFromXML(_loc2_.content as XML) as UnknownICoreWindowComponents6;
         if(_window == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc3_:IRegionWindow = _window.findChildByName("region") as IRegionWindow;
         if(_loc3_ != null)
         {
         }
         var _loc1_:IDisplayObjectWrapperController = _window.findChildByName("image") as IDisplayObjectWrapperController;
         if(_loc1_ != null)
         {
            _loc4_ = int(_loc1_.height);
            _window.scale(0,-_loc4_);
         }
         return true;
      }
      
      private function clickHandler(param1:Event) : void
      {
         if(UnknownVarFromLoadingBarWidget_String_1 != "")
         {
            HabboWebTools.openWebPage(UnknownVarFromLoadingBarWidget_String_1);
         }
      }
   }
}

