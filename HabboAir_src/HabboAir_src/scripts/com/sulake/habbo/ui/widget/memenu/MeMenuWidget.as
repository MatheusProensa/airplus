package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDanceUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetMiniMailUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWaveUpdateEvent;
   import com.sulake.habbo.ui.widget.memenu.soundsettings.MeMenuSoundSettingsView;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuWidget extends RoomWidgetBase
   {
      public static const MAIN_VIEW:String = "me_menu_top_view";
      
      public static const MY_CLOTHES_VIEW:String = "me_menu_my_clothes_view";
      
      public static const UnknownConstFromMeMenuWidget_String_1:String = "me_menu_dance_moves_view";
      
      public static const UnknownConstFromMeMenuWidget_String_2:String = "me_menu_settings_view";
      
      public static const SOUND_SETTINGS_VIEW:String = "me_menu_sound_settings";
      
      private static const DEFAULT_VIEW_LOCATION_BOTTOM:Point = new Point(95,440);
      
      private var UnknownVarFromMeMenuWidget_IMeMenuView_1:IMeMenuView;
      
      private var _mainWindow:IWindowController_1;
      
      private var _habboClubDays:int = 0;
      
      private var _habboClubPeriods:int = 0;
      
      private var UnknownVarFromMeMenuWidget_Int_1:int = 0;
      
      private var _allowHabboClubDances:Boolean = false;
      
      private var _habboClubLevel:int = 0;
      
      private var _hasEffectOn:Boolean = false;
      
      private var _isDancing:Boolean = false;
      
      private var UnknownVarFromMeMenuWidget_Boolean_1:Boolean = false;
      
      private var _isMinimailEnabled:Boolean = false;
      
      private var UnknownVarFromMeMenuWidget_Int_2:int = 0;
      
      private var _isGameMode:Boolean = false;
      
      private var _config:IComponent_1;
      
      private var _userId:int;
      
      public function MeMenuWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1)
      {
         super(param1,param2,param3,param4);
         _config = param5;
         if(ExternalInterface.available)
         {
            _isMinimailEnabled = param5.getBoolean("client.minimail.embed.enabled");
         }
         (param1 as MeMenuWidgetHandler).widget = this;
         changeView("me_menu_top_view");
         hide();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide();
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null)
         {
            UnknownVarFromMeMenuWidget_IMeMenuView_1.dispose();
            UnknownVarFromMeMenuWidget_IMeMenuView_1 = null;
         }
         _mainWindow = null;
         _config = null;
         super.dispose();
      }
      
      public function get handler() : MeMenuWidgetHandler
      {
         return _widgetHandler as MeMenuWidgetHandler;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _mainWindow;
      }
      
      private function get mainContainer() : IWindowController_1
      {
         var _loc1_:ISoundAsset = null;
         if(_mainWindow == null)
         {
            _loc1_ = _assets.getAssetByName("memenu");
            if(_loc1_)
            {
               _mainWindow = windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
            }
         }
         if(_mainWindow)
         {
            return _mainWindow.findChildByTag("MAIN_CONTENT") as IWindowController_1;
         }
         return null;
      }
      
      public function changeView(param1:String) : void
      {
         var _loc2_:IMeMenuView = null;
         switch(param1)
         {
            case "me_menu_top_view":
               _loc2_ = new MeMenuMainView(config);
               break;
            case "me_menu_dance_moves_view":
               _loc2_ = new MeMenuDanceView();
               break;
            case "me_menu_settings_view":
               _loc2_ = new MeMenuSettingsMenuView();
               break;
            case "me_menu_sound_settings":
               _loc2_ = new MeMenuSoundSettingsView();
               break;
            default:
               Logger.log("Me Menu Change view: unknown view: " + param1);
         }
         if(_loc2_ != null)
         {
            if(UnknownVarFromMeMenuWidget_IMeMenuView_1)
            {
               UnknownVarFromMeMenuWidget_IMeMenuView_1.dispose();
               UnknownVarFromMeMenuWidget_IMeMenuView_1 = null;
            }
            UnknownVarFromMeMenuWidget_IMeMenuView_1 = _loc2_;
            UnknownVarFromMeMenuWidget_IMeMenuView_1.init(this,param1);
            mainContainer.removeChildAt(0);
            mainContainer.addChildAt(UnknownVarFromMeMenuWidget_IMeMenuView_1.window,0);
            _mainWindow.visible = true;
            _mainWindow.activate();
         }
         updateSize();
      }
      
      public function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Rectangle = null;
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 && UnknownVarFromMeMenuWidget_IMeMenuView_1.window && _mainWindow)
         {
            _loc1_ = 5;
            UnknownVarFromMeMenuWidget_IMeMenuView_1.window.position = new Point(_loc1_,_loc1_);
            mainContainer.width = UnknownVarFromMeMenuWidget_IMeMenuView_1.window.width + _loc1_ * 2;
            mainContainer.height = UnknownVarFromMeMenuWidget_IMeMenuView_1.window.height + _loc1_ * 2;
            if(_config.getBoolean("simple.memenu.enabled") && handler && handler.container && handler.container.toolbar)
            {
               _loc2_ = handler.container.toolbar.getRect();
               _mainWindow.x = _loc2_.right + _loc1_;
               _mainWindow.y = _loc2_.bottom - _mainWindow.height;
            }
            else
            {
               _mainWindow.x = DEFAULT_VIEW_LOCATION_BOTTOM.x;
               _mainWindow.y = DEFAULT_VIEW_LOCATION_BOTTOM.y - mainContainer.height;
            }
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWMMUE_new_mini_mail",onMiniMailUpdate);
         param1.addEventListener("RWMMUE_unread_mini_mail",onMiniMailUpdate);
         param1.addEventListener("RWUE_WAVE",onWaveEvent);
         param1.addEventListener("RWUE_DANCE",onDanceEvent);
         param1.addEventListener("RWUEUE_UPDATE_EFFECTS",onUpdateEffects);
         param1.addEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED",onToolbarClicked);
         param1.addEventListener("RWUE_AVATAR_EDITOR_CLOSED",onAvatarEditorClosed);
         param1.addEventListener("RWUE_HIDE_AVATAR_EDITOR",onHideAvatarEditor);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onAvatarDeselected);
         param1.addEventListener("RWBIUE_HABBO_CLUB",onHabboClubEvent);
         param1.addEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.addEventListener("RWSUE_SETTINGS",onSettingsUpdate);
         param1.addEventListener("HHTPNUFWE_AE_STARTED",onTutorialEvent);
         param1.addEventListener("HHTPNUFWE_AE_HIGHLIGHT",onTutorialEvent);
         param1.addEventListener("RWPUE_CREDIT_BALANCE",onCreditBalance);
         param1.addEventListener("RWREUE_NORMAL_MODE",onNormalMode);
         param1.addEventListener("RWREUE_GAME_MODE",onGameMode);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWUE_WAVE",onWaveEvent);
         param1.removeEventListener("RWUE_DANCE",onDanceEvent);
         param1.removeEventListener("RWUEUE_UPDATE_EFFECTS",onUpdateEffects);
         param1.removeEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED",onToolbarClicked);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onAvatarDeselected);
         param1.removeEventListener("RWBIUE_HABBO_CLUB",onHabboClubEvent);
         param1.removeEventListener("RWUE_AVATAR_EDITOR_CLOSED",onHideAvatarEditor);
         param1.removeEventListener("RWUE_HIDE_AVATAR_EDITOR",onAvatarEditorClosed);
         param1.removeEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.removeEventListener("RWSUE_SETTINGS",onSettingsUpdate);
         param1.removeEventListener("HHTPNUFWE_AE_HIGHLIGHT",onTutorialEvent);
         param1.removeEventListener("HHTPNUFWE_AE_STARTED",onTutorialEvent);
         param1.removeEventListener("RWPUE_CREDIT_BALANCE",onCreditBalance);
         param1.removeEventListener("RWREUE_NORMAL_MODE",onNormalMode);
         param1.removeEventListener("RWREUE_NORMAL_MODE",onGameMode);
      }
      
      public function hide(param1:RoomWidgetRoomObjectUpdateEvent = null) : void
      {
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null)
         {
            _mainWindow.removeChild(UnknownVarFromMeMenuWidget_IMeMenuView_1.window);
            UnknownVarFromMeMenuWidget_IMeMenuView_1.dispose();
            UnknownVarFromMeMenuWidget_IMeMenuView_1 = null;
         }
         _mainWindow.visible = false;
         UnknownVarFromMeMenuWidget_Boolean_1 = false;
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         _userId = param1.webID;
      }
      
      private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent) : void
      {
         if(!UnknownVarFromMeMenuWidget_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name == "me_menu_sound_settings")
         {
            (UnknownVarFromMeMenuWidget_IMeMenuView_1 as MeMenuSoundSettingsView).updateSettings(param1);
         }
      }
      
      private function onTutorialEvent(param1:RoomWidgetTutorialEvent) : void
      {
         switch(param1.type)
         {
            case "HHTPNUFWE_AE_HIGHLIGHT":
               Logger.log("* MeMenuWidget: onHighlightClothesIcon " + UnknownVarFromMeMenuWidget_Boolean_1 + " view: " + UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name);
               if(UnknownVarFromMeMenuWidget_Boolean_1 != true || UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name != "me_menu_top_view")
               {
                  return;
               }
               (UnknownVarFromMeMenuWidget_IMeMenuView_1 as MeMenuMainView).setIconAssets("clothes_icon","me_menu_top_view","clothes_highlighter_blue");
               break;
            case "HHTPNUFWE_AE_STARTED":
               hide();
         }
      }
      
      private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent) : void
      {
         var _loc2_:RoomWidgetMeMenuMessage = null;
         if(UnknownVarFromMeMenuWidget_Boolean_1)
         {
            if(_mainWindow != null && WindowToggle.isHiddenByOtherWindows(_mainWindow))
            {
               _mainWindow.activate();
               return;
            }
            UnknownVarFromMeMenuWidget_Boolean_1 = false;
         }
         else
         {
            UnknownVarFromMeMenuWidget_Boolean_1 = true;
         }
         if(UnknownVarFromMeMenuWidget_Boolean_1)
         {
            _loc2_ = new RoomWidgetMeMenuMessage("RWMMM_MESSAGE_ME_MENU_OPENED");
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(_loc2_);
            }
            changeView("me_menu_top_view");
         }
         else
         {
            hide();
         }
      }
      
      private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent) : void
      {
         _hasEffectOn = false;
         for each(var _loc2_ in param1.effects)
         {
            if(_loc2_.isInUse)
            {
               _hasEffectOn = true;
            }
         }
      }
      
      private function onAvatarDeselected(param1:Event) : void
      {
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null && UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name != "me_menu_my_clothes_view")
         {
            hide();
         }
      }
      
      private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null && UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name == "me_menu_my_clothes_view")
         {
            changeView("me_menu_top_view");
         }
      }
      
      private function onHideAvatarEditor(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null && UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name == "me_menu_my_clothes_view")
         {
            changeView("me_menu_top_view");
         }
      }
      
      private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Wave Event received");
      }
      
      private function onMiniMailUpdate(param1:RoomWidgetMiniMailUpdateEvent) : void
      {
         if(UnknownVarFromMeMenuWidget_IMeMenuView_1)
         {
            UnknownVarFromMeMenuWidget_IMeMenuView_1.updateUnseenItemCount("minimail",handler.container.messenger.getUnseenMiniMailMessageCount());
         }
      }
      
      private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent) : void
      {
         Logger.log("[MeMenuWidget] Dance Event received, style: " + param1.style);
      }
      
      private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent) : void
      {
         var _loc2_:* = param1.daysLeft != _habboClubDays;
         _habboClubDays = param1.daysLeft;
         _habboClubPeriods = param1.periodsLeft;
         UnknownVarFromMeMenuWidget_Int_1 = param1.pastPeriods;
         _allowHabboClubDances = param1.allowClubDances;
         _loc2_ ||= param1.clubLevel != _habboClubLevel;
         _habboClubLevel = param1.clubLevel;
         if(_loc2_)
         {
            if(UnknownVarFromMeMenuWidget_IMeMenuView_1 != null)
            {
               changeView(UnknownVarFromMeMenuWidget_IMeMenuView_1.window.name);
            }
         }
      }
      
      private function onCreditBalance(param1:RoomWidgetPurseUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromMeMenuWidget_Int_2 = param1.balance;
         localizations.registerParameter("widget.memenu.credits","credits",UnknownVarFromMeMenuWidget_Int_2.toString());
      }
      
      private function onNormalMode(param1:RoomWidgetRoomEngineUpdateEvent) : void
      {
         _isGameMode = false;
      }
      
      private function onGameMode(param1:RoomWidgetRoomEngineUpdateEvent) : void
      {
         _isGameMode = true;
      }
      
      public function get allowHabboClubDances() : Boolean
      {
         return _allowHabboClubDances;
      }
      
      public function get isHabboClubActive() : Boolean
      {
         return _habboClubDays > 0;
      }
      
      public function get habboClubDays() : int
      {
         return _habboClubDays;
      }
      
      public function get habboClubPeriods() : int
      {
         return _habboClubPeriods;
      }
      
      public function get habboClubLevel() : int
      {
         return _habboClubLevel;
      }
      
      public function get isMinimailEnabled() : Boolean
      {
         return _isMinimailEnabled;
      }
      
      public function get config() : IComponent_1
      {
         return _config;
      }
      
      public function get hasEffectOn() : Boolean
      {
         return _hasEffectOn;
      }
      
      public function get isDancing() : Boolean
      {
         return _isDancing;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         _isDancing = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get unreadMiniMailMessageCount() : int
      {
         return handler.container.messenger.getUnseenMiniMailMessageCount();
      }
      
      override public function release() : void
      {
         hide();
         super.release();
      }
   }
}

