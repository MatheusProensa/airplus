package com.sulake.habbo.discord.settings
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.discord.DiscordPreferencesEvent;
   import com.sulake.habbo.communication.messages.outgoing.discord.GetDiscordPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.discord.SetDiscordPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferences;
   import com.sulake.habbo.discord.HabboDiscordManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.utils.setTimeout;
   
   public class DiscordSettingsController extends Component implements ILinkEventTracker, IDiscordSettingsController
   {
      private static const UnknownConstFromDiscordSettingsController_Int_1:int = 5000;
      
      private static const PREFERENCES_UNINITIALIZED:DiscordPreferences = new DiscordPreferences(0,false,false,false,false);
      
      private static const PREFERENCES_DEFAULT:DiscordPreferences = new DiscordPreferences(0,true,true,true,true);
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var UnknownVarFromDiscordSettingsController_HabboDiscordManager_1:HabboDiscordManager;
      
      private var UnknownVarFromDiscordSettingsController_DiscordSettingsView_1:DiscordSettingsView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _preferences:DiscordPreferences = null;
      
      private var UnknownVarFromDiscordSettingsController_DiscordPreferences_1:DiscordPreferences = null;
      
      private var UnknownVarFromDiscordSettingsController_Boolean_1:Boolean;
      
      private var _checkedForPopup:Boolean;
      
      private var UnknownVarFromDiscordSettingsController_Boolean_2:Boolean;
      
      private var UnknownVarFromDiscordSettingsController_Boolean_3:Boolean = false;
      
      public function DiscordSettingsController(param1:HabboDiscordManager, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         UnknownVarFromDiscordSettingsController_HabboDiscordManager_1 = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new DiscordPreferencesEvent(onDiscordPreferences));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      private function onDiscordPreferences(param1:DiscordPreferencesEvent) : void
      {
         _preferences = param1.preferences;
         UnknownVarFromDiscordSettingsController_DiscordPreferences_1 = _preferences;
         if(UnknownVarFromDiscordSettingsController_DiscordPreferences_1.version == 0)
         {
            UnknownVarFromDiscordSettingsController_DiscordPreferences_1 = PREFERENCES_DEFAULT;
         }
         maybeShowPopup();
         UnknownVarFromDiscordSettingsController_HabboDiscordManager_1.tryUpdatePresence(true,true);
      }
      
      private function maybeShowPopup() : void
      {
         if(_checkedForPopup || UnknownVarFromDiscordSettingsController_DiscordPreferences_1 == null || !UnknownVarFromDiscordSettingsController_Boolean_1)
         {
            return;
         }
         _checkedForPopup = true;
         if(UnknownVarFromDiscordSettingsController_DiscordPreferences_1.version >= preferenceGlobalVersion || UnknownVarFromDiscordSettingsController_Boolean_2)
         {
            return;
         }
         setTimeout(function():void
         {
            if(!UnknownVarFromDiscordSettingsController_Boolean_2)
            {
               showView();
            }
         },5000);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null,true)]);
      }
      
      public function onDiscordConnected() : void
      {
         UnknownVarFromDiscordSettingsController_Boolean_1 = true;
         maybeShowPopup();
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _communicationManager.connection.send(new GetDiscordPreferencesMessageComposer());
      }
      
      public function get linkPattern() : String
      {
         return "discord/settings/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[2] == "open")
         {
            showView();
         }
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function showView() : void
      {
         if(UnknownVarFromDiscordSettingsController_DiscordPreferences_1 == null)
         {
            Logger.log("Attempted to open DiscordSettingsView but didn\'t have preferences available");
            return;
         }
         if(UnknownVarFromDiscordSettingsController_DiscordSettingsView_1 == null)
         {
            UnknownVarFromDiscordSettingsController_DiscordSettingsView_1 = new DiscordSettingsView(this,_windowManager);
         }
         UnknownVarFromDiscordSettingsController_DiscordSettingsView_1.initialize(UnknownVarFromDiscordSettingsController_DiscordPreferences_1);
         UnknownVarFromDiscordSettingsController_DiscordSettingsView_1.show();
         UnknownVarFromDiscordSettingsController_Boolean_2 = true;
      }
      
      public function hideView() : void
      {
         if(UnknownVarFromDiscordSettingsController_DiscordSettingsView_1 && UnknownVarFromDiscordSettingsController_DiscordSettingsView_1.isShowing())
         {
            UnknownVarFromDiscordSettingsController_DiscordSettingsView_1.hide();
         }
      }
      
      public function get preferenceGlobalVersion() : int
      {
         return getInteger("discord_activity.settings.version",1);
      }
      
      public function updatePreferences(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         _preferences = new DiscordPreferences(preferenceGlobalVersion,param1,param2,param3,param4);
         UnknownVarFromDiscordSettingsController_DiscordPreferences_1 = _preferences;
         _communicationManager.connection.send(new SetDiscordPreferencesMessageComposer(preferenceGlobalVersion,param1,param2,param3,param4));
         UnknownVarFromDiscordSettingsController_HabboDiscordManager_1.tryUpdatePresence(true,true);
      }
      
      public function get preferences() : DiscordPreferences
      {
         if(_preferences == null)
         {
            return PREFERENCES_UNINITIALIZED;
         }
         return _preferences;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromDiscordSettingsController_Boolean_3)
         {
            return;
         }
         UnknownVarFromDiscordSettingsController_Boolean_3 = true;
         if(UnknownVarFromDiscordSettingsController_DiscordSettingsView_1)
         {
            UnknownVarFromDiscordSettingsController_DiscordSettingsView_1.dispose();
            UnknownVarFromDiscordSettingsController_DiscordSettingsView_1 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _windowManager = null;
         _localization = null;
         UnknownVarFromDiscordSettingsController_HabboDiscordManager_1 = null;
         UnknownVarFromDiscordSettingsController_DiscordPreferences_1 = null;
         _preferences = null;
         UnknownVarFromDiscordSettingsController_Boolean_1 = false;
         _checkedForPopup = false;
         context.removeLinkEventTracker(this);
         super.dispose();
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
   }
}

