package com.sulake.habbo.notifications.feed
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.notifications.feed.view.content.FeedEntity;
   import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
   import com.sulake.habbo.notifications.feed.view.pane.AbstractPane;
   import com.sulake.habbo.notifications.feed.view.pane.IAbstractPane;
   import com.sulake.habbo.notifications.feed.view.pane.InfoPane;
   import com.sulake.habbo.notifications.feed.view.pane.NotificationsPane;
   import com.sulake.habbo.notifications.feed.view.pane.SettingsPane;
   import com.sulake.habbo.notifications.feed.view.pane.StatusPane;
   import com.sulake.habbo.notifications.feed.view.pane.StreamPane;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class NotificationView
   {
      public static const VIEW_PANE_FEEDS:String = "pane_feeds";
      
      public static const VIEW_PANE_NOTIFICATIONS:String = "pane_notifications";
      
      public static const VIEW_PANE_STREAM:String = "pane_stream";
      
      public static const VIEW_PANE_SETTINGS:String = "pane_settings";
      
      public static const VIEW_PANE_INFO:String = "pane_info";
      
      public static const VIEW_PANE_STATUS:String = "pane_status";
      
      private static const UnknownConstFromNotificationView_String_1:String = "settings_toggle";
      
      private static const ELEMENT_INFO:String = "info_toggle";
      
      private var UnknownVarFromNotificationView_StateController_1:StateController;
      
      private var UnknownVarFromNotificationView_HabboNotifications_1:HabboNotifications;
      
      private var _controller:NotificationController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromNotificationView_Map_1:Map;
      
      public function NotificationView(param1:NotificationController, param2:HabboNotifications)
      {
         super();
         _controller = param1;
         UnknownVarFromNotificationView_HabboNotifications_1 = param2;
         UnknownVarFromNotificationView_StateController_1 = new StateController();
         FeedEntity.assignHandles(windowManager,assets,localization,param1);
         setupUserInterface();
         closePaneLevel(2);
         switchToPane("pane_notifications");
         setVisibilityState(1);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromNotificationView_Map_1)
         {
            for each(var _loc1_ in UnknownVarFromNotificationView_Map_1)
            {
               _loc1_.dispose();
            }
            UnknownVarFromNotificationView_Map_1.dispose();
            UnknownVarFromNotificationView_Map_1 = null;
         }
         FeedEntity.removeHandles();
         _controller = null;
         UnknownVarFromNotificationView_StateController_1 = null;
         UnknownVarFromNotificationView_HabboNotifications_1 = null;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return UnknownVarFromNotificationView_HabboNotifications_1.windowManager;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return UnknownVarFromNotificationView_HabboNotifications_1.assets;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromNotificationView_HabboNotifications_1.localization;
      }
      
      public function get controller() : NotificationController
      {
         return _controller;
      }
      
      private function setupUserInterface() : void
      {
         if(_window)
         {
            return;
         }
         _window = UnknownVarFromNotificationView_HabboNotifications_1.windowManager.buildFromXML(UnknownVarFromNotificationView_HabboNotifications_1.assets.getAssetByName("feed_display_xml").content as XML) as IWindowController_1;
         _window.height = _window.desktop.height;
         _window.setParamFlag(64);
         _window.setParamFlag(2048);
         _window.findChildByName("settings_toggle").addEventListener("WME_CLICK",onSettingsToggle);
         _window.findChildByName("info_toggle").addEventListener("WME_CLICK",onInfoToggle);
         UnknownVarFromNotificationView_Map_1 = new Map();
         UnknownVarFromNotificationView_Map_1.add("pane_notifications",new NotificationsPane("pane_notifications",this,_window.findChildByName("pane_notifications") as IWindowController_1));
         UnknownVarFromNotificationView_Map_1.add("pane_stream",new StreamPane("pane_stream",this,_window.findChildByName("pane_stream") as IWindowController_1));
         UnknownVarFromNotificationView_Map_1.add("pane_info",new InfoPane("pane_info",this,_window.findChildByName("pane_info") as IWindowController_1));
         UnknownVarFromNotificationView_Map_1.add("pane_settings",new SettingsPane("pane_settings",this,_window.findChildByName("pane_settings") as IWindowController_1));
         UnknownVarFromNotificationView_Map_1.add("pane_status",new StatusPane("pane_status",this,_window.findChildByName("pane_status") as IWindowController_1));
      }
      
      public function toggleMinimized() : void
      {
         switch(UnknownVarFromNotificationView_StateController_1.currentState() - 1)
         {
            case 0:
               setVisibilityState(2);
               break;
            case 1:
               setVisibilityState(1);
         }
      }
      
      public function setVisibilityState(param1:int) : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc3_:int = UnknownVarFromNotificationView_StateController_1.requestState(param1);
         switch(_loc3_)
         {
            case 0:
               _window.x = _window.desktop.width;
               _window.visible = false;
               break;
            case 1:
               _window.visible = true;
               _loc2_ = _window.findChildByName("main_view") as IWindowController_1;
               _window.x = _window.desktop.width - (_window.width - _loc2_.width);
               break;
            case 2:
               _window.visible = true;
               _window.x = _window.desktop.width - _window.width;
         }
      }
      
      public function setViewEnabled(param1:Boolean) : void
      {
         UnknownVarFromNotificationView_StateController_1.setEnabled(param1);
         setVisibilityState(UnknownVarFromNotificationView_StateController_1.currentState());
      }
      
      public function setGameMode(param1:Boolean) : void
      {
         UnknownVarFromNotificationView_StateController_1.setGameMode(param1);
         setVisibilityState(UnknownVarFromNotificationView_StateController_1.currentState());
      }
      
      public function switchToPane(param1:String) : void
      {
         var _loc2_:IAbstractPane = UnknownVarFromNotificationView_Map_1.getValue(param1);
         if(!_loc2_)
         {
            return;
         }
         closePaneLevel(_loc2_.paneLevel);
         _loc2_.isVisible = true;
      }
      
      public function closePaneLevel(param1:int) : void
      {
         for each(var _loc2_ in UnknownVarFromNotificationView_Map_1)
         {
            if(_loc2_.paneLevel == param1)
            {
               _loc2_.isVisible = false;
            }
         }
      }
      
      public function addNotificationFeedItem(param1:int, param2:IFeedEntity) : void
      {
         (UnknownVarFromNotificationView_Map_1.getValue("pane_notifications") as NotificationsPane).addItem(param1,param2);
      }
      
      public function addStreamFeedItem(param1:IFeedEntity) : void
      {
         (UnknownVarFromNotificationView_Map_1.getValue("pane_stream") as StreamPane).addItem(param1);
      }
      
      public function removeStreamItems() : void
      {
      }
      
      private function onSettingsToggle(param1:WindowMouseEvent) : void
      {
         var _loc2_:IAbstractPane = UnknownVarFromNotificationView_Map_1.getValue("pane_settings") as IAbstractPane;
         if(_loc2_)
         {
            if(_loc2_.isVisible)
            {
               closePaneLevel(2);
            }
            else
            {
               switchToPane("pane_settings");
            }
         }
      }
      
      private function onInfoToggle(param1:WindowMouseEvent) : void
      {
         var _loc2_:IAbstractPane = UnknownVarFromNotificationView_Map_1.getValue("pane_info") as IAbstractPane;
         if(_loc2_)
         {
            if(_loc2_.isVisible)
            {
               closePaneLevel(2);
            }
            else
            {
               switchToPane("pane_info");
            }
         }
      }
   }
}

