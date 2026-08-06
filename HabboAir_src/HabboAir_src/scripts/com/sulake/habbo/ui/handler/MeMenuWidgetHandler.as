package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetMiniMailUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectEffectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
   import flash.events.Event;
   
   public class MeMenuWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _inventory:IHabboInventory;
      
      private var _toolbar:IHabboToolbar;
      
      private var _catalog:IHabboCatalog;
      
      private var UnknownVarFromMeMenuWidgetHandler_MeMenuWidget_1:MeMenuWidget;
      
      public function MeMenuWidgetHandler()
      {
         super();
         Logger.log("[MeMenuWidgetHandler]");
      }
      
      public function set widget(param1:MeMenuWidget) : void
      {
         UnknownVarFromMeMenuWidgetHandler_MeMenuWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_container && _container.avatarEditor)
         {
            _container.avatarEditor.close(0);
         }
         _disposed = true;
         this.container = null;
         _inventory = null;
         _toolbar = null;
         _catalog = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_ME_MENU";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(_inventory && !_inventory.disposed && _inventory.events)
            {
               _inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED",onAvatarEffectsChanged);
               _inventory.events.removeEventListener("HIHCE_HABBO_CLUB_CHANGED",onHabboClubSubscriptionChanged);
            }
            if(_toolbar && !_toolbar.disposed && _toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
            }
            if(_container.habboHelp && !_container.habboHelp.disposed && _container.habboHelp.events)
            {
               _container.habboHelp.events.removeEventListener("HHTPNUFWE_LIGHT_CLOTHES_ICON",onHelpTutorialEvent);
               _container.habboHelp.events.removeEventListener("HHTPNUFWE_AVATAR_TUTORIAL_START",onHelpTutorialEvent);
            }
            if(_container.catalog && !_container.catalog.disposed && _container.catalog.events)
            {
               _container.catalog.events.removeEventListener("catalog_purse_credit_balance",onCreditBalance);
            }
            if(_container.messenger && !_container.messenger.disposed && _container.messenger.events)
            {
               _container.messenger.events.removeEventListener("MMME_new",onMiniMailNewMessage);
               _container.messenger.events.removeEventListener("MMME_unread",onMiniMailUnreadCount);
            }
         }
         _container = param1;
         if(_container == null)
         {
            return;
         }
         _inventory = _container.inventory;
         if(_inventory != null)
         {
            _inventory.events.addEventListener("HIEE_EFFECTS_CHANGED",onAvatarEffectsChanged);
            _inventory.events.addEventListener("HIHCE_HABBO_CLUB_CHANGED",onHabboClubSubscriptionChanged);
         }
         _toolbar = _container.toolbar;
         if(_toolbar && _toolbar.events)
         {
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
         }
         if(_container.habboHelp != null)
         {
            _container.habboHelp.events.addEventListener("HHTPNUFWE_LIGHT_CLOTHES_ICON",onHelpTutorialEvent);
            _container.habboHelp.events.addEventListener("HHTPNUFWE_AVATAR_TUTORIAL_START",onHelpTutorialEvent);
         }
         _catalog = _container.catalog;
         if(_container.catalog != null)
         {
            _container.catalog.events.addEventListener("catalog_purse_credit_balance",onCreditBalance);
         }
         if(_container.messenger && !_container.messenger.disposed && _container.messenger.events)
         {
            _container.messenger.events.addEventListener("MMME_new",onMiniMailNewMessage);
            _container.messenger.events.addEventListener("MMME_unread",onMiniMailUnreadCount);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(disposed || !_container || !_container.events)
         {
            return;
         }
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            var _loc2_:* = param1.iconId;
            if("HTIE_ICON_MEMENU" !== _loc2_)
            {
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWCM_MESSAGE_AVATAR_EXPRESSION");
         _loc1_.push("RWCM_MESSAGE_DANCE");
         _loc1_.push("RWCPM_MESSAGE_CHANGE_POSTURE");
         _loc1_.push("RWCM_MESSAGE_GET_EFFECTS");
         _loc1_.push("RWCM_MESSAGE_SELECT_EFFECT");
         _loc1_.push("RWCM_MESSAGE_UNSELECT_EFFECT");
         _loc1_.push("RWCM_MESSAGE_UNSELECT_ALL_EFFECTS");
         _loc1_.push("RWGOI_MESSAGE_OPEN_INVENTORY");
         _loc1_.push("RWGOI_MESSAGE_OPEN_CATALOG");
         _loc1_.push("RWGOI_MESSAGE_STOP_EFFECT");
         _loc1_.push("RWGOI_MESSAGE_NAVIGATE_TO_ROOM");
         _loc1_.push("RWGOI_MESSAGE_NAVIGATE_HOME");
         _loc1_.push("RWCM_OPEN_AVATAR_EDITOR");
         _loc1_.push("RWCM_GET_WARDROBE");
         _loc1_.push("select_outfit");
         _loc1_.push("RWSORM_SHOW_OWN_ROOMS");
         _loc1_.push("RWRWM_ME_MENU");
         _loc1_.push("RWMMM_MESSAGE_ME_MENU_OPENED");
         _loc1_.push("RWGSM_GET_SETTINGS");
         _loc1_.push("RWSSM_STORE_SETTINGS");
         _loc1_.push("RWSSM_STORE_SOUND");
         _loc1_.push("RWSSM_PREVIEW_SOUND");
         _loc1_.push("RWAEM_AVATAR_EDITOR_VIEW_DISPOSED");
         _loc1_.push("RWRWM_EFFECTS");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:HabboToolbarEvent = null;
         var _loc13_:RoomWidgetDanceMessage = null;
         var _loc11_:RoomWidgetChangePostureMessage = null;
         var _loc10_:Array = null;
         var _loc2_:RoomWidgetSelectEffectMessage = null;
         var _loc9_:RoomWidgetSelectEffectMessage = null;
         var _loc14_:RoomWidgetOpenCatalogMessage = null;
         var _loc5_:RoomWidgetOpenInventoryMessage = null;
         var _loc15_:RoomWidgetMeMenuMessage = null;
         var _loc12_:Boolean = false;
         var _loc6_:int = 0;
         var _loc3_:IUserData = null;
         var _loc8_:int = 0;
         var _loc7_:RoomWidgetStoreSettingsMessage = null;
         if(!param1)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWRWM_ME_MENU":
               if(_container != null && _container.toolbar != null && _container.toolbar.events != null)
               {
                  _loc4_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
                  _loc4_.iconId = "HTIE_ICON_MEMENU";
                  if(!disposed && _container && _container.toolbar && _container.toolbar.events)
                  {
                     _container.toolbar.events.dispatchEvent(_loc4_);
                  }
               }
               break;
            case "RWCM_MESSAGE_AVATAR_EXPRESSION":
               if(_container != null && _container.roomSession != null)
               {
                  _container.roomSession.sendAvatarExpressionMessage(RoomWidgetAvatarExpressionMessage(param1).animation.ordinal);
               }
               break;
            case "RWCM_MESSAGE_DANCE":
               if(_container != null && _container.roomSession != null)
               {
                  _loc13_ = param1 as RoomWidgetDanceMessage;
                  if(_loc13_ != null)
                  {
                     _container.roomSession.sendDanceMessage(_loc13_.style);
                  }
               }
               break;
            case "RWCPM_MESSAGE_CHANGE_POSTURE":
               if(_container != null && _container.roomSession != null)
               {
                  _loc11_ = param1 as RoomWidgetChangePostureMessage;
                  if(_loc11_ != null)
                  {
                     _container.roomSession.sendChangePostureMessage(_loc11_.posture);
                  }
               }
               break;
            case "RWCM_MESSAGE_GET_EFFECTS":
               if(_inventory != null)
               {
                  _loc10_ = _inventory.getAvatarEffects();
                  _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc10_));
               }
               break;
            case "RWCM_MESSAGE_SELECT_EFFECT":
               if(_inventory != null)
               {
                  _loc2_ = param1 as RoomWidgetSelectEffectMessage;
                  _inventory.setEffectSelected(_loc2_.effectType);
               }
               break;
            case "RWCM_MESSAGE_UNSELECT_EFFECT":
               if(_inventory != null)
               {
                  _loc9_ = param1 as RoomWidgetSelectEffectMessage;
                  _inventory.setEffectDeselected(_loc9_.effectType);
               }
               break;
            case "RWGOI_MESSAGE_OPEN_CATALOG":
               _loc14_ = param1 as RoomWidgetOpenCatalogMessage;
               if(_catalog != null && _loc14_.pageKey == "RWOCM_CLUB_MAIN")
               {
                  _catalog.openClubCenter();
               }
               break;
            case "RWGOI_MESSAGE_OPEN_INVENTORY":
               _loc5_ = param1 as RoomWidgetOpenInventoryMessage;
               if(_inventory != null)
               {
                  Logger.log("MeMenuWidgetHandler open inventory: " + _loc5_.inventoryType);
                  switch(_loc5_.inventoryType)
                  {
                     case "inventory_effects":
                        _catalog.openCatalogPage("avatar_effects");
                        break;
                     case "inventory_badges":
                        _inventory.toggleInventoryPage("badges");
                        break;
                     case "inventory_furniture":
                        _inventory.toggleInventoryPage("furni");
                        break;
                     case "inventory_clothes":
                        break;
                     default:
                        Logger.log("MeMenuWidgetHandler: unknown inventory type: " + _loc5_.inventoryType);
                  }
               }
               break;
            case "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS":
            case "RWGOI_MESSAGE_STOP_EFFECT":
               Logger.log("STOP ALL EFFECTS");
               if(_inventory != null)
               {
                  _inventory.deselectAllEffects(true);
               }
               break;
            case "RWGOI_MESSAGE_NAVIGATE_HOME":
               Logger.log("MeMenuWidgetHandler: GO HOME");
               if(_container != null)
               {
                  _container.navigator.goToHomeRoom();
               }
               break;
            case "RWSORM_SHOW_OWN_ROOMS":
               if(_container != null)
               {
                  _container.navigator.showOwnRooms();
               }
               break;
            case "RWMMM_MESSAGE_ME_MENU_OPENED":
               _loc15_ = param1 as RoomWidgetMeMenuMessage;
               if(!_loc15_ || !_container || !_container.events)
               {
                  return null;
               }
               if(_inventory != null)
               {
                  _loc12_ = false;
                  if(_container != null && _container.sessionDataManager != null)
                  {
                     _loc12_ = _container.sessionDataManager.hasClub;
                  }
                  _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(_inventory.clubDays,_inventory.clubPeriods,_inventory.clubPastPeriods,_loc12_,_inventory.clubLevel));
               }
               if(_catalog != null && _catalog.getPurse() != null)
               {
                  _container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent("RWPUE_CREDIT_BALANCE",_catalog.getPurse().credits));
               }
               if(_container.roomSession && _container.roomSession.userDataManager && _container.roomEngine)
               {
                  _loc6_ = int(_container.sessionDataManager != null ? _container.sessionDataManager.userId : -1);
                  _loc3_ = _container.roomSession.userDataManager.getUserData(_loc6_);
                  if(!_loc3_)
                  {
                     return null;
                  }
                  _loc8_ = 0;
                  _container.roomEngine.selectAvatar(_loc8_,_loc3_.roomObjectId);
               }
               break;
            case "RWCM_OPEN_AVATAR_EDITOR":
               Logger.log("MeMenuWidgetHandler: Open avatar editor...");
               if(_container)
               {
                  _container.avatarEditor.openEditor(0,null,null,true);
                  _container.avatarEditor.loadOwnAvatarInEditor(0);
                  if(_container.habboHelp && _container.habboHelp.events)
                  {
                     _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTE_DONE_AVATAR_EDITOR_OPENING"));
                  }
               }
               break;
            case "RWGSM_GET_SETTINGS":
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS",_container.soundManager.traxVolume,_container.soundManager.furniVolume,_container.soundManager.genericVolume));
               break;
            case "RWSSM_STORE_SOUND":
               _container.soundManager.traxVolume = (param1 as RoomWidgetStoreSettingsMessage).traxVolume;
               _container.soundManager.furniVolume = (param1 as RoomWidgetStoreSettingsMessage).furniVolume;
               _container.soundManager.genericVolume = (param1 as RoomWidgetStoreSettingsMessage).genericVolume;
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS",_container.soundManager.traxVolume,_container.soundManager.furniVolume,_container.soundManager.genericVolume));
               break;
            case "RWSSM_PREVIEW_SOUND":
               _loc7_ = param1 as RoomWidgetStoreSettingsMessage;
               _container.soundManager.previewVolume(_loc7_.genericVolume,_loc7_.furniVolume,_loc7_.traxVolume);
               _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS",_container.soundManager.traxVolume,_container.soundManager.furniVolume,_container.soundManager.genericVolume));
               break;
            case "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED":
               if(_container.habboHelp && _container.habboHelp.events)
               {
                  _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTE_DONE_AVATAR_EDITOR_CLOSING"));
               }
               break;
            default:
               Logger.log("Unhandled message in MeMenuWidgetHandler: " + param1.type);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      private function onAvatarEffectsChanged(param1:Event = null) : void
      {
         var _loc2_:Array = null;
         if(_container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
         if(_inventory != null)
         {
            _loc2_ = _inventory.getAvatarEffects();
            _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
         }
      }
      
      private function onHabboClubSubscriptionChanged(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         if(_inventory != null)
         {
            _loc2_ = false;
            if(_container != null && _container.sessionDataManager != null)
            {
               _loc2_ = _container.sessionDataManager.hasClub;
            }
            _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(_inventory.clubDays,_inventory.clubPeriods,_inventory.clubPastPeriods,_loc2_,_inventory.clubLevel));
         }
      }
      
      private function onCreditBalance(param1:PurseEvent) : void
      {
         if(param1 == null || _container == null || _container.events == null)
         {
            return;
         }
         _container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent("RWPUE_CREDIT_BALANCE",param1.balance));
      }
      
      private function onHelpTutorialEvent(param1:HabboHelpTutorialEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "HHTPNUFWE_AVATAR_TUTORIAL_START":
               _container.events.dispatchEvent(new RoomWidgetTutorialEvent("HHTPNUFWE_AE_STARTED"));
               break;
            case "HHTPNUFWE_LIGHT_CLOTHES_ICON":
               _container.events.dispatchEvent(new RoomWidgetTutorialEvent("HHTPNUFWE_AE_HIGHLIGHT"));
         }
      }
      
      private function onMiniMailNewMessage(param1:MiniMailMessageEvent) : void
      {
         _container.events.dispatchEvent(new RoomWidgetMiniMailUpdateEvent("RWMMUE_new_mini_mail"));
      }
      
      private function onMiniMailUnreadCount(param1:MiniMailMessageEvent) : void
      {
         _container.events.dispatchEvent(new RoomWidgetMiniMailUpdateEvent("RWMMUE_unread_mini_mail"));
      }
   }
}

