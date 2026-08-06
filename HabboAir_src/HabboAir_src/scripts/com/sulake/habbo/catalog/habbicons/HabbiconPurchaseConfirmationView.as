package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabbiconPurchaseConfirmationView implements IComponentInterfaceQueue
   {
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const MODE_HABBICON:String = "habbicon";
      
      private static const MODE_SET:String = "set";
      
      private static const RETRY_ENABLE_DELAY_MS:int = 500;
      
      private var UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1:HabbiconController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1:HabbiconEntryModel;
      
      private var UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1:HabbiconSetModel;
      
      private var _mode:String;
      
      private var UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1:Timer;
      
      private var UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function HabbiconPurchaseConfirmationView(param1:HabbiconController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.assets.getAssetByName("habbicon_purchase_confirmation_xml").content),1) as IWindowController_1;
         _window.enableLookupCache();
         productImage.disposesBitmap = true;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         cancelButton.addEventListener("WME_CLICK",onWindowClose);
         confirmButton.addEventListener("WME_CLICK",onConfirmClicked);
      }
      
      public function initializeForHabbicon(param1:HabbiconEntryModel) : void
      {
         _mode = "habbicon";
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1 = param1;
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1 = null;
         setPending(false);
         updateHabbiconUI();
      }
      
      public function initializeForSet(param1:HabbiconSetModel) : void
      {
         _mode = "set";
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1 = param1;
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1 = null;
         setPending(false);
         updateSetUI();
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_window.parent == null)
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
      
      public function purchaseFailed() : void
      {
         if(UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1 != null)
         {
            UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.stop();
            UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
         }
         UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1 = new Timer(500,1);
         UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.addEventListener("timerComplete",onRetryTimerComplete);
         UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.start();
      }
      
      public function setPending(param1:Boolean) : void
      {
         UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1 = param1;
         WindowUtils.disableSection(confirmButton,UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1);
         WindowUtils.disableSection(cancelButton,UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1);
         WindowUtils.disableSection(closeButton,UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1);
      }
      
      private function updateHabbiconUI() : void
      {
         if(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1 == null)
         {
            return;
         }
         productName.text = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.name;
         descriptionText.text = "${habbicon_purchase.confirm.habbicon.desc}";
         previewLabel.text = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.collectionTitle;
         receiveRow.visible = true;
         receiveText.text = getHabbiconProgressText(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1);
         normalPriceRow.visible = false;
         discountRow.visible = false;
         priceLabel.text = "${catalog.purchase.confirmation.dialog.cost}";
         updatePrice(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.priceCredits,UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.priceActivityPoints,UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.activityPointType);
         showProductImage(createHabbiconBitmap(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.habbiconId));
      }
      
      private function updateSetUI() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1 == null)
         {
            return;
         }
         _loc1_ = getSetPurchaseCount(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1);
         _loc4_ = getSetPrice(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1);
         _loc2_ = getSetIndividualPrice(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1);
         _loc3_ = _loc2_ - _loc4_;
         productName.text = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.title;
         descriptionText.text = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_purchase.confirm.set.desc","Buy the %set_name% set?","set_name",UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.title);
         previewLabel.text = "${habbicon_purchase.confirm.set.preview}";
         receiveRow.visible = true;
         receiveText.text = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.localizationManager.getLocalizationWithParams(_loc1_ == 1 ? "habbicon_purchase.confirm.set.receive.one" : "habbicon_purchase.confirm.set.receive",_loc1_ == 1 ? "You\'ll receive 1 Habbicon" : "You\'ll receive %count% Habbicons","count",_loc1_);
         priceLabel.text = "${habbicon_purchase.confirm.set_price}";
         updatePrice(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.priceCredits,UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.priceActivityPoints,UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.activityPointType);
         normalPriceRow.visible = _loc2_ > _loc4_;
         normalPriceAmount.text = formatInlinePrice(_loc2_,getSetCurrencyType(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1));
         discountRow.visible = _loc3_ > 0;
         discountAmount.text = formatInlinePrice(Math.max(0,_loc3_),getSetCurrencyType(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1));
         showProductImage(createSetBitmap(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1));
      }
      
      private function getHabbiconProgressText(param1:HabbiconEntryModel) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:UnknownHabboCommunicationMessagesParserHabbicons3 = findCollection(param1.collectionId);
         var _loc2_:int = getCollectionTotal(_loc5_);
         if(_loc5_ == null || _loc2_ <= 0)
         {
            return UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_purchase.confirm.habbicon.set","Set: %set_name%","set_name",param1.collectionTitle);
         }
         _loc3_ = getCollectionOwnedCount(_loc5_);
         _loc4_ = Math.min(_loc2_,_loc3_ + 1);
         return UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_purchase.confirm.habbicon.progress","Progress after buy: %progress% / %total%","progress",_loc4_,"total",_loc2_);
      }
      
      private function updatePrice(param1:int, param2:int, param3:int) : void
      {
         priceAmount.text = formatPriceAmount(param1,param2);
         priceIcon.style = getPriceIconStyle(param1,param2,param3);
         priceIcon.fitToSize();
      }
      
      private function formatPriceAmount(param1:int, param2:int) : String
      {
         if(param1 > 0 && param2 > 0)
         {
            return param1 + "c + " + param2;
         }
         if(param1 > 0)
         {
            return param1.toString();
         }
         return Math.max(0,param2).toString();
      }
      
      private function formatInlinePrice(param1:int, param2:int) : String
      {
         if(param2 == 7)
         {
            return param1 + "c";
         }
         return param1.toString();
      }
      
      private function getPriceIconStyle(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = param2 > 0 ? param3 : 7;
         return ActivityPointTypeEnum.getIconStyleFor(_loc4_,UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.configuration,true);
      }
      
      private function getSetCurrencyType(param1:HabbiconSetModel) : int
      {
         return param1.priceCredits > 0 ? 7 : param1.activityPointType;
      }
      
      private function getSetPrice(param1:HabbiconSetModel) : int
      {
         return param1.priceCredits > 0 ? param1.priceCredits : Math.max(0,param1.priceActivityPoints);
      }
      
      private function findCollection(param1:int) : UnknownHabboCommunicationMessagesParserHabbicons3
      {
         var _loc2_:Vector.<UnknownHabboCommunicationMessagesParserHabbicons3> = UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.shopCollections;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_ != null && _loc3_.collectionId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getCollectionTotal(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : int
      {
         return param1 == null || param1.habbicons == null ? 0 : param1.habbicons.length;
      }
      
      private function getCollectionOwnedCount(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : int
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1 == null || param1.habbicons == null)
         {
            return 0;
         }
         for each(_loc2_ in param1.habbicons)
         {
            if(_loc2_ != null && isOwnedState(_loc2_.state))
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function isOwnedState(param1:int) : Boolean
      {
         return param1 == 2 || param1 == 3;
      }
      
      private function getSetPurchaseCount(param1:HabbiconSetModel) : int
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in param1.habbicons)
         {
            if(isMissingForSetPurchase(_loc2_))
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function getSetIndividualPrice(param1:HabbiconSetModel) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1.habbicons)
         {
            if(isMissingForSetPurchase(_loc3_))
            {
               _loc2_ += _loc3_.priceCredits > 0 ? _loc3_.priceCredits : Math.max(0,_loc3_.priceActivityPoints);
            }
         }
         return _loc2_;
      }
      
      private function isMissingForSetPurchase(param1:HabbiconEntryModel) : Boolean
      {
         return param1 != null && !param1.owned && !param1.favorite && !param1.claimable;
      }
      
      private function createHabbiconBitmap(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1,false);
         return _loc2_ != null ? _loc2_.clone() : new BitmapData(40,40,false,9408399);
      }
      
      private function createSetBitmap(param1:HabbiconSetModel) : BitmapData
      {
         if(param1.UnknownVarFromHabbiconSetModel_BitmapData_1 != null)
         {
            return param1.UnknownVarFromHabbiconSetModel_BitmapData_1.clone();
         }
         return new BitmapData(40,40,false,9408399);
      }
      
      private function showProductImage(param1:BitmapData) : void
      {
         clearProductImage();
         productImage.bitmap = param1;
         productImage.visible = param1 != null;
         productImage.invalidate();
      }
      
      private function clearProductImage() : void
      {
         if(productImage.bitmap != null)
         {
            productImage.bitmap = null;
            productImage.invalidate();
         }
      }
      
      private function onConfirmClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1)
         {
            return;
         }
         setPending(true);
         if(_mode == "set" && UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1 != null)
         {
            UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.buyHabbiconCollection(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1.collectionId);
         }
         else if(_mode == "habbicon" && UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1 != null)
         {
            UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.buyHabbicon(UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1.habbiconId);
         }
         else
         {
            setPending(false);
         }
      }
      
      private function onRetryTimerComplete(param1:TimerEvent) : void
      {
         UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
         UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1 = null;
         setPending(false);
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK" || UnknownVarFromHabbiconPurchaseConfirmationView_Boolean_1)
         {
            return;
         }
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1.closeHabbiconPurchaseConfirmation();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1 != null)
         {
            UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.stop();
            UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
            UnknownVarFromHabbiconPurchaseConfirmationView_Timer_1 = null;
         }
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         cancelButton.removeEventListener("WME_CLICK",onWindowClose);
         confirmButton.removeEventListener("WME_CLICK",onConfirmClicked);
         if(_window.parent != null)
         {
            IWindowController_1(_window.parent).removeChild(_window);
         }
         clearProductImage();
         _window.dispose();
         _window = null;
         _windowManager = null;
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconController_1 = null;
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconEntryModel_1 = null;
         UnknownVarFromHabbiconPurchaseConfirmationView_HabbiconSetModel_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get productImage() : IBitmapWrapperController
      {
         return _window.findChildByName("product_image") as IBitmapWrapperController;
      }
      
      private function get previewLabel() : ITextWindow
      {
         return _window.findChildByName("preview_label") as ITextWindow;
      }
      
      private function get productName() : ITextWindow
      {
         return _window.findChildByName("product_name") as ITextWindow;
      }
      
      private function get descriptionText() : ITextWindow
      {
         return _window.findChildByName("description_text") as ITextWindow;
      }
      
      private function get receiveRow() : IWindowModel
      {
         return _window.findChildByName("receive_row");
      }
      
      private function get receiveText() : ITextWindow
      {
         return _window.findChildByName("receive_text") as ITextWindow;
      }
      
      private function get priceLabel() : ITextWindow
      {
         return _window.findChildByName("price_label") as ITextWindow;
      }
      
      private function get priceAmount() : ITextWindow
      {
         return _window.findChildByName("price_amount") as ITextWindow;
      }
      
      private function get priceIcon() : IIconWindow
      {
         return _window.findChildByName("price_icon") as IIconWindow;
      }
      
      private function get normalPriceRow() : IWindowModel
      {
         return _window.findChildByName("normal_price_row");
      }
      
      private function get normalPriceAmount() : ITextWindow
      {
         return _window.findChildByName("normal_price_amount") as ITextWindow;
      }
      
      private function get discountRow() : IWindowModel
      {
         return _window.findChildByName("discount_row");
      }
      
      private function get discountAmount() : ITextWindow
      {
         return _window.findChildByName("discount_amount") as ITextWindow;
      }
      
      private function get cancelButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("cancel_button") as UnknownICoreWindowComponents4;
      }
      
      private function get confirmButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("confirm_button") as UnknownICoreWindowComponents4;
      }
   }
}

