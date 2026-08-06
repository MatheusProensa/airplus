package com.sulake.habbo.roomevents.wired_trading.chests
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.SetChestOptionsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.StartAddingToChestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.WithdrawAllFromChestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions.WiredTransactionGetChestLogsMessageComposer;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_trading.UbuntuPresetManager;
   import com.sulake.habbo.roomevents.wired_trading.chests.settings.ChestNotificationSettingsUI;
   import com.sulake.habbo.roomevents.wired_trading.chests.settings.ChestSettingsUI;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.ICoinChestSubController;
   import com.sulake.habbo.roomevents.wired_trading.chests.upgrade_confirmation.WiredChestUpgradeConfirmationView;
   import com.sulake.habbo.roomevents.wired_trading.transactions.overview.TransactionConfig;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WiredChestWrapperView implements IComponentInterfaceQueue
   {
      public static const UnknownConstFromWiredChestWrapperView_String_1:String = "locked";
      
      public static const AUTO_LOCK_KEY:String = "auto_lock";
      
      public static const CAPACITY_KEY:String = "capacity";
      
      public static const CONTENTS_COUNT_KEY:String = "contents_count";
      
      public static const CAPACITY_LEVEL_KEY:String = "capacity_level";
      
      public static const CHEST_NAME_KEY:String = "chest_name";
      
      public static const CHEST_DESC_KEY:String = "chest_desc";
      
      public static const UnknownConstFromWiredChestWrapperView_String_2:String = "everyone_can_open";
      
      public static const UnknownConstFromWiredChestWrapperView_String_3:String = "everyone_can_donate";
      
      public static const STATE_CONTROL_MODE:String = "state_control_mode";
      
      public static const IS_WIRED_ENABLED:String = "is_wired_enabled";
      
      public static const NOTIFY_MODE:String = "notify_mode";
      
      public static const PREVIEW_MODE_KEY:String = "preview_mode";
      
      public static const PREVIEW_AMOUNT_KEY:String = "preview_amount";
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromWiredChestWrapperView_WiredChestController_1:WiredChestController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromWiredChestWrapperView_IBubbleController_1:IBubbleController;
      
      private var UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1:WiredChestUpgradeConfirmationView = null;
      
      private var _viewingChestId:int;
      
      private var _viewingChestFurni:IRoomObject;
      
      private var UnknownVarFromWiredChestWrapperView_Boolean_1:Boolean;
      
      private var UnknownVarFromWiredChestWrapperView_Boolean_2:Boolean;
      
      private var UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1:ICoinChestSubController;
      
      private var _maxCapacityCache:int = -1;
      
      private var _ignoreCheckboxSelectedEvents:Boolean;
      
      private var _ignoreCapacityChangeEvents:Boolean;
      
      private var _ignoreCheckboxSelectEvents:Boolean;
      
      private var _ignoreResizeEvents:Boolean;
      
      private var _lastResizableWidth:int = -1;
      
      private var UnknownVarFromWiredChestWrapperView_Int_1:int = -1;
      
      private var UnknownVarFromWiredChestWrapperView_Int_2:int;
      
      private var UnknownVarFromWiredChestWrapperView_Int_3:int;
      
      private var _chestSettings:ChestSettingsUI;
      
      private var _chestNotificationSettings:ChestNotificationSettingsUI;
      
      private var UnknownVarFromWiredChestWrapperView_PresetManager_1:PresetManager;
      
      public function WiredChestWrapperView(param1:WiredChestController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromWiredChestWrapperView_WiredChestController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromWiredChestWrapperView_WiredChestController_1.assets.getAssetByName("chest_generic_xml").content),1) as IFrameController;
         _window.enableLookupCache();
         UnknownVarFromWiredChestWrapperView_Int_2 = _window.width - chestContents.width;
         UnknownVarFromWiredChestWrapperView_Int_3 = _window.height - chestContents.height - footer.height - header.height;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         lockInfoButton.addEventListener("WME_CLICK",onInfoButtonClick);
         withdrawAllButton.addEventListener("WME_CLICK",onWithdrawAllClick);
         startDepositButton.addEventListener("WME_CLICK",onDepositClick);
         viewLogsButton.addEventListener("WME_CLICK",onViewLogsClick);
         lockChestCheckbox.addEventListener("WE_SELECT",onAttemptLockChest);
         lockChestCheckbox.addEventListener("WE_UNSELECT",onAttemptUnlockChest);
         var _loc4_:Array = [lockChestCheckbox,autoLockChestCheckbox];
         for each(var _loc3_ in _loc4_)
         {
            _loc3_.addEventListener("WE_SELECTED",onOptionsChanged);
            _loc3_.addEventListener("WE_UNSELECTED",onOptionsChanged);
         }
         capacityInput.addEventListener("WME_CLICK_AWAY",onOptionsChanged);
         capacityInput.addEventListener("WKE_KEY_DOWN",onCapacityKeyDown);
         capacityInput.addEventListener("WE_CHANGE",onCapacityChange);
         maxCapacityUpgradeButton.addEventListener("WME_CLICK",onUpgradeCapacityClick);
         settingsButton.addEventListener("WME_CLICK",onClickSettings);
         notificationSettingsButton.addEventListener("WME_CLICK",onClickNotificationSettings);
         UnknownVarFromWiredChestWrapperView_IBubbleController_1 = _window.findChildByName("lock_info_bubble") as IBubbleController;
         _window.desktop.addChild(UnknownVarFromWiredChestWrapperView_IBubbleController_1);
         UnknownVarFromWiredChestWrapperView_IBubbleController_1.visible = false;
         UnknownVarFromWiredChestWrapperView_IBubbleController_1.addEventListener("WE_DEACTIVATED",onLockInfoBubbleDeactivates);
         _window.addEventListener("WE_RESIZED",onResizeWindow);
         show(null,null,0,false,false);
         hide();
      }
      
      public static function relocateBubbleFocus(param1:IBubbleController, param2:IWindowController_1) : void
      {
         var _loc3_:Rectangle = new Rectangle();
         param2.getGlobalRectangle(_loc3_);
         param1.position = new Point(_loc3_.x + _loc3_.width + 3,_loc3_.y + 1 + _loc3_.height / 2 - param1.height / 2);
         param1.activate();
      }
      
      private function onResizeWindow(param1:WindowEvent) : void
      {
         if(_ignoreResizeEvents)
         {
            return;
         }
         chestContents.height = _window.height - UnknownVarFromWiredChestWrapperView_Int_3 - footer.height - header.height;
      }
      
      private function onClickSettings(param1:WindowMouseEvent) : void
      {
         var _loc2_:Map = getStuffDataMap();
         if(_loc2_ == null || _viewingChestId == 0 || UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 == null)
         {
            return;
         }
         chestSettingsUI.onEdit(_viewingChestId,UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.type,_viewingChestFurni.getModel().getNumber("furniture_type_id"),isStarterChest,_loc2_);
      }
      
      private function onClickNotificationSettings(param1:WindowMouseEvent) : void
      {
         var _loc2_:Map = getStuffDataMap();
         if(_loc2_ == null || _viewingChestId == 0 || UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 == null)
         {
            return;
         }
         chestNotificationSettingsUI.onEdit(_viewingChestId,UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.type,_loc2_);
      }
      
      private function get isStarterChest() : Boolean
      {
         var _loc2_:int = _viewingChestFurni.getModel().getNumber("furniture_type_id");
         var _loc1_:IFurnitureData = UnknownVarFromWiredChestWrapperView_WiredChestController_1.sessionDataManager.getFloorItemData(_loc2_);
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc3_:String = UnknownVarFromWiredChestWrapperView_WiredChestController_1.getProperty("wired.chests_starter_infix");
         return _loc3_ != "" && _loc1_.className.indexOf(_loc3_) != -1;
      }
      
      private function onUpgradeCapacityClick(param1:WindowMouseEvent) : void
      {
         if(_viewingChestId == 0 || _viewingChestFurni == null)
         {
            return;
         }
         if(UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1 == null)
         {
            UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1 = new WiredChestUpgradeConfirmationView(UnknownVarFromWiredChestWrapperView_WiredChestController_1);
         }
         UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1.initialize(_viewingChestId,UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.type,_viewingChestFurni.getModel().getNumber("furniture_type_id"),currentCapacityLevel);
         UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1.show();
      }
      
      public function get viewingChestFurni() : IRoomObject
      {
         return _viewingChestFurni;
      }
      
      private function onViewLogsClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.send(new WiredTransactionGetChestLogsMessageComposer(_viewingChestId,TransactionConfig.PAGE_SIZE,1));
      }
      
      private function onDepositClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.send(new StartAddingToChestMessageComposer(_viewingChestId));
      }
      
      private function onWithdrawAllClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents.windowManager.confirm("${wiredchests.withdraw_all.confirm.title}","${wiredchests.withdraw_all.confirm.desc}",0,onWithdrawAllConfirmed);
      }
      
      private function onWithdrawAllConfirmed(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            UnknownVarFromWiredChestWrapperView_WiredChestController_1.send(new WithdrawAllFromChestMessageComposer(_viewingChestId));
         }
      }
      
      private function onLockInfoBubbleDeactivates(param1:WindowEvent) : void
      {
         UnknownVarFromWiredChestWrapperView_IBubbleController_1.visible = false;
      }
      
      private function onInfoButtonClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredChestWrapperView_IBubbleController_1.visible = true;
         relocateBubbleAndFocus();
      }
      
      private function relocateBubbleAndFocus() : void
      {
         relocateBubbleFocus(UnknownVarFromWiredChestWrapperView_IBubbleController_1,lockInfoButton);
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function isShowing() : Boolean
      {
         return _window != null && _window.parent != null;
      }
      
      public function get viewingChestId() : int
      {
         return _viewingChestId;
      }
      
      public function show(param1:ICoinChestSubController, param2:IRoomObject, param3:int, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:IDesktopController = null;
         _viewingChestFurni = param2;
         _viewingChestId = param3;
         UnknownVarFromWiredChestWrapperView_Boolean_1 = param4;
         UnknownVarFromWiredChestWrapperView_Boolean_2 = param5;
         if(UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 != null && UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 != param1)
         {
            UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.clear();
            if(UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.allowResizing)
            {
               _lastResizableWidth = chestContents.width;
               UnknownVarFromWiredChestWrapperView_Int_1 = chestContents.height;
            }
            if(_chestSettings != null && _chestSettings.isShowing())
            {
               _chestSettings.hide();
            }
            if(_chestNotificationSettings != null && _chestNotificationSettings.isShowing())
            {
               _chestNotificationSettings.hide();
            }
         }
         UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 = param1;
         if(_window.parent == null)
         {
            _loc6_ = _windowManager.getDesktop(1);
            if(_loc6_ != null)
            {
               _loc6_.addChild(_window);
            }
         }
         if(param1 != null)
         {
            resetChestCaches();
            setSubController(param1);
            updateLayout();
            updateUIOptions();
            updateUI();
            UnknownVarFromWiredChestWrapperView_IBubbleController_1.visible = false;
            _window.activate();
         }
         else
         {
            setSubController(null);
         }
      }
      
      private function resetChestCaches() : void
      {
         _maxCapacityCache = -1;
      }
      
      public function viewingChestUpdated() : void
      {
         resetChestCaches();
         if(isShowing() && !canRead && !isVisibleForEveryone)
         {
            hide();
         }
         else
         {
            updateLayout();
            updateUIOptions();
            updateUI();
         }
      }
      
      private function get currentCapacityLevel() : int
      {
         var _loc1_:Map = getStuffDataMap();
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.getValue("capacity_level");
      }
      
      private function get maxCapacity() : int
      {
         if(_maxCapacityCache != -1)
         {
            return _maxCapacityCache;
         }
         var _loc2_:String = UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 != null && UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.type == UnknownHabboRoomeventsWired_TradingChests1.TYPE_COIN ? "coins" : "furni";
         if(isStarterChest)
         {
            _maxCapacityCache = UnknownVarFromWiredChestWrapperView_WiredChestController_1.getInteger("wired." + _loc2_ + "_chest.starter_capacity",0);
            return _maxCapacityCache;
         }
         var _loc1_:int = UnknownVarFromWiredChestWrapperView_WiredChestController_1.getInteger("wired." + _loc2_ + "_chest.initial_capacity",0);
         var _loc3_:int = UnknownVarFromWiredChestWrapperView_WiredChestController_1.getInteger("wired." + _loc2_ + "_chest.upgrade_capacity",0);
         _maxCapacityCache = _loc1_ + _loc3_ * currentCapacityLevel;
         return _maxCapacityCache;
      }
      
      private function getStuffDataMap() : Map
      {
         if(_viewingChestFurni == null || _viewingChestFurni.getModel() == null)
         {
            return null;
         }
         return _viewingChestFurni.getModel().getStringToStringMap("furniture_data");
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
            UnknownVarFromWiredChestWrapperView_IBubbleController_1.visible = false;
         }
         setSubController(null);
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.setClosedStatus();
         _viewingChestId = 0;
         _viewingChestFurni = null;
         if(UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 != null)
         {
            UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.clear();
            UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 = null;
         }
         resetChestCaches();
         if(_chestSettings != null && _chestSettings.isShowing())
         {
            _chestSettings.hide();
         }
         if(_chestNotificationSettings != null && _chestNotificationSettings.isShowing())
         {
            _chestNotificationSettings.hide();
         }
      }
      
      public function get isVisibleForEveryone() : Boolean
      {
         var _loc1_:Map = getStuffDataMap();
         return _loc1_ != null && _loc1_.getValue("everyone_can_open") == "1";
      }
      
      public function updateLayout() : void
      {
         if(UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 == null || _viewingChestFurni == null)
         {
            return;
         }
         var _loc1_:Map = getStuffDataMap();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:* = _loc1_.getValue("is_wired_enabled") == "1";
         _ignoreResizeEvents = true;
         if(!canRead)
         {
            settingsButton.visible = false;
            notificationSettingsButton.visible = false;
            lockingOptions.visible = false;
            capacityOptions.visible = false;
            upgradeCapacityContainer.visible = false;
            itemCountText.visible = false;
            itemCountTextBottom.visible = true;
            lockInfoButton.visible = false;
            viewLogsButton.visible = false;
            withdrawAllButton.visible = false;
            startDepositButton.caption = "${wiredchests.donate}";
         }
         else if(!_loc2_)
         {
            settingsButton.visible = true;
            notificationSettingsButton.visible = true;
            lockingOptions.visible = false;
            capacityOptions.visible = true;
            capacityOverrideContainer.visible = false;
            upgradeCapacityContainer.visible = true;
            itemCountText.visible = true;
            itemCountTextBottom.visible = false;
            lockInfoButton.visible = false;
            viewLogsButton.visible = true;
            withdrawAllButton.visible = true;
            startDepositButton.caption = "${wiredchests.start_deposit}";
         }
         else
         {
            settingsButton.visible = true;
            notificationSettingsButton.visible = true;
            lockingOptions.visible = true;
            capacityOptions.visible = true;
            capacityOverrideContainer.visible = true;
            upgradeCapacityContainer.visible = true;
            itemCountText.visible = false;
            itemCountTextBottom.visible = false;
            lockInfoButton.visible = true;
            viewLogsButton.visible = true;
            withdrawAllButton.visible = true;
            startDepositButton.caption = "${wiredchests.start_deposit}";
         }
         _window.height = mainList.height + UnknownVarFromWiredChestWrapperView_Int_3;
         _ignoreResizeEvents = false;
      }
      
      public function updateUIOptions() : void
      {
         _ignoreCheckboxSelectedEvents = true;
         _ignoreCapacityChangeEvents = true;
         var _loc1_:Map = getStuffDataMap();
         if(_loc1_ == null)
         {
            _ignoreCheckboxSelectedEvents = false;
            _ignoreCapacityChangeEvents = false;
            return;
         }
         Util.select(lockChestCheckbox,_loc1_.getValue("locked") != "0");
         Util.select(autoLockChestCheckbox,_loc1_.getValue("auto_lock") != "0");
         capacityInput.text = _loc1_.getValue("capacity");
         _ignoreCheckboxSelectedEvents = false;
         _ignoreCapacityChangeEvents = false;
         maxCapacityText.text = UnknownVarFromWiredChestWrapperView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.max_capacity","","max_capacity",String(maxCapacity));
      }
      
      public function updateUI() : void
      {
         if(UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 == null || _viewingChestFurni == null)
         {
            return;
         }
         var _loc2_:Map = getStuffDataMap();
         if(_loc2_ == null)
         {
            return;
         }
         _ignoreResizeEvents = true;
         var _loc3_:* = _loc2_.getValue("everyone_can_donate") == "1";
         var _loc1_:String = _loc2_.getValue("chest_name");
         var _loc4_:String = _loc2_.getValue("chest_desc");
         if(_loc4_ == null || _loc4_ == "")
         {
            _loc4_ = "${wiredchests.description_placeholder}";
         }
         var _loc5_:int = _loc2_.getValue("capacity");
         itemCountText.caption = UnknownVarFromWiredChestWrapperView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.space_used2","","count",UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.itemCount,"total",_loc5_);
         itemCountTextBottom.caption = UnknownVarFromWiredChestWrapperView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.space_used","","count",UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.itemCount,"total",_loc5_);
         if(_loc1_ != null && _loc1_.length > 0)
         {
            _window.caption = _loc1_;
         }
         else
         {
            _window.caption = UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.title;
         }
         description.text = _loc4_;
         Util.disableSection(lockChestCheckbox,!UnknownVarFromWiredChestWrapperView_Boolean_1 && (!UnknownVarFromWiredChestWrapperView_Boolean_2 || Boolean(lockChestCheckbox.isSelected)));
         Util.disableSection(autoLockChestCheckbox,!UnknownVarFromWiredChestWrapperView_Boolean_1);
         Util.disableSection(capacityInputBorder,!UnknownVarFromWiredChestWrapperView_Boolean_1);
         Util.disableSection(withdrawAllButton,!canWithdraw);
         Util.disableSection(startDepositButton,!_loc3_ && (!canEdit || lockChestCheckbox.isSelected && !UnknownVarFromWiredChestWrapperView_Boolean_1));
         Util.disableSection(viewLogsButton,!canRead);
         Util.disableSection(settingsButton,!UnknownVarFromWiredChestWrapperView_Boolean_1);
         Util.disableSection(notificationSettingsButton,!UnknownVarFromWiredChestWrapperView_Boolean_1);
         if(isStarterChest)
         {
            Util.disableSection(maxCapacityUpgradeButton,true);
            upgradeCapacityRegion.toolTipCaption = "${wiredchests.upgrade.result.error.10}";
         }
         else if(!UnknownVarFromWiredChestWrapperView_Boolean_1)
         {
            Util.disableSection(maxCapacityUpgradeButton,true);
            upgradeCapacityRegion.toolTipCaption = "${wiredchests.upgrade.error.reason.not_owner}";
         }
         else
         {
            Util.disableSection(maxCapacityUpgradeButton,false);
            upgradeCapacityRegion.toolTipCaption = "";
         }
         UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.updateUI();
         _window.height = mainList.height + UnknownVarFromWiredChestWrapperView_Int_3;
         _ignoreResizeEvents = false;
      }
      
      private function onOptionsChanged(param1:WindowEvent) : void
      {
         if(_ignoreCheckboxSelectedEvents)
         {
            return;
         }
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.send(new SetChestOptionsMessageComposer(_viewingChestId,lockChestCheckbox.isSelected,autoLockChestCheckbox.isSelected,int(capacityInput.text)));
      }
      
      private function onCapacityChange(param1:WindowEvent) : void
      {
         if(_ignoreCapacityChangeEvents)
         {
            return;
         }
         if(int(capacityInput.text) > maxCapacity)
         {
            _ignoreCapacityChangeEvents = true;
            capacityInput.text = String(maxCapacity);
            _ignoreCapacityChangeEvents = false;
         }
      }
      
      private function onCapacityKeyDown(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            onOptionsChanged(null);
         }
      }
      
      private function onAttemptLockChest(param1:WindowEvent) : void
      {
         if(_ignoreCheckboxSelectedEvents || _ignoreCheckboxSelectEvents)
         {
            return;
         }
         if(!UnknownVarFromWiredChestWrapperView_Boolean_1)
         {
            param1.preventWindowOperation();
            UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents.windowManager.confirm("${wiredchests.lock.confirm.title}","${wiredchests.lock.confirm.desc}",0,onConfirmLockChest);
         }
      }
      
      private function onAttemptUnlockChest(param1:WindowEvent) : void
      {
         if(_ignoreCheckboxSelectedEvents || _ignoreCheckboxSelectEvents)
         {
            return;
         }
         param1.preventWindowOperation();
         UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents.windowManager.confirm("${wiredchests.unlock.confirm.title}","${wiredchests.unlock.confirm.desc}",0,onConfirmUnlockChest);
      }
      
      private function onConfirmLockChest(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _ignoreCheckboxSelectEvents = true;
            lockChestCheckbox.select();
            _ignoreCheckboxSelectEvents = false;
         }
      }
      
      private function onConfirmUnlockChest(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _ignoreCheckboxSelectEvents = true;
            lockChestCheckbox.unselect();
            _ignoreCheckboxSelectEvents = false;
         }
      }
      
      public function get canWithdraw() : Boolean
      {
         return UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1 != null && !UnknownVarFromWiredChestWrapperView_ICoinChestSubController_1.isEmpty && canEdit && (!lockChestCheckbox.isSelected || UnknownVarFromWiredChestWrapperView_Boolean_1);
      }
      
      public function get canEdit() : Boolean
      {
         return UnknownVarFromWiredChestWrapperView_Boolean_1 || UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents.wiredMenu.hasWritePermission;
      }
      
      public function get canRead() : Boolean
      {
         return UnknownVarFromWiredChestWrapperView_Boolean_1 || UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents.wiredMenu.hasReadPermission;
      }
      
      private function setSubController(param1:ICoinChestSubController) : *
      {
         var _loc3_:IWindowController_1 = null;
         _ignoreResizeEvents = true;
         var _loc2_:IWindowController_1 = null;
         if(param1 != null)
         {
            _loc2_ = param1.view;
         }
         if(chestContents.numChildren > 0)
         {
            _loc3_ = chestContents.getChildAt(0) as IWindowController_1;
            if(_loc2_ == _loc3_)
            {
               _ignoreResizeEvents = false;
               return;
            }
            _loc3_.setParamFlag(128,false);
            _loc3_.setParamFlag(2048,false);
            chestContents.removeChild(_loc3_);
         }
         if(_loc2_ != null)
         {
            _loc2_.setParamFlag(128,false);
            _loc2_.setParamFlag(2048,false);
            if(!param1.allowResizing || UnknownVarFromWiredChestWrapperView_Int_1 == -1)
            {
               _window.width = _loc2_.width + UnknownVarFromWiredChestWrapperView_Int_2;
               chestContents.height = _loc2_.height;
               _window.height = mainList.height + UnknownVarFromWiredChestWrapperView_Int_3;
            }
            else
            {
               _window.width = _lastResizableWidth + UnknownVarFromWiredChestWrapperView_Int_2;
               chestContents.height = UnknownVarFromWiredChestWrapperView_Int_1;
            }
            _window.setParamFlag(65536,param1.allowResizing);
            _window.height = mainList.height + UnknownVarFromWiredChestWrapperView_Int_3;
            chestContents.addChild(_loc2_);
            if(param1.allowResizing)
            {
               _loc2_.width = chestContents.width;
               _loc2_.height = chestContents.height;
               _loc2_.setParamFlag(128,true);
               _loc2_.setParamFlag(2048,true);
            }
         }
         _ignoreResizeEvents = false;
      }
      
      public function get chestSettingsUI() : ChestSettingsUI
      {
         if(UnknownVarFromWiredChestWrapperView_PresetManager_1 == null)
         {
            UnknownVarFromWiredChestWrapperView_PresetManager_1 = new UbuntuPresetManager(UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents);
         }
         if(_chestSettings == null)
         {
            _chestSettings = new ChestSettingsUI(UnknownVarFromWiredChestWrapperView_WiredChestController_1,UnknownVarFromWiredChestWrapperView_PresetManager_1);
         }
         return _chestSettings;
      }
      
      public function get chestNotificationSettingsUI() : ChestNotificationSettingsUI
      {
         if(UnknownVarFromWiredChestWrapperView_PresetManager_1 == null)
         {
            UnknownVarFromWiredChestWrapperView_PresetManager_1 = new UbuntuPresetManager(UnknownVarFromWiredChestWrapperView_WiredChestController_1.roomEvents);
         }
         if(_chestNotificationSettings == null)
         {
            _chestNotificationSettings = new ChestNotificationSettingsUI(UnknownVarFromWiredChestWrapperView_WiredChestController_1,UnknownVarFromWiredChestWrapperView_PresetManager_1);
         }
         return _chestNotificationSettings;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_chestSettings != null)
         {
            _chestSettings.dispose();
            _chestSettings = null;
         }
         if(_chestNotificationSettings != null)
         {
            _chestNotificationSettings.dispose();
            _chestNotificationSettings = null;
         }
         if(UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1 != null)
         {
            UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1.dispose();
            UnknownVarFromWiredChestWrapperView_WiredChestUpgradeConfirmationView_1 = null;
         }
         hide();
         setSubController(null);
         _window.dispose();
         _window = null;
         UnknownVarFromWiredChestWrapperView_IBubbleController_1.dispose();
         UnknownVarFromWiredChestWrapperView_IBubbleController_1 = null;
         UnknownVarFromWiredChestWrapperView_WiredChestController_1 = null;
         _windowManager = null;
         UnknownVarFromWiredChestWrapperView_PresetManager_1 = null;
         _viewingChestId = 0;
         _viewingChestFurni = null;
         resetChestCaches();
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get mainList() : IItemListWindow
      {
         return _window.findChildByName("main_list") as IItemListWindow;
      }
      
      private function get chestContents() : IWindowController_1
      {
         return _window.findChildByName("chest_contents") as IWindowController_1;
      }
      
      private function get lockInfoButton() : IRegionWindow
      {
         return _window.findChildByName("lock_info_button") as IRegionWindow;
      }
      
      private function get description() : ITextWindow
      {
         return _window.findChildByName("desc") as ITextWindow;
      }
      
      private function get lockInfoBubbleTexts() : IItemListWindow
      {
         return UnknownVarFromWiredChestWrapperView_IBubbleController_1.findChildByName("lock_info_bubble_texts") as IItemListWindow;
      }
      
      private function get settingsButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("settings_button") as UnknownICoreWindowComponents5;
      }
      
      private function get notificationSettingsButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("notification_settings_button") as UnknownICoreWindowComponents5;
      }
      
      private function get lockingOptions() : IItemListWindow
      {
         return _window.findChildByName("locking_options") as IItemListWindow;
      }
      
      private function get capacityOptions() : IWindowController_1
      {
         return _window.findChildByName("capacity_options") as IWindowController_1;
      }
      
      private function get capacityOverrideContainer() : IItemListWindow
      {
         return _window.findChildByName("capacity_override_container") as IItemListWindow;
      }
      
      private function get upgradeCapacityContainer() : IItemListWindow
      {
         return _window.findChildByName("upgrade_capacity_container") as IItemListWindow;
      }
      
      private function get itemCountText() : ITextWindow
      {
         return _window.findChildByName("item_count_text") as ITextWindow;
      }
      
      private function get itemCountTextBottom() : ITextWindow
      {
         return _window.findChildByName("item_count_text_bottom") as ITextWindow;
      }
      
      private function get header() : IWindowController_1
      {
         return _window.findChildByName("header") as IWindowController_1;
      }
      
      private function get footer() : IWindowController_1
      {
         return _window.findChildByName("footer") as IWindowController_1;
      }
      
      private function get lockChestCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("lock_chest_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get autoLockChestCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("auto_lock_chest_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get capacityInput() : ITextFieldWindow
      {
         return _window.findChildByName("capacity_input") as ITextFieldWindow;
      }
      
      private function get capacityInputBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("capacity_input_border") as UnknownICoreWindowComponents6;
      }
      
      private function get maxCapacityText() : ITextWindow
      {
         return _window.findChildByName("max_capacity_txt") as ITextWindow;
      }
      
      private function get maxCapacityUpgradeButton() : IIconButtonWindow
      {
         return _window.findChildByName("upgrade_capacity_btn") as IIconButtonWindow;
      }
      
      private function get upgradeCapacityRegion() : IRegionWindow
      {
         return _window.findChildByName("upgrade_capacity_region") as IRegionWindow;
      }
      
      private function get withdrawAllButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("withdraw_all_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get startDepositButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("start_deposit_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get viewLogsButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("view_logs_btn") as UnknownICoreWindowComponents4;
      }
   }
}

