package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.XMLVariableParser;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class SingularNotificationController implements IProfiler_1
   {
      private static const MODERATION_DISCLAIMER_DELAY_MS:int = 5000;
      
      private static const NEW_FEATURE_CONDITION_RETRY_DELAY_MS:int = 2000;
      
      private static const NEW_FEATURE_CONDITION_MAX_RETRIES:int = 3;
      
      private static const NEW_FEATURE_CONDITION_REWARD_TRACK_INCOMPLETE:String = "reward_track_incomplete";
      
      private static const NEW_FEATURE_CONDITION_STATE_UNAVAILABLE:int = -1;
      
      private static const NEW_FEATURE_CONDITION_STATE_HIDDEN:int = 0;
      
      private static const NEW_FEATURE_CONDITION_STATE_VISIBLE:int = 1;
      
      private var _notifications:HabboNotifications;
      
      private var UnknownVarFromSingularNotificationController_Array_1:Array;
      
      private var UnknownVarFromSingularNotificationController_Map_1:Map;
      
      private var UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1:HabboNotificationViewManager;
      
      private var _alertDialogManager:HabboAlertDialogManager;
      
      private var UnknownVarFromSingularNotificationController_Boolean_1:Boolean;
      
      private var UnknownVarFromSingularNotificationController_ClubGiftNotification_1:ClubGiftNotification;
      
      private var UnknownVarFromSingularNotificationController_Vector_1:Vector.<NewFeatureNotification>;
      
      private var UnknownVarFromSingularNotificationController_SafetyLockedNotification_1:SafetyLockedNotification;
      
      private var UnknownVarFromSingularNotificationController_Dictionary_1:Dictionary;
      
      private var UnknownVarFromSingularNotificationController_Timer_1:Timer;
      
      private var _disposed:Boolean;
      
      public function SingularNotificationController(param1:HabboNotifications)
      {
         var _loc5_:int = 0;
         var _loc7_:Map = null;
         var _loc3_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         super();
         _notifications = param1;
         UnknownVarFromSingularNotificationController_Array_1 = [];
         UnknownVarFromSingularNotificationController_Map_1 = new Map();
         UnknownVarFromSingularNotificationController_Dictionary_1 = new Dictionary();
         _alertDialogManager = new HabboAlertDialogManager(_notifications.windowManager,_notifications.localization,_notifications.habboHelp);
         var _loc8_:ISoundAsset = _notifications.assetLibrary.getAssetByName("habbo_notifications_config_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc8_);
         if(_loc2_ != null)
         {
            XMLVariableParser.parseVariableList(XML(_loc2_.content).children(),UnknownVarFromSingularNotificationController_Map_1);
         }
         var _loc6_:Map = UnknownVarFromSingularNotificationController_Map_1["styles"];
         if(_loc6_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc7_ = _loc6_.getWithIndex(_loc5_);
               if(_loc7_["icon"] != null)
               {
                  _loc3_ = _notifications.assetLibrary.getAssetByName(_loc7_["icon"]) as BitmapDataAsset;
                  _loc4_ = _loc3_.content as BitmapData;
                  _loc7_["icon"] = _loc4_;
               }
               _loc5_++;
            }
         }
         UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1 = new HabboNotificationViewManager(_notifications,_notifications.assetLibrary,_notifications.windowManager,_notifications.toolBar,UnknownVarFromSingularNotificationController_Map_1["styles"],UnknownVarFromSingularNotificationController_Map_1);
         _notifications.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImage);
         _notifications.registerUpdateReceiver(this,2);
         setTimeout(maybeShowNewFeatureNotification,2000);
      }
      
      public function get alertDialogManager() : HabboAlertDialogManager
      {
         return _alertDialogManager;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromSingularNotificationController_Timer_1)
         {
            UnknownVarFromSingularNotificationController_Timer_1.removeEventListener("timerComplete",onShowModerationDisclaimer);
            UnknownVarFromSingularNotificationController_Timer_1 = null;
         }
         if(UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1 != null)
         {
            UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.dispose();
            UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1 = null;
         }
         if(_alertDialogManager != null)
         {
            _alertDialogManager.dispose();
            _alertDialogManager = null;
         }
         if(UnknownVarFromSingularNotificationController_ClubGiftNotification_1 != null)
         {
            UnknownVarFromSingularNotificationController_ClubGiftNotification_1.dispose();
            UnknownVarFromSingularNotificationController_ClubGiftNotification_1 = null;
         }
         if(UnknownVarFromSingularNotificationController_Vector_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromSingularNotificationController_Vector_1)
            {
               _loc1_.dispose();
            }
            UnknownVarFromSingularNotificationController_Vector_1 = null;
         }
         if(UnknownVarFromSingularNotificationController_SafetyLockedNotification_1 != null)
         {
            UnknownVarFromSingularNotificationController_SafetyLockedNotification_1.dispose();
            UnknownVarFromSingularNotificationController_SafetyLockedNotification_1 = null;
         }
         if(_notifications != null)
         {
            _notifications.removeUpdateReceiver(this);
            _notifications = null;
         }
         _disposed = true;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:HabboNotificationItem = null;
         if(UnknownVarFromSingularNotificationController_Array_1.length > 0 && UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.isSpaceAvailable())
         {
            _loc2_ = getNextItemFromQueue();
            if(!UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.showItem(_loc2_))
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function addItem(param1:String, param2:String, param3:BitmapData, param4:String = null, param5:String = null, param6:String = null, param7:Object = null) : int
      {
         if(_notifications.disabled)
         {
            return 0;
         }
         var _loc9_:Map = UnknownVarFromSingularNotificationController_Map_1["styles"];
         if(_loc9_ == null)
         {
            return 0;
         }
         var _loc12_:Map = _loc9_[param2];
         if(_loc12_ == null)
         {
            return 0;
         }
         var _loc10_:String = param7["id"];
         if(_loc10_ != null && hasNotificationById(_loc10_))
         {
            return UnknownVarFromSingularNotificationController_Array_1.length;
         }
         var _loc11_:HabboNotificationItemStyle = new HabboNotificationItemStyle(_loc12_,param3,param4,true,param5,param7 == null ? {} : param7,param2);
         if(param6)
         {
            _loc11_.internalLink = param6;
         }
         var _loc8_:HabboNotificationItem = new HabboNotificationItem(param1,_loc11_,this);
         UnknownVarFromSingularNotificationController_Array_1.push(_loc8_);
         return UnknownVarFromSingularNotificationController_Array_1.length;
      }
      
      public function removeNotificationById(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HabboNotificationItem = null;
         if(param1 == null)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromSingularNotificationController_Array_1.length)
         {
            _loc2_ = UnknownVarFromSingularNotificationController_Array_1[_loc3_] as HabboNotificationItem;
            if(_loc2_ != null && _loc2_.notificationId == param1)
            {
               _loc2_.dispose();
               UnknownVarFromSingularNotificationController_Array_1.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
         UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.removeNotificationById(param1);
      }
      
      private function hasNotificationById(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in UnknownVarFromSingularNotificationController_Array_1)
         {
            if(_loc2_.notificationId == param1)
            {
               return true;
            }
         }
         return UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1 != null && UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.hasNotificationId(param1);
      }
      
      private function getNextItemFromQueue() : HabboNotificationItem
      {
         var _loc1_:Array = UnknownVarFromSingularNotificationController_Array_1.splice(0,1);
         return _loc1_[0] as HabboNotificationItem;
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         _notifications.localization.registerParameter("soundmachine.notification.playing","songname",param1);
         _notifications.localization.registerParameter("soundmachine.notification.playing","songauthor",param2);
         var _loc3_:ILocalization = _notifications.localization.getLocalizationRaw("soundmachine.notification.playing");
         if(_loc3_)
         {
            addItem(_loc3_.value,"soundmachine",null);
         }
      }
      
      public function onInternalLink(param1:String) : void
      {
         _notifications.createLinkEvent(param1);
      }
      
      private function onShowModerationDisclaimer(param1:TimerEvent) : void
      {
         UnknownVarFromSingularNotificationController_Timer_1.removeEventListener("timerComplete",onShowModerationDisclaimer);
         UnknownVarFromSingularNotificationController_Timer_1 = null;
         showModerationDisclaimer();
      }
      
      public function showModerationDisclaimer() : void
      {
         var _loc1_:String = null;
         if(RoomEnterEffect.isRunning())
         {
            if(UnknownVarFromSingularNotificationController_Timer_1 == null)
            {
               UnknownVarFromSingularNotificationController_Timer_1 = new Timer(RoomEnterEffect.totalRunningTime + 5000,1);
               UnknownVarFromSingularNotificationController_Timer_1.addEventListener("timerComplete",onShowModerationDisclaimer);
               UnknownVarFromSingularNotificationController_Timer_1.start();
            }
         }
         else if(!UnknownVarFromSingularNotificationController_Boolean_1)
         {
            _loc1_ = _notifications.localization.getLocalization("mod.chatdisclaimer","NA");
            this.addItem(_loc1_,"info",null);
            UnknownVarFromSingularNotificationController_Boolean_1 = true;
            Logger.log("DISPLAYED MOD INFO: " + _loc1_);
         }
      }
      
      public function showClubGiftNotification(param1:int) : void
      {
         if(UnknownVarFromSingularNotificationController_ClubGiftNotification_1 && (UnknownVarFromSingularNotificationController_ClubGiftNotification_1.visible || UnknownVarFromSingularNotificationController_ClubGiftNotification_1.isCancelled))
         {
            return;
         }
         UnknownVarFromSingularNotificationController_ClubGiftNotification_1 = new ClubGiftNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function maybeShowNewFeatureNotification(param1:int = 0) : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromSingularNotificationController_Vector_1 = new Vector.<NewFeatureNotification>();
         var _loc2_:Array = _notifications.getProperty("notifications.new_feature.active").split(",");
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.length != 0)
            {
               maybeShowNewFeatureNotificationByKey(_loc3_,param1);
            }
         }
      }
      
      private function maybeShowNewFeatureNotificationByKey(param1:String, param2:int) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc3_:int = getNewFeatureConditionState(param1);
         if(_loc3_ == 0)
         {
            return;
         }
         if(_loc3_ == -1)
         {
            if(param2 < 3)
            {
               setTimeout(maybeShowNewFeatureNotificationByKey,2000,param1,param2 + 1);
            }
            return;
         }
         UnknownVarFromSingularNotificationController_Vector_1.push(new NewFeatureNotification(_notifications.assets,_notifications.windowManager,_notifications.toolBar,_notifications.localization,_notifications,param1));
      }
      
      private function getNewFeatureConditionState(param1:String) : int
      {
         var _loc2_:String = _notifications.getProperty("notifications.new_feature.condition." + param1);
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return 1;
         }
         var _loc3_:Array = _loc2_.split(":");
         if(_loc3_.length < 2)
         {
            return 1;
         }
         if(_loc3_[0] == "reward_track_incomplete")
         {
            if(_notifications.rewardTrack == null || !_notifications.rewardTrack.hasRewardTrack(_loc3_[1]))
            {
               return -1;
            }
            return _notifications.rewardTrack.isRewardTrackComplete(_loc3_[1]) ? 0 : 1;
         }
         return 1;
      }
      
      public function showSafetyLockedNotification(param1:int) : void
      {
         if(UnknownVarFromSingularNotificationController_SafetyLockedNotification_1 && UnknownVarFromSingularNotificationController_SafetyLockedNotification_1.visible)
         {
            return;
         }
         UnknownVarFromSingularNotificationController_SafetyLockedNotification_1 = new SafetyLockedNotification(param1,_notifications.assets,_notifications.windowManager,_notifications.catalog,_notifications.toolBar);
      }
      
      public function hideSafetyLockedNotification() : void
      {
         if(!UnknownVarFromSingularNotificationController_SafetyLockedNotification_1)
         {
            return;
         }
         UnknownVarFromSingularNotificationController_SafetyLockedNotification_1.dispose();
      }
      
      private function onBadgeImage(param1:BadgeImageReadyEvent) : void
      {
         if(param1 != null && this.UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1 != null)
         {
            UnknownVarFromSingularNotificationController_HabboNotificationViewManager_1.replaceIcon(param1);
         }
      }
   }
}

