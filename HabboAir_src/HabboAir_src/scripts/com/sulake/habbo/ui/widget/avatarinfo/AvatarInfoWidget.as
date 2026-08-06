package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.CancelPetBreedingComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.ConfirmPetBreedingComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.BreedPetsMessageComposer;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.events.WiredUserClickHandledEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChangeNameConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotChatterMarkovConfiguration;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.BotSkillConfigurationViewBase;
   import com.sulake.habbo.ui.widget.avatarinfo.botskills.IBotSkillConfigurationViewBase;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetLevelUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetStatusUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   import com.sulake.habbo.ui.widget.memenu.UnknownIHabboUiWidgetMemenu1;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class AvatarInfoWidget extends RoomWidgetBase implements IProfiler_1, UnknownIHabboUiWidgetContextmenu1
   {
      private static const EFFECT_TYPE_RIDE:int = 77;
      
      private static const EFFECT_TYPE_DEEP_WATER:int = 29;
      
      private static const EFFECT_TYPE_SHALLOW_WATER:int = 30;
      
      private static const UnknownConstFromAvatarInfoWidget_Int_1:int = 185;
      
      private static const AVATAR_HIGHLIGHT_DURATION_MSEC:int = 5000;
      
      private static const UnknownConstFromAvatarInfoWidget_String_1:String = "avatar";
      
      private static const UnknownConstFromAvatarInfoWidget_String_2:String = "use_minimized_own_avatar_menu";
      
      private var _component:Component;
      
      private var _configuration:IComponent_1;
      
      private var UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1:AvatarContextInfoButtonView;
      
      private var UnknownVarFromAvatarInfoWidget_DecorateModeView_1:DecorateModeView;
      
      private var UnknownVarFromAvatarInfoWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromAvatarInfoWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromAvatarInfoWidget_Timer_1:Timer;
      
      private var UnknownVarFromAvatarInfoWidget_AvatarInfoData_1:AvatarInfoData;
      
      private var UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1:RentableBotInfoData;
      
      private var UnknownVarFromAvatarInfoWidget_PetInfoData_1:PetInfoData;
      
      private var UnknownVarFromAvatarInfoWidget_Int_1:int = -1;
      
      private var UnknownVarFromAvatarInfoWidget_Boolean_3:Boolean = true;
      
      private var UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2:AvatarContextInfoButtonView;
      
      private var _cachedOwnAvatarMenu:OwnAvatarMenuView;
      
      private var UnknownVarFromAvatarInfoWidget_AvatarMenuView_1:AvatarMenuView;
      
      private var UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1:RentableBotMenuView;
      
      private var UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1:OwnPetMenuView;
      
      private var UnknownVarFromAvatarInfoWidget_PetMenuView_1:PetMenuView;
      
      private var UnknownVarFromAvatarInfoWidget_NewUserHelpView_1:NewUserHelpView;
      
      private var _avatarNameBubbles:Map;
      
      private var _useProductBubbles:Map;
      
      private var _breedPetBubbles:Map;
      
      private var UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1:UseProductConfirmationView;
      
      private var UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1:BreedMonsterPlantsConfirmationView;
      
      private var UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1:ConfirmPetBreedingView;
      
      private var UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1:BreedPetsResultView;
      
      private var _breedingConfirmationAlert:UnknownICoreWindowUtils1;
      
      private var UnknownVarFromAvatarInfoWidget_Int_2:int = -1;
      
      private var UnknownVarFromAvatarInfoWidget_Int_3:int = -1;
      
      private var _isDancing:Boolean = false;
      
      private var _handlePetInfo:Boolean = true;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var UnknownVarFromAvatarInfoWidget_Map_1:Map = new Map();
      
      private var UnknownVarFromAvatarInfoWidget_Map_2:Map = new Map();
      
      private var UnknownVarFromAvatarInfoWidget_NestBreedingSuccessView_1:NestBreedingSuccessView;
      
      private var UnknownVarFromAvatarInfoWidget_Int_4:int;
      
      private var _buttonsSetup:Function;
      
      public function AvatarInfoWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IComponent_1, param5:IHabboLocalizationManager, param6:Component, param7:IHabboCatalog, param8:IHabboUserDefinedRoomEvents)
      {
         super(param1,param2,param3,param5);
         _component = param6;
         _catalog = param7;
         _roomEvents = param8;
         _configuration = param4;
         UnknownVarFromAvatarInfoWidget_AvatarInfoData_1 = new AvatarInfoData();
         UnknownVarFromAvatarInfoWidget_PetInfoData_1 = new PetInfoData();
         UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1 = null;
         _avatarNameBubbles = new Map();
         _useProductBubbles = new Map();
         _breedPetBubbles = new Map();
         this.handler.roomEngine.events.addEventListener("REOE_ADDED",onRoomObjectAdded);
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
         this.handler.container.inventory.events.addEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         _roomEvents.events.addEventListener("WIRED_USER_CLICK_HANDLED",onUserClickHandledEvent);
         this.handler.widget = this;
      }
      
      public function get component() : Component
      {
         return _component;
      }
      
      public function get handler() : AvatarInfoWidgetHandler
      {
         return _widgetHandler as AvatarInfoWidgetHandler;
      }
      
      public function get configuration() : IComponent_1
      {
         return _configuration;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localizations;
      }
      
      public function set handlePetInfo(param1:Boolean) : void
      {
         _handlePetInfo = param1;
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:IUserData = null;
         var _loc3_:IHabboFriendList = null;
         if(param1.category == 100 && handler != null && handler.roomSession != null)
         {
            _loc2_ = handler.roomSession.userDataManager.getUserDataByIndex(param1.objectId);
            _loc3_ = handler.friendList;
            if(_loc2_ && _loc3_)
            {
               if(handler.friendList.getFriendNames().indexOf(_loc2_.name) > -1)
               {
                  showUserName(_loc2_,param1.objectId);
               }
            }
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         if(param1.category == 100)
         {
            for each(var _loc2_ in _avatarNameBubbles)
            {
               if(_loc2_.objectId == param1.objectId)
               {
                  removeView(_loc2_,false);
               }
            }
            _loc4_ = [];
            for each(var _loc8_ in _breedPetBubbles)
            {
               _loc6_ = int(_loc8_.requestRoomObjectId);
               if(_loc6_ == _loc5_)
               {
                  _loc4_.push(_loc8_);
               }
            }
            for each(_loc8_ in _loc4_)
            {
               removeView(_loc8_,false);
            }
            if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1 != null)
            {
               if(param1.objectId == UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.requestRoomObjectId || param1.objectId == UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.targetRoomObjectId)
               {
                  removeBreedMonsterPlantsConfirmationView();
               }
            }
            if(UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1 != null)
            {
               if(param1.objectId == UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1.requestRoomObjectId || param1.objectId == UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1.targetRoomObjectId)
               {
                  removeConfirmPetBreedingView();
               }
            }
            if(UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1 != null)
            {
               if(param1.objectId == UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.requestObjectId || param1.objectId == UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.targetRoomObjectId)
               {
                  removeUseProductConfirmationView();
               }
            }
         }
         if(param1.category == 10)
         {
            _loc5_ = param1.objectId;
            if(UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1 != null)
            {
               if(UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.requestObjectId == _loc5_)
               {
                  removeUseProductConfirmationView();
               }
            }
            if(UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 != null)
            {
               UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.roomObjectRemoved(_loc5_);
            }
            _loc3_ = [];
            for each(var _loc7_ in _useProductBubbles)
            {
               _loc6_ = int(_loc7_.requestRoomObjectId);
               if(_loc6_ == _loc5_)
               {
                  _loc3_.push(_loc7_);
               }
            }
            for each(_loc7_ in _loc3_)
            {
               removeView(_loc7_,false);
            }
         }
      }
      
      public function showUseProductMenuForItems(param1:Array) : void
      {
         var _loc3_:IUserData = null;
         removeUseProductViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showUseProductMenu(_loc3_,_loc2_);
         }
      }
      
      public function showBreedPetMenuForItems(param1:Array) : void
      {
         var _loc3_:IUserData = null;
         removeBreedPetViews();
         removeUseProductConfirmationView();
         removeBreedMonsterPlantsConfirmationView();
         for each(var _loc2_ in param1)
         {
            _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.id);
            showBreedPetMenu(_loc3_,_loc2_);
         }
      }
      
      private function onEffectsChanged(param1:HabboInventoryEffectsEvent) : void
      {
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView)
         {
            (UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 as OwnAvatarMenuView).updateButtons();
         }
      }
      
      private function getOwnCharacterInfo() : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OWN_CHARACTER_INFO",0,0));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeAvatarHighlightTimer();
         _buttonsSetup = null;
         UnknownVarFromAvatarInfoWidget_Int_4 = -1;
         var _loc2_:IEventDispatcher = _roomEvents?.events;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener("WIRED_USER_CLICK_HANDLED",onUserClickHandledEvent);
         }
         _roomEvents = null;
         for each(var _loc1_ in _avatarNameBubbles)
         {
            _loc1_.dispose();
         }
         _avatarNameBubbles = null;
         for each(var _loc3_ in _useProductBubbles)
         {
            _loc3_.dispose();
         }
         _useProductBubbles = null;
         for each(var _loc5_ in _breedPetBubbles)
         {
            _loc5_.dispose();
         }
         _breedPetBubbles = null;
         if(_component)
         {
            _component.removeUpdateReceiver(this);
            _component = null;
         }
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2)
         {
            UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2.dispose();
            UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2 = null;
         }
         if(UnknownVarFromAvatarInfoWidget_AvatarMenuView_1)
         {
            UnknownVarFromAvatarInfoWidget_AvatarMenuView_1.dispose();
            UnknownVarFromAvatarInfoWidget_AvatarMenuView_1 = null;
         }
         if(_cachedOwnAvatarMenu)
         {
            _cachedOwnAvatarMenu.dispose();
            _cachedOwnAvatarMenu = null;
         }
         if(UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1)
         {
            UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1.dispose();
            UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1 = null;
         }
         if(UnknownVarFromAvatarInfoWidget_PetMenuView_1)
         {
            UnknownVarFromAvatarInfoWidget_PetMenuView_1.dispose();
            UnknownVarFromAvatarInfoWidget_PetMenuView_1 = null;
         }
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
         {
            if(!UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.disposed)
            {
               UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.dispose();
               UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = null;
            }
         }
         if(UnknownVarFromAvatarInfoWidget_DecorateModeView_1)
         {
            UnknownVarFromAvatarInfoWidget_DecorateModeView_1.dispose();
            UnknownVarFromAvatarInfoWidget_DecorateModeView_1 = null;
         }
         if(UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1)
         {
            UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.dispose();
            UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1 = null;
         }
         removeBreedMonsterPlantsConfirmationView();
         removeConfirmPetBreedingView();
         if(UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1)
         {
            UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.dispose();
            UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 = null;
         }
         if(_breedingConfirmationAlert)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
         }
         if(UnknownVarFromAvatarInfoWidget_Map_1)
         {
            for each(var _loc4_ in UnknownVarFromAvatarInfoWidget_Map_1.getKeys())
            {
               BotSkillConfigurationViewBase(UnknownVarFromAvatarInfoWidget_Map_1.getValue(_loc4_)).dispose();
            }
            UnknownVarFromAvatarInfoWidget_Map_1.dispose();
            UnknownVarFromAvatarInfoWidget_Map_1 = null;
         }
         if(UnknownVarFromAvatarInfoWidget_Map_2 && UnknownVarFromAvatarInfoWidget_Map_2.length > 0)
         {
            UnknownVarFromAvatarInfoWidget_Map_2.dispose();
            UnknownVarFromAvatarInfoWidget_Map_2 = null;
         }
         handler.roomEngine.events.removeEventListener("REOE_ADDED",onRoomObjectAdded);
         handler.roomEngine.events.removeEventListener("REOE_REMOVED",onRoomObjectRemoved);
         handler.container.inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED",onEffectsChanged);
         UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = null;
         _configuration = null;
         super.dispose();
      }
      
      public function close() : void
      {
         removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.addEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.addEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.addEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.addEventListener("RWUIUE_PEER",updateEventHandler);
         param1.addEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.addEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.addEventListener("RWUIUE_BOT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.addEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.addEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.addEventListener("RWONE_TYPE",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OVER",updateEventHandler);
         param1.addEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.addEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.addEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.addEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.addEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.addEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRBFOCME_OPEN",updateEventHandler);
         param1.removeEventListener("RWRBSLUE_SKILL_LIST",updateEventHandler);
         param1.removeEventListener("RWRBIUE_RENTABLE_BOT",updateEventHandler);
         param1.removeEventListener("RWAIE_AVATAR_INFO",updateEventHandler);
         param1.removeEventListener("RWUIUE_OWN_USER",updateEventHandler);
         param1.removeEventListener("RWUIUE_PEER",updateEventHandler);
         param1.removeEventListener("RWROUE_FURNI_ADDED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",updateEventHandler);
         param1.removeEventListener("RWFIUE_FURNI",updateEventHandler);
         param1.removeEventListener("RWUIUE_BOT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_INFO",updateEventHandler);
         param1.removeEventListener("rwudue_user_data_updated",updateEventHandler);
         param1.removeEventListener("RWROUE_USER_REMOVED",updateEventHandler);
         param1.removeEventListener("RWONE_TYPE",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWROUE_OBJECT_ROLL_OUT",updateEventHandler);
         param1.removeEventListener("RWPIUE_PET_STATUS_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPLUE_PET_LEVEL_UPDATE",updateEventHandler);
         param1.removeEventListener("RWPBRE_PET_BREEDING_RESULT",updateEventHandler);
         param1.removeEventListener("RWPPBE_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWIUM_INVENTORY_UPDATED",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_",updateEventHandler);
         param1.removeEventListener("RWPPBE_CONFIRM_PET_BREEDING_RESULT",updateEventHandler);
      }
      
      private function updateEventHandler(param1:RoomWidgetUpdateEvent) : void
      {
         var _loc12_:RoomWidgetAvatarInfoEvent = null;
         var _loc8_:RoomWidgetPetStatusUpdateEvent = null;
         var _loc3_:IUserData = null;
         var _loc22_:RoomWidgetPetLevelUpdateEvent = null;
         var _loc27_:IUserData = null;
         var _loc2_:RoomWidgetPetBreedingResultEvent = null;
         var _loc4_:BreedPetsResultData = null;
         var _loc14_:BreedPetsResultData = null;
         var _loc20_:RoomWidgetPetBreedingEvent = null;
         var _loc7_:int = 0;
         var _loc25_:int = 0;
         var _loc16_:RoomWidgetConfirmPetBreedingEvent = null;
         var _loc15_:RoomWidgetConfirmPetBreedingResultEvent = null;
         var _loc9_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc11_:AvatarInfoData = null;
         var _loc13_:RoomWidgetRentableBotInfoUpdateEvent = null;
         var _loc5_:IRoomSession = null;
         var _loc26_:IUserData = null;
         var _loc23_:RoomWidgetRentableBotSkillListUpdateEvent = null;
         var _loc18_:RoomWidgetRentableBotForceOpenContextMenuEvent = null;
         var _loc21_:int = 0;
         var _loc17_:IUserData = null;
         var _loc6_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc24_:RoomWidgetPetInfoUpdateEvent = null;
         var _loc19_:RoomWidgetRoomObjectUpdateEvent = null;
         switch(param1.type)
         {
            case "RWAIE_AVATAR_INFO":
               _loc12_ = param1 as RoomWidgetAvatarInfoEvent;
               UnknownVarFromAvatarInfoWidget_Boolean_2 = !UnknownVarFromAvatarInfoWidget_Boolean_1 && handler.container.roomSession != null && _loc12_.roomIndex == handler.container.roomSession.ownUserRoomId;
               if(_loc12_.allowNameChange)
               {
                  useMinimizedOwnAvatarMenu = true;
                  selectOwnAvatar();
               }
               else
               {
                  updateUserView(_loc12_.userId,_loc12_.userName,_loc12_.userType,_loc12_.roomIndex,_loc12_.allowNameChange,null);
               }
               UnknownVarFromAvatarInfoWidget_Boolean_1 = true;
               break;
            case "RWONE_TYPE":
               if(RoomWidgetRoomObjectNameEvent(param1).category == 100)
               {
                  updateUserView(RoomWidgetRoomObjectNameEvent(param1).userId,RoomWidgetRoomObjectNameEvent(param1).userName,RoomWidgetRoomObjectNameEvent(param1).userType,RoomWidgetRoomObjectNameEvent(param1).roomIndex,false,null);
               }
               break;
            case "RWROUE_FURNI_ADDED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 10)
               {
                  if(UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 != null)
                  {
                     UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.roomObjectAdded(RoomWidgetRoomObjectUpdateEvent(param1).id);
                  }
               }
               break;
            case "RWROUE_OBJECT_SELECTED":
               if(RoomWidgetRoomObjectUpdateEvent(param1).category == 100)
               {
                  _handlePetInfo = true;
               }
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_DESELECTED":
               if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && !(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is NewUserHelpView))
               {
                  removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWFIUE_FURNI":
               if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
               {
                  removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
               }
               removeUseProductViews();
               removeBreedPetViews();
               break;
            case "RWROUE_OBJECT_ROLL_OVER":
               if(UnknownVarFromAvatarInfoWidget_Boolean_2)
               {
                  return;
               }
               if(!(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is NewUserHelpView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView))
               {
                  UnknownVarFromAvatarInfoWidget_Int_1 = RoomWidgetRoomObjectUpdateEvent(param1).id;
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_NAME",RoomWidgetRoomObjectUpdateEvent(param1).id,RoomWidgetRoomObjectUpdateEvent(param1).category));
               }
               break;
            case "RWROUE_OBJECT_ROLL_OUT":
               if(UnknownVarFromAvatarInfoWidget_Boolean_2)
               {
                  return;
               }
               if(!(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is NewUserHelpView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView))
               {
                  if(RoomWidgetRoomObjectUpdateEvent(param1).id == UnknownVarFromAvatarInfoWidget_Int_1)
                  {
                     if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && !UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.allowNameChange)
                     {
                        removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
                        UnknownVarFromAvatarInfoWidget_Int_1 = -1;
                     }
                  }
               }
               break;
            case "RWPIUE_PET_STATUS_UPDATE":
               _loc8_ = param1 as RoomWidgetPetStatusUpdateEvent;
               if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView)
               {
                  if(_loc8_ != null && UnknownVarFromAvatarInfoWidget_PetInfoData_1 != null)
                  {
                     _loc3_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc8_.petId);
                     if(_loc3_ != null && _loc3_.webID == UnknownVarFromAvatarInfoWidget_PetInfoData_1.id)
                     {
                        removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,true);
                     }
                  }
               }
               if(_loc8_ != null)
               {
                  removeBreedPetViewsWithId(_loc8_.petId);
               }
               break;
            case "RWPLUE_PET_LEVEL_UPDATE":
               _loc22_ = param1 as RoomWidgetPetLevelUpdateEvent;
               if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView)
               {
                  if(_loc22_ != null && UnknownVarFromAvatarInfoWidget_PetInfoData_1 != null)
                  {
                     _loc27_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc22_.petId);
                     if(_loc27_ != null && _loc27_.webID == UnknownVarFromAvatarInfoWidget_PetInfoData_1.id)
                     {
                        removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,true);
                     }
                  }
               }
               if(_loc22_ != null)
               {
                  removeBreedPetViewsWithId(_loc22_.petId);
               }
               break;
            case "RWPBRE_PET_BREEDING_RESULT":
               _loc2_ = param1 as RoomWidgetPetBreedingResultEvent;
               _loc4_ = new BreedPetsResultData();
               _loc4_.stuffId = _loc2_.resultData.stuffId;
               _loc4_.classId = _loc2_.resultData.classId;
               _loc4_.productCode = _loc2_.resultData.productCode;
               _loc4_.userId = _loc2_.resultData.userId;
               _loc4_.userName = _loc2_.resultData.userName;
               _loc4_.rarityLevel = _loc2_.resultData.rarityLevel;
               _loc4_.hasMutation = _loc2_.resultData.hasMutation;
               _loc14_ = new BreedPetsResultData();
               _loc14_.stuffId = _loc2_.resultData2.stuffId;
               _loc14_.classId = _loc2_.resultData2.classId;
               _loc14_.productCode = _loc2_.resultData2.productCode;
               _loc14_.userId = _loc2_.resultData2.userId;
               _loc14_.userName = _loc2_.resultData2.userName;
               _loc14_.rarityLevel = _loc2_.resultData2.rarityLevel;
               _loc14_.hasMutation = _loc2_.resultData2.hasMutation;
               showBreedPetsResultView(_loc4_,_loc14_);
               break;
            case "RWPPBE_PET_BREEDING_":
               _loc20_ = param1 as RoomWidgetPetBreedingEvent;
               _loc7_ = findPetRoomObjectIdByWebId(_loc20_.ownPetId);
               _loc25_ = findPetRoomObjectIdByWebId(_loc20_.otherPetId);
               switch(_loc20_.state)
               {
                  case 0:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,false);
                     break;
                  case 1:
                     cancelBreedingPets(_loc7_,_loc25_);
                     break;
                  case 2:
                     acceptBreedingPets(_loc7_,_loc25_);
                     break;
                  case 3:
                     showBreedMonsterPlantsConfirmationView(_loc7_,_loc25_,true);
               }
               break;
            case "RWIUM_INVENTORY_UPDATED":
               if(UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 != null)
               {
                  UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.updatePlacingButtons();
               }
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_":
               _loc16_ = param1 as RoomWidgetConfirmPetBreedingEvent;
               showConfirmPetBreedingView(_loc16_.pet1,_loc16_.pet2,_loc16_.nestId,_loc16_.rarityCategories,_loc16_.resultPetTypeId);
               break;
            case "RWPPBE_CONFIRM_PET_BREEDING_RESULT":
               switch((_loc15_ = param1 as RoomWidgetConfirmPetBreedingResultEvent).result)
               {
                  case 0:
                     removeConfirmPetBreedingView();
                     break;
                  case 1:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.nonest.head}","${breedpets.confirmation.alert.nonest.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 2:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.petsmissing.head}","${breedpets.confirmation.alert.petsmissing.desc}");
                     removeConfirmPetBreedingView();
                     break;
                  case 3:
                     windowManager.simpleAlert("${breedpets.confirmation.alert.title}","${breedpets.confirmation.alert.name.invalid.head}","${breedpets.confirmation.alert.name.invalid.desc}");
                     if(UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1)
                     {
                        UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1.enable();
                     }
               }
               break;
            case "RWUIUE_OWN_USER":
            case "RWUIUE_PEER":
               _loc9_ = param1 as RoomWidgetUserInfoUpdateEvent;
               UnknownVarFromAvatarInfoWidget_AvatarInfoData_1.populate(_loc9_);
               _loc11_ = _loc9_.isSpectatorMode ? null : UnknownVarFromAvatarInfoWidget_AvatarInfoData_1;
               updateUserView(_loc9_.webID,_loc9_.name,_loc9_.userType,_loc9_.userRoomId,UnknownVarFromAvatarInfoWidget_AvatarInfoData_1.allowNameChange,_loc11_);
               break;
            case "RWRBIUE_RENTABLE_BOT":
               _loc13_ = param1 as RoomWidgetRentableBotInfoUpdateEvent;
               if(!UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1)
               {
                  UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1 = new RentableBotInfoData();
               }
               UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.populate(_loc13_);
               _loc5_ = handler.container.roomSessionManager.getSession(_loc21_);
               if(!_loc5_)
               {
                  return;
               }
               _loc26_ = _loc5_.userDataManager.getRentableBotUserData(_loc13_.webID);
               if(!_loc26_)
               {
                  return;
               }
               UnknownVarFromAvatarInfoWidget_Map_2[_loc13_.webID.toString()] = _loc26_.botSkillData;
               if(UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1 && _loc26_.botSkillData)
               {
                  UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.cloneAndSetSkillsWithCommands(_loc26_.botSkillData);
               }
               updateRentableBotView(_loc13_.webID,_loc13_.name,_loc13_.userRoomId,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1);
               break;
            case "RWRBSLUE_SKILL_LIST":
               _loc23_ = param1 as RoomWidgetRentableBotSkillListUpdateEvent;
               UnknownVarFromAvatarInfoWidget_Map_2[_loc23_.botId.toString()] = _loc23_.botSkillsWithCommands;
               if(UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1)
               {
                  UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.cloneAndSetSkillsWithCommands(_loc23_.botSkillsWithCommands);
                  updateRentableBotView(UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.id,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.name,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.roomIndex,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1,true);
               }
               break;
            case "RWRBFOCME_OPEN":
               _loc18_ = param1 as RoomWidgetRentableBotForceOpenContextMenuEvent;
               if(UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1)
               {
                  updateRentableBotView(UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.id,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.name,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1.roomIndex,UnknownVarFromAvatarInfoWidget_RentableBotInfoData_1,false,true);
               }
               else
               {
                  _loc21_ = handler.container.roomEngine.activeRoomId;
                  _loc17_ = handler.container.roomSessionManager.getSession(_loc21_).userDataManager.getUserDataByType(_loc18_.botId,4);
                  messageListener.processWidgetMessage(new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",_loc17_.roomObjectId,100));
                  handler.container.roomEngine.selectAvatar(_loc21_,_loc17_.roomObjectId);
               }
               break;
            case "RWUIUE_BOT":
               _loc6_ = param1 as RoomWidgetUserInfoUpdateEvent;
               updateUserView(_loc6_.webID,_loc6_.name,_loc6_.userType,_loc6_.userRoomId,false,null);
               break;
            case "RWPIUE_PET_INFO":
               if(_handlePetInfo)
               {
                  _loc24_ = param1 as RoomWidgetPetInfoUpdateEvent;
                  UnknownVarFromAvatarInfoWidget_PetInfoData_1.populate(_loc24_);
                  updatePetView(_loc24_.id,_loc24_.name,_loc24_.roomIndex,UnknownVarFromAvatarInfoWidget_PetInfoData_1);
               }
               break;
            case "rwudue_user_data_updated":
               if(!UnknownVarFromAvatarInfoWidget_Boolean_1)
               {
                  getOwnCharacterInfo();
               }
               break;
            case "RWROUE_USER_REMOVED":
               _loc19_ = param1 as RoomWidgetRoomObjectUpdateEvent;
               if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.roomIndex == _loc19_.id)
               {
                  removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
               }
               for each(var _loc10_ in _avatarNameBubbles)
               {
                  if(_loc10_.objectId == _loc19_.id)
                  {
                     removeView(_loc10_,false);
                     break;
                  }
               }
               removeBreedPetViewsWithId(_loc19_.id);
         }
         checkUpdateNeed();
      }
      
      private function findPetRoomObjectIdByWebId(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc6_:IUserData = null;
         var _loc5_:int = handler.container.roomSession.roomId;
         var _loc3_:int = handler.container.roomEngine.getRoomObjectCount(_loc5_,100);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.container.roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
            _loc6_ = handler.container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
            if(!(_loc6_ == null || _loc6_.type != 2))
            {
               if(_loc6_.webID == param1)
               {
                  return _loc2_.getId();
               }
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function removeBreedPetViewsWithId(param1:int) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _breedPetBubbles)
         {
            if(_loc2_.objectId == param1 || _loc2_.requestRoomObjectId == param1)
            {
               if(_loc3_.indexOf(_loc2_) == -1)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         for each(var _loc4_ in _loc3_)
         {
            removeView(_loc4_,false);
         }
      }
      
      public function selectOwnAvatar() : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = null;
         if(!handler || !handler.container || !handler.roomSession)
         {
            return;
         }
         var _loc3_:int = handler.container.sessionDataManager.userId;
         var _loc1_:IUserData = handler.roomSession.userDataManager.getUserData(_loc3_);
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = new RoomWidgetRoomObjectMessage("RWROM_SELECT_OBJECT",_loc1_.roomObjectId,100);
         handler.container.processWidgetMessage(_loc2_);
      }
      
      public function get ownAvatarPosture() : String
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getString("figure_posture");
            }
         }
         return "std";
      }
      
      public function get canStandUp() : Boolean
      {
         var _loc2_:IRoomObjectModel = null;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.getModel();
            if(_loc2_ != null)
            {
               return _loc2_.getNumber("figure_can_stand_up") > 0;
            }
         }
         return false;
      }
      
      public function get isSwimming() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getNumber("figure_effect");
               return _loc2_ == 29 || _loc2_ == 30 || _loc2_ == 185;
            }
         }
         return false;
      }
      
      private function updateRentableBotView(param1:int, param2:String, param3:int, param4:RentableBotInfoData, param5:Boolean = false, param6:Boolean = false) : void
      {
         var showBotContextMenu:Boolean;
         var doNotOpen:Boolean;
         var botId:int = param1;
         var name:String = param2;
         var roomIndex:int = param3;
         var data:RentableBotInfoData = param4;
         var keepClosed:Boolean = param5;
         var forceOpen:Boolean = param6;
         if(!data)
         {
            return;
         }
         showBotContextMenu = _configuration.getBoolean("menu.bot.enabled");
         doNotOpen = keepClosed && !UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1;
         if(forceOpen)
         {
            doNotOpen = false;
         }
         if(showBotContextMenu && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && !(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is PetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView))
         {
            removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
         }
         removeUseProductViews();
         if(forceOpen || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 != null && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userId == botId && !keepClosed || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 == null || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userId != botId || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName != name || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.roomIndex != roomIndex || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userType != 4)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
            if(!isGameMode())
            {
               if(!UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1)
               {
                  UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1 = new RentableBotMenuView(this);
               }
               if(!doNotOpen)
               {
                  UnknownVarFromAvatarInfoWidget_Int_4 = roomIndex;
                  _buttonsSetup = function():void
                  {
                     UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1;
                     RentableBotMenuView.setup(UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1 as RentableBotMenuView,botId,name,roomIndex,4,data);
                  };
                  maybeSetupMenuView(roomIndex);
               }
            }
         }
         else if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName == name)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
         }
      }
      
      private function updatePetView(param1:int, param2:String, param3:int, param4:PetInfoData) : void
      {
         var petId:int = param1;
         var userName:String = param2;
         var roomIndex:int = param3;
         var petData:PetInfoData = param4;
         if(!petData)
         {
            return;
         }
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && !(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is PetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView))
         {
            removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
         }
         removeUseProductViews();
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 == null || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userId != petId || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName != userName || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.roomIndex != roomIndex || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userType != 2)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
            if(!isGameMode())
            {
               UnknownVarFromAvatarInfoWidget_Int_4 = roomIndex;
               if(petData.isOwnPet)
               {
                  if(!UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1)
                  {
                     UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1 = new OwnPetMenuView(this,_catalog);
                  }
                  _buttonsSetup = function():void
                  {
                     UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1;
                     OwnPetMenuView.setup(UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1 as OwnPetMenuView,petId,userName,roomIndex,2,petData);
                  };
               }
               else
               {
                  if(!UnknownVarFromAvatarInfoWidget_PetMenuView_1)
                  {
                     UnknownVarFromAvatarInfoWidget_PetMenuView_1 = new PetMenuView(this);
                  }
                  _buttonsSetup = function():void
                  {
                     UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_PetMenuView_1;
                     PetMenuView.setup(UnknownVarFromAvatarInfoWidget_PetMenuView_1 as PetMenuView,petId,userName,roomIndex,2,petData);
                  };
               }
               maybeSetupMenuView(roomIndex);
            }
         }
         else if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName == userName)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
         }
      }
      
      private function maybeSetupMenuView(param1:int) : void
      {
         if(_roomEvents.hasClickUserWired())
         {
            return;
         }
         setupMenuView(param1);
      }
      
      private function onUserClickHandledEvent(param1:WiredUserClickHandledEvent) : void
      {
         if(disposed || !param1.openMenu || _buttonsSetup == null)
         {
            return;
         }
         setupMenuView(param1.index);
         checkUpdateNeed();
      }
      
      private function setupMenuView(param1:int) : void
      {
         if(UnknownVarFromAvatarInfoWidget_Int_4 == param1 && _buttonsSetup != null)
         {
            _buttonsSetup();
            UnknownVarFromAvatarInfoWidget_Int_4 = -1;
            _buttonsSetup = null;
         }
      }
      
      private function isGameMode() : Boolean
      {
         return handler != null && handler.roomEngine != null && handler.roomEngine.getActiveRoomIsPlayingGame();
      }
      
      private function updateUserView(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:AvatarInfoData) : void
      {
         var friendNameView:UserNameView;
         var blocked:Boolean;
         var userId:int = param1;
         var userName:String = param2;
         var userType:int = param3;
         var roomIndex:int = param4;
         var allowNameChange:Boolean = param5;
         var data:AvatarInfoData = param6;
         var showAvatarContextMenu:Boolean = data != null;
         if(showAvatarContextMenu && UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 && !(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is PetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnPetMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is RentableBotMenuView))
         {
            removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
         }
         removeUseProductViews();
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 == null || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userId != userId || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName != userName || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.roomIndex != roomIndex || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userType != 1 || allowNameChange)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
            if(!isGameMode())
            {
               if(showAvatarContextMenu)
               {
                  UnknownVarFromAvatarInfoWidget_Int_4 = roomIndex;
                  _buttonsSetup = null;
                  if(data.isOwnUser)
                  {
                     if(isUserDecorating)
                     {
                        return;
                     }
                     if(RoomEnterEffect.isRunning())
                     {
                        if(!UnknownVarFromAvatarInfoWidget_NewUserHelpView_1)
                        {
                           UnknownVarFromAvatarInfoWidget_NewUserHelpView_1 = new NewUserHelpView(this);
                        }
                        _buttonsSetup = function():void
                        {
                           UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_NewUserHelpView_1;
                           NewUserHelpView.setup(UnknownVarFromAvatarInfoWidget_NewUserHelpView_1 as NewUserHelpView,userId,userName,roomIndex,1);
                        };
                     }
                     else
                     {
                        if(!_cachedOwnAvatarMenu)
                        {
                           _cachedOwnAvatarMenu = new OwnAvatarMenuView(this);
                        }
                        _buttonsSetup = function():void
                        {
                           UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = _cachedOwnAvatarMenu;
                           OwnAvatarMenuView.setup(_cachedOwnAvatarMenu as OwnAvatarMenuView,userId,userName,roomIndex,1,data);
                        };
                     }
                  }
                  else
                  {
                     if(!UnknownVarFromAvatarInfoWidget_AvatarMenuView_1)
                     {
                        UnknownVarFromAvatarInfoWidget_AvatarMenuView_1 = new AvatarMenuView(this);
                     }
                     _buttonsSetup = function():void
                     {
                        UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_AvatarMenuView_1;
                        AvatarMenuView.setup(UnknownVarFromAvatarInfoWidget_AvatarMenuView_1 as AvatarMenuView,userId,userName,roomIndex,userType,data);
                     };
                     for each(friendNameView in _avatarNameBubbles)
                     {
                        if(friendNameView.userId == userId)
                        {
                           removeView(friendNameView,false);
                           break;
                        }
                     }
                  }
                  maybeSetupMenuView(roomIndex);
               }
               else if(!handler.roomEngine.isDecorateMode)
               {
                  if(!UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2)
                  {
                     UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2 = new AvatarContextInfoButtonView(this);
                  }
                  UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2;
                  blocked = handler.container.sessionDataManager.isBlocked(userId);
                  if(handler.container.sessionDataManager.userId == userId)
                  {
                     AvatarContextInfoButtonView.setup(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,userId,userName,roomIndex,userType,allowNameChange,false,blocked);
                     if(UnknownVarFromAvatarInfoWidget_Boolean_2)
                     {
                        _catalog.windowManager.registerHintWindow("avatar",UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.window);
                        _catalog.windowManager.showHint("avatar");
                        if(!handler.container.sessionDataManager.isNoob)
                        {
                           setAvatarHightlightTimer();
                        }
                     }
                  }
                  else
                  {
                     AvatarContextInfoButtonView.setup(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,userId,userName,roomIndex,userType,allowNameChange,true,blocked);
                  }
               }
            }
         }
         else if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is AvatarMenuView || UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 is OwnAvatarMenuView)
         {
            if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userName == userName)
            {
               removeView(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1,false);
            }
         }
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         UnknownVarFromAvatarInfoWidget_Boolean_2 = false;
         removeAvatarHighlightTimer();
         if(param1)
         {
            if(UnknownVarFromAvatarInfoWidget_Boolean_3)
            {
               param1.hide(param2);
            }
            else
            {
               param1.dispose();
               UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_2 = null;
               UnknownVarFromAvatarInfoWidget_AvatarMenuView_1 = null;
               _cachedOwnAvatarMenu = null;
               UnknownVarFromAvatarInfoWidget_OwnPetMenuView_1 = null;
               UnknownVarFromAvatarInfoWidget_RentableBotMenuView_1 = null;
               UnknownVarFromAvatarInfoWidget_PetMenuView_1 = null;
               UnknownVarFromAvatarInfoWidget_NewUserHelpView_1 = null;
            }
            if(param1 == UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
            {
               UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 = null;
            }
            if(param1 is UserNameView)
            {
               _avatarNameBubbles.remove((param1 as UserNameView).userName);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is UseProductView)
            {
               _useProductBubbles.remove((param1 as UseProductView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
            if(param1 is BreedPetView)
            {
               _breedPetBubbles.remove((param1 as BreedPetView).userId);
               param1.dispose();
               checkUpdateNeed();
            }
         }
      }
      
      public function removeUseProductViews() : void
      {
         for each(var _loc1_ in _useProductBubbles)
         {
            _loc1_.dispose();
         }
         _useProductBubbles.reset();
         checkUpdateNeed();
      }
      
      public function removeBreedPetViews() : void
      {
         for each(var _loc1_ in _breedPetBubbles)
         {
            _loc1_.dispose();
         }
         _breedPetBubbles.reset();
         checkUpdateNeed();
      }
      
      public function showUserName(param1:IUserData, param2:int) : void
      {
         if(windowManager.LilithCustomsInstance.OnShowUserNameEntranceHighlight(param1) == false)
         {
            return;
         }
         var _loc3_:UserNameView = null;
         if(_avatarNameBubbles[param1.name] == null)
         {
            _loc3_ = new UserNameView(this);
            UserNameView.setup(_loc3_,param1.webID,param1.name,-1,1,param2,4288528218,8000,param1.isBlocked);
            _avatarNameBubbles[param1.name] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:UserNameView = null;
         if(_avatarNameBubbles[param2] == null)
         {
            _loc5_ = new UserNameView(this,true);
            UserNameView.setup(_loc5_,param1,param2,param1,1,param1,param3,param4);
            _avatarNameBubbles[param2] = _loc5_;
            checkUpdateNeed();
         }
      }
      
      private function showUseProductMenu(param1:IUserData, param2:UseProductItem) : void
      {
         var _loc3_:UseProductView = null;
         if(_useProductBubbles[param1.webID.toString()] == null)
         {
            _loc3_ = new UseProductView(this);
            UseProductView.setup(_loc3_,param1.webID,param1.name,-1,2,param2);
            _useProductBubbles[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function showBreedPetMenu(param1:IUserData, param2:UseProductItem) : void
      {
         var _loc3_:BreedPetView = null;
         if(_breedPetBubbles[param1.webID.toString()] == null)
         {
            _loc3_ = new BreedPetView(this);
            BreedPetView.setup(_loc3_,param1.webID,param1.name,-1,2,param2,param1.canBreed);
            _breedPetBubbles[param1.webID.toString()] = _loc3_;
            checkUpdateNeed();
         }
      }
      
      private function setAvatarHightlightTimer() : void
      {
         UnknownVarFromAvatarInfoWidget_Timer_1 = new Timer(5000);
         UnknownVarFromAvatarInfoWidget_Timer_1.addEventListener("timer",onAvatarHighlightTimerEvent);
         UnknownVarFromAvatarInfoWidget_Timer_1.start();
      }
      
      private function removeAvatarHighlightTimer() : void
      {
         UnknownVarFromAvatarInfoWidget_Boolean_2 = false;
         _catalog.windowManager.unregisterHintWindow("avatar");
         if(!UnknownVarFromAvatarInfoWidget_Timer_1)
         {
            return;
         }
         UnknownVarFromAvatarInfoWidget_Timer_1.stop();
         UnknownVarFromAvatarInfoWidget_Timer_1 = null;
      }
      
      private function onAvatarHighlightTimerEvent(param1:TimerEvent) : void
      {
         removeAvatarHighlightTimer();
      }
      
      public function checkUpdateNeed() : void
      {
         if(!_component)
         {
            return;
         }
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1 || _avatarNameBubbles.length > 0 || _useProductBubbles.length > 0 || _breedPetBubbles.length > 0 || UnknownVarFromAvatarInfoWidget_DecorateModeView_1 && UnknownVarFromAvatarInfoWidget_DecorateModeView_1.isVisible)
         {
            _component.registerUpdateReceiver(this,10);
         }
         else
         {
            _component.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         if(UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userId,UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            UnknownVarFromAvatarInfoWidget_AvatarContextInfoButtonView_1.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         if(UnknownVarFromAvatarInfoWidget_DecorateModeView_1 && UnknownVarFromAvatarInfoWidget_DecorateModeView_1.isVisible())
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",UnknownVarFromAvatarInfoWidget_DecorateModeView_1.userId,UnknownVarFromAvatarInfoWidget_DecorateModeView_1.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(!_loc3_)
            {
               return;
            }
            UnknownVarFromAvatarInfoWidget_DecorateModeView_1.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
         }
         for each(var _loc2_ in _avatarNameBubbles)
         {
            if(_loc2_.isGameRoomMode)
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            else
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc2_.userId,_loc2_.userType)) as RoomWidgetUserLocationUpdateEvent;
            }
            if(_loc3_)
            {
               _loc2_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc4_ in _useProductBubbles)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc4_.userId,_loc4_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc4_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
         for each(var _loc5_ in _breedPetBubbles)
         {
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_.userId,_loc5_.userType)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               _loc5_.update(_loc3_.rectangle,_loc3_.screenLocation,param1);
            }
         }
      }
      
      public function openAvatarEditor() : void
      {
         handler.container.avatarEditor.openEditor(0,null,null,true);
         handler.container.avatarEditor.loadOwnAvatarInEditor(0);
      }
      
      public function get hasClub() : Boolean
      {
         return handler.container.sessionDataManager.hasClub;
      }
      
      public function get hasVip() : Boolean
      {
         return handler.container.sessionDataManager.hasVip;
      }
      
      public function get hasEffectOn() : Boolean
      {
         var _loc1_:Array = handler.container.inventory.getActivatedAvatarEffects();
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.isInUse)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         _isDancing = param1;
      }
      
      public function get isDancing() : Boolean
      {
         return _isDancing;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         if(UnknownVarFromAvatarInfoWidget_PetInfoData_1 != null)
         {
            return UnknownVarFromAvatarInfoWidget_PetInfoData_1.hasFreeSaddle;
         }
         return false;
      }
      
      public function get isRiding() : Boolean
      {
         if(UnknownVarFromAvatarInfoWidget_PetInfoData_1 != null)
         {
            return UnknownVarFromAvatarInfoWidget_PetInfoData_1.isRiding;
         }
         return false;
      }
      
      public function get isCurrentUserRiding() : Boolean
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc1_:IRoomObject = findCurrentUserRoomObject();
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getNumber("figure_effect");
               if(_loc2_ == 77)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function openTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_OPEN_PET_TRAINING"));
      }
      
      public function closeTrainingView() : void
      {
         handler.container.events.dispatchEvent(new RoomWidgetUpdateEvent("RWPCUE_CLOSE_PET_TRAINING"));
      }
      
      public function get useMinimizedOwnAvatarMenu() : Boolean
      {
         return handler.container.config.getBoolean("use_minimized_own_avatar_menu");
      }
      
      public function set useMinimizedOwnAvatarMenu(param1:Boolean) : void
      {
         handler.container.config.setProperty("use_minimized_own_avatar_menu",param1 ? "1" : "0");
      }
      
      public function sendSignRequest(param1:int) : void
      {
         handler.container.roomSession.sendSignMessage(param1);
      }
      
      public function showUseProductConfirmation(param1:int, param2:int, param3:int) : void
      {
         if(!UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1)
         {
            UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1 = new UseProductConfirmationView(this);
         }
         UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.open(param1,param2,param3);
      }
      
      private function removeUseProductConfirmationView() : void
      {
         if(UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1)
         {
            UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1.dispose();
            UnknownVarFromAvatarInfoWidget_UseProductConfirmationView_1 = null;
         }
      }
      
      public function showBreedingPetsWaitingConfirmationAlert(param1:int, param2:int) : void
      {
         removeBreedingPetsWaitingConfirmationAlert();
         _breedingConfirmationAlert = windowManager.confirm("${breedpets.confirmation.notification.title}","${breedpets.confirmation.notification.text}",0,onWaitingConfirmationAlert);
         UnknownVarFromAvatarInfoWidget_Int_2 = param1;
         UnknownVarFromAvatarInfoWidget_Int_3 = param2;
      }
      
      public function onWaitingConfirmationAlert(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
         }
         if(param2.type == "WE_CANCEL")
         {
            if(UnknownVarFromAvatarInfoWidget_Int_3 != -1 && UnknownVarFromAvatarInfoWidget_Int_3 != -1)
            {
               cancelBreedPets(UnknownVarFromAvatarInfoWidget_Int_2,UnknownVarFromAvatarInfoWidget_Int_3);
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
      }
      
      private function removeBreedingPetsWaitingConfirmationAlert() : void
      {
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
            _breedingConfirmationAlert = null;
            UnknownVarFromAvatarInfoWidget_Int_2 = -1;
            UnknownVarFromAvatarInfoWidget_Int_3 = -1;
         }
      }
      
      public function acceptBreedingPets(param1:int, param2:int) : void
      {
         if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1 != null)
         {
            if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.requestRoomObjectId == param1 && UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         if(_breedingConfirmationAlert != null)
         {
            _breedingConfirmationAlert.dispose();
         }
      }
      
      public function cancelBreedingPets(param1:int, param2:int) : void
      {
         if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1 != null)
         {
            if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.requestRoomObjectId == param1 && UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.targetRoomObjectId == param2)
            {
               removeBreedMonsterPlantsConfirmationView();
            }
         }
         removeBreedingPetsWaitingConfirmationAlert();
         windowManager.alert("${breedpets.cancel.notification.title}","${breedpets.cancel.notification.text}",0,onBreedingAlert);
      }
      
      public function onBreedingAlert(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK" || param2.type == "WE_CANCEL")
         {
            param1.dispose();
         }
      }
      
      public function showBreedMonsterPlantsConfirmationView(param1:int, param2:int, param3:Boolean) : void
      {
         if(!UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1)
         {
            UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1 = new BreedMonsterPlantsConfirmationView(this);
         }
         UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.open(param1,param2,param3);
      }
      
      public function showConfirmPetBreedingView(param1:ConfirmPetBreedingPetData, param2:ConfirmPetBreedingPetData, param3:int, param4:Array, param5:int) : void
      {
         if(!UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1)
         {
            UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1 = new ConfirmPetBreedingView(this);
         }
         var _loc6_:int = findPetRoomObjectIdByWebId(param1.webId);
         var _loc7_:int = findPetRoomObjectIdByWebId(param2.webId);
         UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1.open(_loc6_,_loc7_,param3,param4,param5,param1.level,param2.level);
      }
      
      private function removeBreedMonsterPlantsConfirmationView() : void
      {
         if(UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1)
         {
            UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1.dispose();
            UnknownVarFromAvatarInfoWidget_BreedMonsterPlantsConfirmationView_1 = null;
         }
      }
      
      private function removeConfirmPetBreedingView() : void
      {
         if(UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1)
         {
            UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1.dispose();
            UnknownVarFromAvatarInfoWidget_ConfirmPetBreedingView_1 = null;
         }
      }
      
      public function showBreedPetsResultView(param1:BreedPetsResultData, param2:BreedPetsResultData) : void
      {
         if(!UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1)
         {
            UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 = new BreedPetsResultView(this);
         }
         UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.open(param1,param2);
      }
      
      public function removeBreedPetsResultView(param1:BreedPetsResultView) : void
      {
         if(param1 != null)
         {
            if(param1 == UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1)
            {
               UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1.dispose();
               UnknownVarFromAvatarInfoWidget_BreedPetsResultView_1 = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function findCurrentUserRoomObject() : IRoomObject
      {
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc1_:IUserData = null;
         var _loc5_:int = handler.container.sessionDataManager.userId;
         var _loc6_:int = handler.roomEngine.activeRoomId;
         var _loc7_:int = 100;
         var _loc3_:int = handler.roomEngine.getRoomObjectCount(_loc6_,_loc7_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = handler.roomEngine.getRoomObjectWithIndex(_loc6_,_loc4_,100);
            if(_loc2_ != null)
            {
               _loc1_ = handler.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
               if(_loc1_ != null)
               {
                  if(_loc1_.webID == _loc5_)
                  {
                     return _loc2_;
                  }
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      internal function get isUserDecorating() : Boolean
      {
         return handler.roomSession.isUserDecorating;
      }
      
      internal function set isUserDecorating(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:String = null;
         var _loc2_:int = 0;
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         handler.roomSession.isUserDecorating = param1;
         if(param1)
         {
            _loc5_ = handler.container.sessionDataManager.userId;
            if(!UnknownVarFromAvatarInfoWidget_DecorateModeView_1)
            {
               _loc4_ = handler.container.sessionDataManager.userName;
               _loc2_ = handler.container.roomSession.ownUserRoomId;
               UnknownVarFromAvatarInfoWidget_DecorateModeView_1 = new DecorateModeView(this,_loc5_,_loc4_,_loc2_);
            }
            UnknownVarFromAvatarInfoWidget_DecorateModeView_1.show();
            _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc5_,1)) as RoomWidgetUserLocationUpdateEvent;
            if(_loc3_)
            {
               UnknownVarFromAvatarInfoWidget_DecorateModeView_1.update(_loc3_.rectangle,_loc3_.screenLocation,0);
            }
         }
         else if(UnknownVarFromAvatarInfoWidget_DecorateModeView_1)
         {
            UnknownVarFromAvatarInfoWidget_DecorateModeView_1.hide(false);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function isMonsterPlant() : Boolean
      {
         if(UnknownVarFromAvatarInfoWidget_PetInfoData_1 != null)
         {
            return UnknownVarFromAvatarInfoWidget_PetInfoData_1.petType == 16;
         }
         return false;
      }
      
      public function cancelBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new BreedPetsMessageComposer(1,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function acceptBreedPets(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new BreedPetsMessageComposer(2,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function breedPets(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param1);
         var _loc4_:IUserData = handler.container.roomSession.userDataManager.getUserDataByIndex(param2);
         if(_loc3_ && _loc4_)
         {
            handler.container.connection.send(new BreedPetsMessageComposer(0,_loc3_.webID,_loc4_.webID));
         }
      }
      
      public function openBotSkillConfigurationView(param1:int, param2:int, param3:Point = null) : void
      {
         if(!UnknownVarFromAvatarInfoWidget_Map_1.hasKey(param2))
         {
            switch(param2 - 2)
            {
               case 0:
                  UnknownVarFromAvatarInfoWidget_Map_1.add(2,new BotChatterMarkovConfiguration(this));
                  break;
               case 3:
                  UnknownVarFromAvatarInfoWidget_Map_1.add(5,new BotChangeNameConfiguration(this));
                  break;
               default:
                  return;
            }
         }
         var _loc4_:IBotSkillConfigurationViewBase = UnknownVarFromAvatarInfoWidget_Map_1.getValue(param2);
         _loc4_.open(param1,param3);
      }
      
      public function cancelPetBreeding(param1:int) : void
      {
         handler.container.connection.send(new CancelPetBreedingComposer(param1));
      }
      
      public function confirmPetBreeding(param1:int, param2:String, param3:int, param4:int) : void
      {
         handler.container.connection.send(new ConfirmPetBreedingComposer(param1,param2,param3,param4));
      }
      
      public function showNestBreedingSuccess(param1:int, param2:int) : void
      {
         if(UnknownVarFromAvatarInfoWidget_NestBreedingSuccessView_1 == null)
         {
            UnknownVarFromAvatarInfoWidget_NestBreedingSuccessView_1 = new NestBreedingSuccessView(this);
         }
         var _loc3_:int = findPetRoomObjectIdByWebId(param1);
         UnknownVarFromAvatarInfoWidget_NestBreedingSuccessView_1.open(_loc3_,param2);
      }
      
      public function get friendList() : IHabboFriendList
      {
         return handler.friendList;
      }
   }
}

