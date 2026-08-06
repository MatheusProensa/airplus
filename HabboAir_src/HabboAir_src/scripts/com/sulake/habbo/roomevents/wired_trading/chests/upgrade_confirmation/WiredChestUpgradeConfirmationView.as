package com.sulake.habbo.roomevents.wired_trading.chests.upgrade_confirmation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.UpgradeChestResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.UpgradeChestMessageComposer;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_trading.chests.UnknownHabboRoomeventsWired_TradingChests1;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class WiredChestUpgradeConfirmationView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1:WiredChestController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromWiredChestUpgradeConfirmationView_UpgradeChestResultMessageEvent_1:UpgradeChestResultMessageEvent;
      
      private var _chestId:int;
      
      private var _chestType:int;
      
      private var _chestItemType:int;
      
      private var UnknownVarFromWiredChestUpgradeConfirmationView_Int_1:int;
      
      public function WiredChestUpgradeConfirmationView(param1:WiredChestController)
      {
         super();
         UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1 = param1;
         _windowManager = param1.windowManager;
         _window = _windowManager.buildFromXML(XML(param1.assets.getAssetByName("chest_upgrade_xml").content),1) as IWindowController_1;
         _window.enableLookupCache();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         cancelButton.addEventListener("WME_CLICK",onWindowClose);
         buyButton.addEventListener("WME_CLICK",onBuyClicked);
         amountSelection.addEventListener("WE_SELECTED",onAmountSelected);
         UnknownVarFromWiredChestUpgradeConfirmationView_UpgradeChestResultMessageEvent_1 = new UpgradeChestResultMessageEvent(onUpgradeChestResult);
         param1.addMessageEvent(UnknownVarFromWiredChestUpgradeConfirmationView_UpgradeChestResultMessageEvent_1);
      }
      
      private function onUpgradeChestResult(param1:UpgradeChestResultMessageEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = param1.getParser().resultCode;
         if(_loc3_ == 0)
         {
            UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.roomEvents.notifications.addItem("${wiredchests.upgrade.result.success}","info");
         }
         else
         {
            _loc2_ = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalization("wiredchests.upgrade.result.error." + _loc3_);
            _loc4_ = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.upgrade.result.error","","reason",_loc2_);
            UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.roomEvents.notifications.addItem(_loc4_,"info");
         }
         hide();
      }
      
      private function onBuyClicked(param1:WindowMouseEvent) : void
      {
         buyButton.disable();
         UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.send(new UpgradeChestMessageComposer(_chestId,amountSelection.selection + 1));
      }
      
      public function initialize(param1:int, param2:int, param3:int, param4:int) : void
      {
         _chestId = param1;
         _chestType = param2;
         _chestItemType = param3;
         UnknownVarFromWiredChestUpgradeConfirmationView_Int_1 = param4;
         initializeDropMenu();
         updateUI();
      }
      
      private function initializeDropMenu() : void
      {
         var _loc6_:String = _chestType == UnknownHabboRoomeventsWired_TradingChests1.TYPE_COIN ? "coins" : "furni";
         var _loc3_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired." + _loc6_ + "_chest.max_upgrades",0);
         var _loc4_:Vector.<String> = new Vector.<String>();
         _loc4_.push("1");
         var _loc1_:int = 2;
         var _loc2_:int = UnknownVarFromWiredChestUpgradeConfirmationView_Int_1 + 2;
         while(_loc2_ <= _loc3_)
         {
            _loc4_.push(String(_loc1_));
            _loc1_ += 1;
            _loc2_ += 1;
         }
         amountSelection.populateWithVector(_loc4_);
         amountSelection.selection = 0;
         var _loc5_:* = UnknownVarFromWiredChestUpgradeConfirmationView_Int_1 >= _loc3_;
         Util.disableSection(amountSelection,_loc5_);
      }
      
      private function onAmountSelected(param1:WindowEvent) : void
      {
         updateUI();
      }
      
      private function updateUI() : void
      {
         var _loc7_:int = amountSelection.selection + 1;
         buyButton.enable();
         cancelButton.enable();
         var _loc11_:UnknownHabboRoom1 = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.roomEngine.getFurnitureImage(_chestItemType,new Vector3d(90,0,0),64,this);
         if(_loc11_.data)
         {
            showChestPreview(_loc11_.data);
         }
         var _loc8_:String = null;
         var _loc5_:String = _chestType == UnknownHabboRoomeventsWired_TradingChests1.TYPE_COIN ? "coins" : "furni";
         var _loc4_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired." + _loc5_ + "_chest.initial_capacity",0);
         var _loc13_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired." + _loc5_ + "_chest.upgrade_capacity",0);
         var _loc3_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired." + _loc5_ + "_chest.max_upgrades",0);
         var _loc9_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired.chests.upgrade_cost_credits",999);
         var _loc6_:int = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.getInteger("wired.chests.upgrade_cost_diamonds",999);
         var _loc12_:* = UnknownVarFromWiredChestUpgradeConfirmationView_Int_1 >= _loc3_;
         var _loc15_:IPurse = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.catalog.getPurse();
         var _loc14_:Boolean = _loc15_.credits < _loc9_ * _loc7_ || _loc15_.getActivityPointsForType(5) < _loc6_ * _loc7_;
         if(_loc12_)
         {
            _loc8_ = "wiredchests.upgrade.error.reason.at_capacity";
         }
         else if(_loc14_)
         {
            _loc8_ = "wiredchests.upgrade.error.reason.not_enough_currency";
         }
         var _loc10_:int = _loc4_ + UnknownVarFromWiredChestUpgradeConfirmationView_Int_1 * _loc13_;
         var _loc1_:int = _loc13_ * _loc7_;
         var _loc2_:int = _loc10_ + _loc1_;
         productNameText.text = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.upgrade.capacity.extra","","purchase_capacity",_loc1_);
         currentCapacityText.text = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.upgrade.capacity.current","","current_capacity",_loc10_);
         newCapacity.text = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.upgrade.capacity.new","","new_capacity",_loc2_);
         priceCreditsText.text = String(_loc9_ * _loc7_);
         priceDiamondsText.text = String(_loc6_ * _loc7_);
         priceCreditsText.visible = _loc9_ != 0;
         priceDiamondsText.visible = _loc6_ != 0;
         pricePlusText.visible = _loc9_ != 0 && _loc6_ != 0;
         errorText.visible = _loc8_ != null;
         if(_loc8_ != null)
         {
            buyButton.disable();
            errorText.text = UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalizationWithParams("wiredchests.upgrade.error","","reason",UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.localization.getLocalization(_loc8_));
         }
      }
      
      private function showChestPreview(param1:BitmapData) : void
      {
         productImage.bitmap = param1;
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.center();
         _window.activate();
      }
      
      private function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         showChestPreview(param2);
      }
      
      public function imageFailed(param1:int) : void
      {
         showChestPreview(null);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(!UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.disposed)
         {
            UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1.removeMessageEvent(UnknownVarFromWiredChestUpgradeConfirmationView_UpgradeChestResultMessageEvent_1);
         }
         hide();
         _window.dispose();
         _window = null;
         _windowManager = null;
         UnknownVarFromWiredChestUpgradeConfirmationView_WiredChestController_1 = null;
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
      
      public function get productImage() : IBitmapWrapperController
      {
         return _window.findChildByName("product_image") as IBitmapWrapperController;
      }
      
      public function get productNameText() : ITextWindow
      {
         return _window.findChildByName("product_name") as ITextWindow;
      }
      
      public function get currentCapacityText() : ITextWindow
      {
         return _window.findChildByName("current_capacity") as ITextWindow;
      }
      
      public function get newCapacity() : ITextWindow
      {
         return _window.findChildByName("new_capacity") as ITextWindow;
      }
      
      public function get amountSelection() : IDropBaseController_1
      {
         return _window.findChildByName("amount_selection_dropmenu") as IDropBaseController_1;
      }
      
      public function get priceCreditsText() : ITextWindow
      {
         return _window.findChildByName("price_credits") as ITextWindow;
      }
      
      public function get pricePlusText() : ITextWindow
      {
         return _window.findChildByName("plus") as ITextWindow;
      }
      
      public function get priceDiamondsText() : ITextWindow
      {
         return _window.findChildByName("price_diamonds") as ITextWindow;
      }
      
      public function get errorText() : ITextWindow
      {
         return _window.findChildByName("error_text") as ITextWindow;
      }
      
      public function get cancelButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("cancel_button") as UnknownICoreWindowComponents4;
      }
      
      public function get buyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("buy_button") as UnknownICoreWindowComponents4;
      }
   }
}

