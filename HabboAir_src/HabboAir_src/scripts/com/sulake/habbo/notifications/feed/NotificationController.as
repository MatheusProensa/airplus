package com.sulake.habbo.notifications.feed
{
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.notifications.feed.data.GenericNotificationItemData;
   import com.sulake.habbo.notifications.feed.view.content.EntityFactory;
   import com.sulake.habbo.notifications.feed.view.content.IFeedEntity;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class NotificationController
   {
      private var UnknownVarFromNotificationController_HabboNotifications_1:HabboNotifications;
      
      private var UnknownVarFromNotificationController_NotificationView_1:NotificationView;
      
      private var _settings:FeedSettings;
      
      private var UnknownVarFromNotificationController_EntityFactory_1:EntityFactory;
      
      public function NotificationController(param1:HabboNotifications)
      {
         super();
         UnknownVarFromNotificationController_HabboNotifications_1 = param1;
         _settings = new FeedSettings(this);
         UnknownVarFromNotificationController_NotificationView_1 = new NotificationView(this,param1);
         UnknownVarFromNotificationController_EntityFactory_1 = new EntityFactory();
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.addEventListener("RSE_CREATED",roomSessionStateEventHandler);
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.addEventListener("RSE_STARTED",roomSessionStateEventHandler);
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.addEventListener("RSE_ENDED",roomSessionStateEventHandler);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromNotificationController_NotificationView_1)
         {
            UnknownVarFromNotificationController_NotificationView_1.dispose();
            UnknownVarFromNotificationController_NotificationView_1 = null;
         }
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.removeEventListener("RSE_CREATED",roomSessionStateEventHandler);
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.removeEventListener("RSE_STARTED",roomSessionStateEventHandler);
         UnknownVarFromNotificationController_HabboNotifications_1.roomSessionManager.events.removeEventListener("RSE_ENDED",roomSessionStateEventHandler);
         UnknownVarFromNotificationController_HabboNotifications_1 = null;
         if(_settings)
         {
            _settings.dispose();
            _settings = null;
         }
         if(UnknownVarFromNotificationController_EntityFactory_1)
         {
            UnknownVarFromNotificationController_EntityFactory_1.dispose();
            UnknownVarFromNotificationController_EntityFactory_1 = null;
         }
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_CREATED":
            case "RSE_STARTED":
            case "RSE_ENDED":
               if(UnknownVarFromNotificationController_NotificationView_1)
               {
                  UnknownVarFromNotificationController_NotificationView_1.setGameMode(param1.session.isGameSession);
               }
         }
      }
      
      public function setFeedEnabled(param1:Boolean) : void
      {
         if(UnknownVarFromNotificationController_NotificationView_1)
         {
            UnknownVarFromNotificationController_NotificationView_1.setViewEnabled(param1);
         }
      }
      
      public function getSettings() : FeedSettings
      {
         return _settings;
      }
      
      public function updateFeedCategoryFiltering() : void
      {
      }
      
      public function addFeedItem(param1:int, param2:GenericNotificationItemData) : void
      {
         var _loc3_:IFeedEntity = UnknownVarFromNotificationController_EntityFactory_1.createNotificationEntity(param2);
         UnknownVarFromNotificationController_NotificationView_1.addNotificationFeedItem(param1,_loc3_);
      }
      
      public function executeAction(param1:String) : void
      {
         if(param1.indexOf("http") == 0)
         {
            HabboWebTools.openWebPage(param1);
         }
      }
   }
}

