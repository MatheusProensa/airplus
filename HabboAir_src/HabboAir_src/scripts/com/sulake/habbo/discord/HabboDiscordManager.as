package com.sulake.habbo.discord
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.discord.DiscordRichPresence;
   import com.sulake.discord.events.DiscordRichPresenceEvent;
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferences;
   import com.sulake.habbo.discord.habbo_activity.HabboActivityDetection;
   import com.sulake.habbo.discord.habbo_activity.HabboActivityState;
   import com.sulake.habbo.discord.settings.DiscordSettingsController;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.DeBouncer;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import flash.events.StatusEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboDiscordManager extends Component implements UnknownIHabboDiscord1
   {
      private static const REFRESH_TIMEOUT_MS:int = 10000;
      
      private static const ALLOWED_ENVIRONMENTS:Array = ["en","pt","fi","fr","de","nl","es","it","tr","s2","local"];
      
      private var _localization:IHabboLocalizationManager;
      
      private var UnknownVarFromHabboDiscordManager_DiscordSettingsController_1:DiscordSettingsController;
      
      private var UnknownVarFromHabboDiscordManager_HabboActivityDetection_1:HabboActivityDetection;
      
      private const rpc:DiscordRichPresence = DiscordRichPresence.isSupported ? DiscordRichPresence.instance : null;
      
      private var UnknownVarFromHabboDiscordManager_Boolean_1:Boolean;
      
      private var UnknownVarFromHabboDiscordManager_DeBouncer_1:DeBouncer;
      
      private var UnknownVarFromHabboDiscordManager_Timer_1:Timer;
      
      private var UnknownVarFromHabboDiscordManager_Boolean_2:Boolean = false;
      
      private var _lastDetails:String = null;
      
      private var UnknownVarFromHabboDiscordManager_String_1:String = null;
      
      private var _lastStartTime:int = -1;
      
      private var _startTime:int;
      
      public function HabboDiscordManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         UnknownVarFromHabboDiscordManager_DeBouncer_1 = new DeBouncer(1500,3000,updatePresence);
         UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 = new DiscordSettingsController(this,param1,0,param3);
         UnknownVarFromHabboDiscordManager_HabboActivityDetection_1 = new HabboActivityDetection(this,param1,0,param3);
         _startTime = new Date().time / 1000;
         initialize();
         UnknownVarFromHabboDiscordManager_Timer_1 = new Timer(10000);
         UnknownVarFromHabboDiscordManager_Timer_1.addEventListener("timer",onPresenceTimer);
         UnknownVarFromHabboDiscordManager_Timer_1.start();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         })]);
      }
      
      public function initialize() : void
      {
         if(rpc)
         {
            try
            {
               rpc.addJoinListener(function(param1:DiscordRichPresenceEvent):void
               {
               });
               rpc.addJoinRequestListener(function(param1:DiscordRichPresenceEvent):void
               {
               });
               rpc.addStatusListener(function(param1:StatusEvent):void
               {
                  if(disposed)
                  {
                     return;
                  }
                  if(param1.code == "DISCORD_CONNECTED")
                  {
                     if(UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 != null)
                     {
                        UnknownVarFromHabboDiscordManager_DiscordSettingsController_1.onDiscordConnected();
                     }
                     UnknownVarFromHabboDiscordManager_Boolean_1 = true;
                     tryUpdatePresence(true,true);
                  }
                  else if(param1.code == "DISCORD_SHUTDOWN")
                  {
                     UnknownVarFromHabboDiscordManager_Boolean_1 = false;
                     tryUpdatePresence(true);
                  }
               });
               rpc.initialize("1440237225051947050");
            }
            catch(error:*)
            {
               Logger.log("Failed to initialize discord rich presence: " + error);
            }
         }
      }
      
      public function tryUpdatePresence(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(disposed || UnknownVarFromHabboDiscordManager_DeBouncer_1 == null)
         {
            return;
         }
         if(param2)
         {
            _startTime = new Date().time / 1000;
         }
         UnknownVarFromHabboDiscordManager_DeBouncer_1.trigger(param1);
      }
      
      private function get featureEnabled() : Boolean
      {
         return getBoolean("discord.enabled");
      }
      
      public function updatePresence() : void
      {
         var _loc1_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc2_:HabboActivityState = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         var _loc3_:String = null;
         if(!rpc || !UnknownVarFromHabboDiscordManager_Boolean_1 || !UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 || !UnknownVarFromHabboDiscordManager_HabboActivityDetection_1 || !_localization || !featureEnabled)
         {
            return;
         }
         var _loc10_:DiscordPreferences = UnknownVarFromHabboDiscordManager_DiscordSettingsController_1.preferences;
         if(!_loc10_ || !_loc10_.showHabbo)
         {
            if(UnknownVarFromHabboDiscordManager_Boolean_2)
            {
               try
               {
                  rpc.clearPresence();
               }
               catch(e:*)
               {
               }
            }
            UnknownVarFromHabboDiscordManager_Boolean_2 = false;
            _lastDetails = null;
            UnknownVarFromHabboDiscordManager_String_1 = null;
            _lastStartTime = -1;
            return;
         }
         var _loc6_:String = getEnvironmentName();
         var _loc5_:String = _localization.getLocalizationWithParams("discord.rpc.details","","hotel_id",_loc6_);
         var _loc7_:String = null;
         if(_loc10_.shareActivity)
         {
            _loc1_ = UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.isInRoom();
            _loc11_ = UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.isInHiddenRoom();
            if(!_loc1_)
            {
               _loc7_ = _localization.getLocalization("discord.rpc.state.hotelview");
            }
            else if(_loc11_ && _loc10_.hideInHiddenRooms)
            {
               _loc7_ = _localization.getLocalization("discord.rpc.state.hidden");
            }
            else
            {
               _loc2_ = UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.getCurrentRoomActivity();
               _loc8_ = UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.getCurrentRoomName();
               _loc9_ = _loc2_.name;
               _loc4_ = _localization.getLocalization("discord.rpc.state.room." + _loc9_);
               if(_loc8_ == null || _loc8_.length == 0 || _loc4_ == null || _loc4_.length == 0)
               {
                  _loc7_ = null;
               }
               else
               {
                  _loc7_ = _localization.getLocalizationWithParams("discord.rpc.state.room","","noun",_loc4_,"room_name",_loc8_);
               }
            }
         }
         if(_loc5_ == _lastDetails && _loc7_ == UnknownVarFromHabboDiscordManager_String_1 && _startTime == _lastStartTime)
         {
            return;
         }
         try
         {
            if(_loc7_ != null && _loc7_.length > 0)
            {
               _loc3_ = getLink();
               if(_loc3_ != null)
               {
                  rpc.updatePresence({
                     "details":_loc5_,
                     "state":_loc7_,
                     "timestamps":{"start":_startTime},
                     "buttons":[{
                        "label":"Visit room",
                        "url":_loc3_
                     }]
                  });
               }
               else
               {
                  rpc.updatePresence({
                     "details":_loc5_,
                     "state":_loc7_,
                     "timestamps":{"start":_startTime}
                  });
               }
            }
            else
            {
               rpc.updatePresence({
                  "details":_loc5_,
                  "timestamps":{"start":_startTime}
               });
            }
            _lastDetails = _loc5_;
            UnknownVarFromHabboDiscordManager_String_1 = _loc7_;
            _lastStartTime = _startTime;
         }
         catch(e:*)
         {
         }
         UnknownVarFromHabboDiscordManager_Boolean_2 = true;
      }
      
      private function getEnvironmentName() : String
      {
         var _loc1_:String = getProperty("environment.id");
         if(ALLOWED_ENVIRONMENTS.indexOf(_loc1_) == -1)
         {
            return "";
         }
         if(_loc1_ == "s2")
         {
            return "Sandbox";
         }
         _loc1_ = _loc1_.replace("pt","br");
         _loc1_ = _loc1_.replace("en","com");
         return _loc1_.toUpperCase();
      }
      
      private function getLink() : String
      {
         if(UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 == null || UnknownVarFromHabboDiscordManager_DiscordSettingsController_1.preferences == null)
         {
            return null;
         }
         if(!UnknownVarFromHabboDiscordManager_DiscordSettingsController_1.preferences.allowJoining || !UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.isInRoom() || UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.roomId == -1)
         {
            return null;
         }
         var _loc1_:String = getProperty("environment.id");
         if(ALLOWED_ENVIRONMENTS.indexOf(_loc1_) == -1 || _loc1_ == "local")
         {
            return null;
         }
         return _localization.getLocalizationWithParams("navigator.embed.src","","roomId",UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.roomId);
      }
      
      private function onPresenceTimer(param1:TimerEvent) : void
      {
         if(disposed || UnknownVarFromHabboDiscordManager_Timer_1 == null)
         {
            return;
         }
         tryUpdatePresence();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromHabboDiscordManager_Boolean_1 = false;
         if(UnknownVarFromHabboDiscordManager_Timer_1 != null)
         {
            UnknownVarFromHabboDiscordManager_Timer_1.stop();
            UnknownVarFromHabboDiscordManager_Timer_1.removeEventListener("timer",onPresenceTimer);
            UnknownVarFromHabboDiscordManager_Timer_1 = null;
         }
         if(UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 != null)
         {
            UnknownVarFromHabboDiscordManager_DiscordSettingsController_1.dispose();
            UnknownVarFromHabboDiscordManager_DiscordSettingsController_1 = null;
         }
         if(UnknownVarFromHabboDiscordManager_HabboActivityDetection_1 != null)
         {
            UnknownVarFromHabboDiscordManager_HabboActivityDetection_1.dispose();
            UnknownVarFromHabboDiscordManager_HabboActivityDetection_1 = null;
         }
         if(UnknownVarFromHabboDiscordManager_DeBouncer_1 != null)
         {
            UnknownVarFromHabboDiscordManager_DeBouncer_1.dispose();
            UnknownVarFromHabboDiscordManager_DeBouncer_1 = null;
         }
         _localization = null;
         if(rpc)
         {
            try
            {
               rpc.shutdown();
               rpc.dispose();
            }
            catch(error:Error)
            {
            }
         }
         super.dispose();
      }
   }
}

