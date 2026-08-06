package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class PlaceholderWidget extends RoomWidgetBase
   {
      private var UnknownVarFromPlaceholderWidget_PlaceholderView_1:PlaceholderView;
      
      public function PlaceholderWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromPlaceholderWidget_PlaceholderView_1 != null)
         {
            UnknownVarFromPlaceholderWidget_PlaceholderView_1.dispose();
            UnknownVarFromPlaceholderWidget_PlaceholderView_1 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
      }
      
      private function onShowEvent(param1:RoomWidgetShowPlaceholderEvent) : void
      {
         showInterface();
      }
      
      private function showInterface() : void
      {
         if(UnknownVarFromPlaceholderWidget_PlaceholderView_1 == null)
         {
            UnknownVarFromPlaceholderWidget_PlaceholderView_1 = new PlaceholderView(assets,windowManager);
         }
         UnknownVarFromPlaceholderWidget_PlaceholderView_1.showWindow();
      }
      
      private function hideInterface() : void
      {
         if(UnknownVarFromPlaceholderWidget_PlaceholderView_1 != null)
         {
            UnknownVarFromPlaceholderWidget_PlaceholderView_1.dispose();
            UnknownVarFromPlaceholderWidget_PlaceholderView_1 = null;
         }
      }
   }
}

