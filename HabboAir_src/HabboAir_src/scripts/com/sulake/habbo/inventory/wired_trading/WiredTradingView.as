package com.sulake.habbo.inventory.wired_trading
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.ItemPopupCtrl;
   import com.sulake.habbo.inventory.Util;
   import com.sulake.habbo.inventory.trading.TradingView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WiredTradingView implements IInventoryView
   {
      private var UnknownVarFromWiredTradingView_WiredTradingModel_1:WiredTradingModel;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var UnknownVarFromWiredTradingView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromWiredTradingView_ItemPopupCtrl_1:ItemPopupCtrl;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var UnknownVarFromWiredTradingView_Timer_1:Timer;
      
      private var UnknownVarFromWiredTradingView_Timer_2:Timer;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      public function WiredTradingView(param1:WiredTradingModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:IHabboSoundManagerFlash10)
      {
         super();
         UnknownVarFromWiredTradingView_WiredTradingModel_1 = param1;
         _windowManager = param2;
         _localization = param5;
         UnknownVarFromWiredTradingView_IAssetLibraryCollection_1 = param3;
         _roomEngine = param4;
         _soundManager = param6;
         var _loc7_:IWindowController_1 = _windowManager.buildFromXML(XmlAsset(UnknownVarFromWiredTradingView_IAssetLibraryCollection_1.getAssetByName("item_popup_xml")).content as XML) as IWindowController_1;
         _loc7_.visible = false;
         UnknownVarFromWiredTradingView_ItemPopupCtrl_1 = new ItemPopupCtrl(_loc7_,UnknownVarFromWiredTradingView_IAssetLibraryCollection_1,_windowManager,UnknownVarFromWiredTradingView_WiredTradingModel_1.inventory);
         createWindow();
      }
      
      private function createWindow() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc4_:* = 0;
         var _loc3_:IItemGridWindow = null;
         var _loc1_:XML = XmlAsset(UnknownVarFromWiredTradingView_IAssetLibraryCollection_1.getAssetByName("inventory_trading_wired_xml")).content as XML;
         var _loc5_:IWindowController_1 = _windowManager.buildFromXML(_loc1_) as IWindowController_1;
         _loc3_ = _loc5_.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numGridItems)
         {
            _loc2_ = _loc3_.getGridItemAt(_loc4_);
            _loc2_.id = _loc4_;
            _loc2_.procedure = ownThumbEventProc;
            _loc2_.addEventListener("WME_OVER",ownThumbEventProc);
            _loc2_.addEventListener("WME_OUT",ownThumbEventProc);
            _loc4_++;
         }
         _loc3_ = _loc5_.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numGridItems)
         {
            _loc2_ = _loc3_.getGridItemAt(_loc4_);
            _loc2_.id = _loc4_;
            _loc2_.procedure = othersThumbEventProc;
            _loc2_.addEventListener("WME_OVER",othersThumbEventProc);
            _loc2_.addEventListener("WME_OUT",othersThumbEventProc);
            _loc4_++;
         }
         _window = _loc5_;
         acceptButton.addEventListener("WME_CLICK",onAcceptClick);
         cancelButton.addEventListener("WME_CLICK",onCancelClick);
         secondsLeftText.visible = false;
      }
      
      private function onCancelClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredTradingView_WiredTradingModel_1.requestCancelTrading();
      }
      
      private function onAcceptClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 1)
         {
            if(UnknownVarFromWiredTradingView_WiredTradingModel_1.requestAccept())
            {
               startConfirmCountdown();
            }
         }
         else if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 3)
         {
            UnknownVarFromWiredTradingView_WiredTradingModel_1.requestConfirm();
         }
      }
      
      public function updateAllUI() : void
      {
         updateUI();
         updateItemList(false);
         updateItemList(true);
         updateStateUI();
         updateOfferInfoUI();
      }
      
      public function updateUI() : void
      {
         Util.disableButton(acceptButton,!UnknownVarFromWiredTradingView_WiredTradingModel_1.canAccept);
         var _loc1_:Boolean = UnknownVarFromWiredTradingView_WiredTradingModel_1.isPayment();
         tradeTypeSplitter.assetUri = _loc1_ ? "inventory_trading_trading_arrow_icon" : "inventory_trading_trading_split_icon";
         if(_loc1_)
         {
            paymentLayoutImage.assetUri = "wired_chests_images_" + UnknownVarFromWiredTradingView_WiredTradingModel_1.paymentLayoutType + "_payments";
         }
         wiredOfferings.visible = !_loc1_;
         wiredPaymentPlaceholder.visible = _loc1_;
      }
      
      public function tradeStateUpdated() : void
      {
         updateStateUI();
      }
      
      private function updateStateUI() : void
      {
         var _loc1_:String = UnknownVarFromWiredTradingView_WiredTradingModel_1.tradeTypeLocalization.toLowerCase();
         if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 1 || UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 0)
         {
            lockIcon.assetUri = "inventory_trading_trading_unlocked_icon";
         }
         else
         {
            lockIcon.assetUri = "inventory_trading_trading_locked_icon";
         }
         if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 1)
         {
            infoText.text = _localization.getLocalizationWithParams("inventory.wired_trading.note.add_items","","type",_loc1_);
            acceptButton.caption = _localization.getLocalization("inventory.trading.accept");
         }
         else if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 2)
         {
            infoText.text = _localization.getLocalization("inventory.wired_trading.note.countdown");
            acceptButton.caption = "${inventory.trading.countdown}";
            acceptButton.disable();
         }
         else if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 3 || UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 4)
         {
            infoText.text = _localization.getLocalizationWithParams("inventory.wired_trading.note.verify","","type",_loc1_);
            acceptButton.caption = _localization.getLocalization("inventory.trading.confirm");
            if(UnknownVarFromWiredTradingView_WiredTradingModel_1.state == 4)
            {
               acceptButton.disable();
            }
            else
            {
               acceptButton.enable();
            }
         }
      }
      
      private function updateSecondsLeftUI() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = UnknownVarFromWiredTradingView_WiredTradingModel_1.secondsLeft;
         if(_loc3_ >= 0 && _loc3_ < 120)
         {
            secondsLeftText.visible = true;
            _loc2_ = _loc3_ / 60;
            _loc1_ = _loc3_ - _loc2_ * 60;
            secondsLeftText.text = _localization.getLocalizationWithParams("inventory.wired_trading.seconds_left","","seconds",_loc1_ < 10 ? "0" + _loc1_ : _loc1_,"minutes",_loc2_);
         }
         else
         {
            secondsLeftText.visible = false;
         }
      }
      
      public function startConfirmCountdown() : void
      {
         if(UnknownVarFromWiredTradingView_Timer_1 == null)
         {
            UnknownVarFromWiredTradingView_Timer_1 = new Timer(1000,3);
            UnknownVarFromWiredTradingView_Timer_1.addEventListener("timer",timerEventHandler);
         }
         UnknownVarFromWiredTradingView_Timer_1.reset();
         UnknownVarFromWiredTradingView_Timer_1.repeatCount = 3;
         UnknownVarFromWiredTradingView_Timer_1.start();
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter","3");
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         _windowManager.registerLocalizationParameter("inventory.trading.countdown","counter",String(3 - UnknownVarFromWiredTradingView_Timer_1.currentCount));
         if(UnknownVarFromWiredTradingView_Timer_1.currentCount == 3)
         {
            UnknownVarFromWiredTradingView_WiredTradingModel_1.confirmCountdownReady();
            UnknownVarFromWiredTradingView_Timer_1.reset();
            acceptButton.enable();
         }
      }
      
      public function startSecondsLeftTimer() : void
      {
         if(UnknownVarFromWiredTradingView_Timer_2 == null)
         {
            UnknownVarFromWiredTradingView_Timer_2 = new Timer(1000);
            UnknownVarFromWiredTradingView_Timer_2.addEventListener("timer",onSecondsLeftTimer);
         }
         UnknownVarFromWiredTradingView_Timer_2.reset();
         UnknownVarFromWiredTradingView_Timer_2.start();
         updateSecondsLeftUI();
      }
      
      public function stopSecondsLeftTimer() : void
      {
         if(UnknownVarFromWiredTradingView_Timer_2)
         {
            UnknownVarFromWiredTradingView_Timer_2.stop();
         }
      }
      
      private function onSecondsLeftTimer(param1:TimerEvent) : void
      {
         updateSecondsLeftUI();
         if(UnknownVarFromWiredTradingView_WiredTradingModel_1.secondsLeft <= 0)
         {
            stopSecondsLeftTimer();
         }
      }
      
      public function updateItemList(param1:Boolean) : void
      {
         var _loc3_:Map = param1 ? UnknownVarFromWiredTradingView_WiredTradingModel_1.ownUserItems : UnknownVarFromWiredTradingView_WiredTradingModel_1.wiredItems;
         var _loc2_:IItemGridWindow = param1 ? yourItemGrid : wiredItemGrid;
         TradingView.updateItemsGrid(_loc2_,_loc3_);
         updateOfferInfoUI();
      }
      
      public function updateOfferInfoUI() : void
      {
         yourItemCountText.text = _localization.getLocalizationWithParams("inventory.trading.info.itemcount","","value",UnknownVarFromWiredTradingView_WiredTradingModel_1.ownUserNumItems);
         wiredItemCountText.text = _localization.getLocalizationWithParams("inventory.trading.info.itemcount","","value",UnknownVarFromWiredTradingView_WiredTradingModel_1.wiredNumItems);
         yourCreditCountText.text = _localization.getLocalizationWithParams("inventory.trading.info.creditvalue","","value",UnknownVarFromWiredTradingView_WiredTradingModel_1.ownUserNumCredits);
         wiredCreditCountText.text = _localization.getLocalizationWithParams("inventory.trading.info.creditvalue","","value",UnknownVarFromWiredTradingView_WiredTradingModel_1.wiredNumCredits);
      }
      
      private function ownThumbEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         TradingView.thumbEventProc(param1,param2,true,UnknownVarFromWiredTradingView_WiredTradingModel_1,UnknownVarFromWiredTradingView_WiredTradingModel_1.ownUserItems,null,UnknownVarFromWiredTradingView_WiredTradingModel_1.wiredItems,null,UnknownVarFromWiredTradingView_ItemPopupCtrl_1,_localization);
      }
      
      private function othersThumbEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         TradingView.thumbEventProc(param1,param2,false,UnknownVarFromWiredTradingView_WiredTradingModel_1,UnknownVarFromWiredTradingView_WiredTradingModel_1.ownUserItems,null,UnknownVarFromWiredTradingView_WiredTradingModel_1.wiredItems,null,UnknownVarFromWiredTradingView_ItemPopupCtrl_1,_localization);
      }
      
      public function alertTradeCancelled(param1:int) : void
      {
         if(param1 == WiredTradingModel.UnknownVarFromWiredTradingModel_Int_1)
         {
            return;
         }
         var _loc3_:String = _localization.getLocalization("wired_transactions.notification.fail.popup.title");
         var _loc2_:String = _localization.getLocalizationWithParams("wired_transactions.notification.fail","","reason",_localization.getLocalization("wired_transactions.notification.fail." + param1));
         _windowManager.alert(_loc3_,_loc2_,0,null);
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromWiredTradingView_Timer_1)
         {
            UnknownVarFromWiredTradingView_Timer_1.removeEventListener("timer",timerEventHandler);
            UnknownVarFromWiredTradingView_Timer_1.stop();
            UnknownVarFromWiredTradingView_Timer_1 = null;
         }
         if(UnknownVarFromWiredTradingView_Timer_2)
         {
            UnknownVarFromWiredTradingView_Timer_2.removeEventListener("timer",onSecondsLeftTimer);
            UnknownVarFromWiredTradingView_Timer_2.stop();
            UnknownVarFromWiredTradingView_Timer_2 = null;
         }
         _window.dispose();
         _window = null;
         UnknownVarFromWiredTradingView_WiredTradingModel_1 = null;
         _windowManager = null;
         _localization = null;
         _roomEngine = null;
         UnknownVarFromWiredTradingView_IAssetLibraryCollection_1 = null;
         _soundManager = null;
         UnknownVarFromWiredTradingView_ItemPopupCtrl_1.dispose();
         UnknownVarFromWiredTradingView_ItemPopupCtrl_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get infoText() : ITextWindow
      {
         return _window.findChildByName("info_text") as ITextWindow;
      }
      
      public function get tradeTypeSplitter() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("trade_type_splitter") as IStaticBitmapWrapperWindow;
      }
      
      public function get lockIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("lock_0") as IStaticBitmapWrapperWindow;
      }
      
      public function get acceptButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("button_accept") as UnknownICoreWindowComponents4;
      }
      
      public function get cancelButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("button_cancel") as UnknownICoreWindowComponents4;
      }
      
      public function get requirementsButton() : IRegionWindow
      {
         return _window.findChildByName("requirements_button") as IRegionWindow;
      }
      
      public function get yourItemGrid() : IItemGridWindow
      {
         return _window.findChildByName("item_grid_0") as IItemGridWindow;
      }
      
      public function yourItemGridBorder(param1:int) : UnknownICoreWindowComponents6
      {
         return yourItemGrid.getChildByID(param1) as UnknownICoreWindowComponents6;
      }
      
      public function get yourItemCountText() : ITextWindow
      {
         return _window.findChildByName("content_text_1_a") as ITextWindow;
      }
      
      public function get yourCreditCountText() : ITextWindow
      {
         return _window.findChildByName("content_text_1_b") as ITextWindow;
      }
      
      public function get wiredOfferings() : IWindowController_1
      {
         return _window.findChildByName("offers_1") as IWindowController_1;
      }
      
      public function get wiredPaymentPlaceholder() : IWindowController_1
      {
         return _window.findChildByName("offers_1_payment_placeholder") as IWindowController_1;
      }
      
      public function get paymentLayoutImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("payment_layout_image") as IStaticBitmapWrapperWindow;
      }
      
      public function get wiredItemGrid() : IItemGridWindow
      {
         return _window.findChildByName("item_grid_1") as IItemGridWindow;
      }
      
      public function wiredItemGridBorder(param1:int) : UnknownICoreWindowComponents6
      {
         return wiredItemGrid.getChildByID(param1) as UnknownICoreWindowComponents6;
      }
      
      public function get wiredItemCountText() : ITextWindow
      {
         return _window.findChildByName("content_text_2_a") as ITextWindow;
      }
      
      public function get wiredCreditCountText() : ITextWindow
      {
         return _window.findChildByName("content_text_2_b") as ITextWindow;
      }
      
      public function get secondsLeftText() : ITextWindow
      {
         return _window.findChildByName("seconds_left_text") as ITextWindow;
      }
   }
}

