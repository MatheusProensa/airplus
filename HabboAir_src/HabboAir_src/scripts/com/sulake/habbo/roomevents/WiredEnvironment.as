package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredClickSettingsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredClickUserResponseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredEnvironmentMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredClickSettingsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredClickUserResponseMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredEnvironmentMessageParser;
   import com.sulake.habbo.room.IRoomEngine_2;
   import com.sulake.habbo.roomevents.events.WiredAchievementsUpdatedEvent;
   import com.sulake.habbo.roomevents.events.WiredUserClickHandledEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class WiredEnvironment implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromWiredEnvironment_String_1:String = "wired_env";
      
      public static const CLICK_USER_DEFAULT:int = 0;
      
      public static const CLICK_USER_CLICK_WALK_BEHIND:int = 1;
      
      public static const CLICK_USER_PASS_THROUGH:int = 2;
      
      public static const CLICK_FURNI_DEFAULT:int = 0;
      
      public static const CLICK_FURNI_PASS_THROUGH:int = 1;
      
      private static const CLICK_SETTINGS_NOTIFICATION_TOGGLE_ID:String = "wired_click_settings_toggle";
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Array;
      
      private var _hasClickUserWired:Boolean = false;
      
      private var _achievements:Vector.<String> = new Vector.<String>();
      
      private var UnknownVarFromWiredEnvironment_Int_1:int = 0;
      
      private var _clickFurniOption:int = 0;
      
      private var UnknownVarFromWiredEnvironment_Boolean_1:Boolean = false;
      
      private var UnknownVarFromWiredEnvironment_Uint_1:uint = 4294967295;
      
      public function WiredEnvironment(param1:HabboUserDefinedRoomEvents)
      {
         super();
         UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1 = param1;
         _messageEvents = [];
         _messageEvents.push(new WiredEnvironmentMessageEvent(onWiredEnvironmentEvent));
         _messageEvents.push(new WiredClickUserResponseEvent(onWiredClickUserResponseEvent));
         _messageEvents.push(new WiredClickSettingsMessageEvent(onWiredClickSettingsEvent));
         for each(var _loc2_ in _messageEvents)
         {
            UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.communication.addHabboConnectionMessageEvent(_loc2_);
         }
      }
      
      private function hideClickSettingsIfInactive() : void
      {
         if(!hasActiveClickSettings())
         {
            UnknownVarFromWiredEnvironment_Boolean_1 = false;
            UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.removeNotificationById("wired_click_settings_toggle");
         }
      }
      
      private function onWiredClickSettingsEvent(param1:WiredClickSettingsMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:Object = null;
         var _loc2_:WiredClickSettingsMessageParser = param1.getParser();
         var _loc5_:Boolean = UnknownVarFromWiredEnvironment_Int_1 != _loc2_.userOption || _clickFurniOption != _loc2_.furniOption;
         if(UnknownVarFromWiredEnvironment_Boolean_1 && !UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.wiredMenu.hasWritePermission)
         {
            UnknownVarFromWiredEnvironment_Boolean_1 = false;
            _loc5_ = true;
            UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.removeNotificationById("wired_click_settings_toggle");
         }
         if(_loc5_)
         {
            UnknownVarFromWiredEnvironment_Int_1 = _loc2_.userOption;
            _clickFurniOption = _loc2_.furniOption;
            if(!hasActiveClickSettings())
            {
               clearTimeout(UnknownVarFromWiredEnvironment_Uint_1);
               UnknownVarFromWiredEnvironment_Uint_1 = setTimeout(hideClickSettingsIfInactive,3000);
            }
            if(UnknownVarFromWiredEnvironment_Boolean_1)
            {
               _loc4_ = "${notification.click_settings}";
               if(hasActiveClickSettings())
               {
                  _loc4_ = UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.localization.getLocalization("notification.click_settings_ignored") + " " + UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.localization.getLocalization("notification.click_settings");
               }
               UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.addItem(_loc4_,"wired");
               return;
            }
            applyClickSettings(UnknownVarFromWiredEnvironment_Int_1,_clickFurniOption);
            if(UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.wiredMenu.hasWritePermission && hasActiveClickSettings())
            {
               _loc3_ = {};
               _loc3_["id"] = "wired_click_settings_toggle";
               _loc3_["stay"] = true;
               _loc3_["toggle_callback"] = onToggleClickSettingsNotification;
               UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.addItem("${notification.click_settings}","wired",null,null,_loc3_);
               return;
            }
            UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.addItem("${notification.click_settings}","wired");
         }
      }
      
      public function get achievements() : Vector.<String>
      {
         return _achievements;
      }
      
      public function leaveRoom() : void
      {
         UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.notifications.removeNotificationById("wired_click_settings_toggle");
         UnknownVarFromWiredEnvironment_Boolean_1 = false;
         clearTimeout(UnknownVarFromWiredEnvironment_Uint_1);
         if(UnknownVarFromWiredEnvironment_Int_1 != 0 || _clickFurniOption != 0 || UnknownVarFromWiredEnvironment_Boolean_1)
         {
            UnknownVarFromWiredEnvironment_Int_1 = 0;
            _clickFurniOption = 0;
            applyClickSettings(0,0);
         }
      }
      
      private function onToggleClickSettingsNotification(param1:Boolean) : void
      {
         UnknownVarFromWiredEnvironment_Boolean_1 = param1;
         if(param1)
         {
            applyClickSettings(0,0);
         }
         else
         {
            applyClickSettings(UnknownVarFromWiredEnvironment_Int_1,_clickFurniOption);
         }
      }
      
      private function hasActiveClickSettings() : Boolean
      {
         return UnknownVarFromWiredEnvironment_Int_1 != 0 || _clickFurniOption != 0;
      }
      
      private function applyClickSettings(param1:int, param2:int) : void
      {
         (UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.roomEngine as IRoomEngine_2).setClickSettings("wired_env",param1 == 2,param2 == 1);
      }
      
      private function onWiredEnvironmentEvent(param1:WiredEnvironmentMessageEvent) : void
      {
         var _loc2_:WiredEnvironmentMessageParser = param1.getParser();
         _hasClickUserWired = _loc2_.hasClickUserWired;
         _achievements = _loc2_.enabledAchievements;
         UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.events.dispatchEvent(new WiredAchievementsUpdatedEvent("WIRED_ACHIEVEMENTS_UPDATED",_achievements));
      }
      
      private function onWiredClickUserResponseEvent(param1:WiredClickUserResponseEvent) : void
      {
         var _loc2_:WiredClickUserResponseMessageParser = param1.getParser();
         UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.events.dispatchEvent(new WiredUserClickHandledEvent("WIRED_USER_CLICK_HANDLED",_loc2_.index,_loc2_.openMenu));
      }
      
      public function clear() : void
      {
         _hasClickUserWired = false;
      }
      
      public function get hasClickUserWired() : Boolean
      {
         return _hasClickUserWired;
      }
      
      public function get clickUserOption() : int
      {
         return UnknownVarFromWiredEnvironment_Boolean_1 ? 0 : UnknownVarFromWiredEnvironment_Int_1;
      }
      
      public function get clickFurniOption() : int
      {
         return _clickFurniOption;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _hasClickUserWired = false;
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1.communication.removeHabboConnectionMessageEvent(_loc1_);
         }
         _messageEvents = null;
         UnknownVarFromWiredEnvironment_HabboUserDefinedRoomEvents_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

