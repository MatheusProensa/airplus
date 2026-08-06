package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferAssetsResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferFeeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftTransferFeeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftTransferAssetsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferAssetsResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftTransferFeeMessageEventParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class TransferNftsTab implements IProfiler_1
   {
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromTransferNftsTab_CollectiblesView_1:CollectiblesView;
      
      private var UnknownVarFromTransferNftsTab_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromTransferNftsTab_CollectiblesController_1:CollectiblesController;
      
      private var UnknownVarFromTransferNftsTab_Boolean_1:Boolean;
      
      private var _waitingForAddresses:Boolean;
      
      private var UnknownVarFromTransferNftsTab_Int_1:int;
      
      private var _isTransferring:Boolean;
      
      private var UnknownVarFromTransferNftsTab_Array_1:Array;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      public function TransferNftsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         UnknownVarFromTransferNftsTab_CollectiblesView_1 = param1;
         UnknownVarFromTransferNftsTab_CollectiblesController_1 = param2;
         UnknownVarFromTransferNftsTab_IWindowController_1_1 = UnknownVarFromTransferNftsTab_CollectiblesView_1.window.findChildByName("transferContainer") as IWindowController_1;
         _loadingIcon = IStaticBitmapWrapperWindow(UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("loading_icon"));
         addMessageEvents();
         initializeData();
         updateReadyState();
         updateTransferButtonState();
         param2.registerUpdateReceiver(this,1);
         transferButton.addEventListener("WME_CLICK",onTransferClicked);
         transferWalletSelection.addEventListener("WE_SELECTED",onSelectWallet);
      }
      
      private function onSelectWallet(param1:WindowEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = transferWalletSelection.selection;
         if(_loc3_ >= 0)
         {
            _loc2_ = transferWalletSelection.enumerateSelection()[_loc3_];
            if(_loc2_.length > 32)
            {
               transferWalletSelection.caption = _loc2_.substring(0,32) + "...";
            }
         }
         updateReadyState();
      }
      
      private function addMessageEvents() : void
      {
         if(!UnknownVarFromTransferNftsTab_CollectiblesController_1)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftTransferFeeMessageEvent(onNftTransferFeeMessage));
         _messageEvents.push(new NftTransferAssetsResultMessageEvent(onNftTransferResultMessage));
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromTransferNftsTab_CollectiblesController_1.addMessageEvent(_loc1_);
         }
      }
      
      private function onNftTransferFeeMessage(param1:NftTransferFeeMessageEvent) : void
      {
         UnknownVarFromTransferNftsTab_Boolean_1 = false;
         var _loc2_:NftTransferFeeMessageEventParser = param1.getParser();
         UnknownVarFromTransferNftsTab_Int_1 = _loc2_.transferFee;
         silverFeeText.text = String(UnknownVarFromTransferNftsTab_Int_1);
         silverFeeText.visible = UnknownVarFromTransferNftsTab_Int_1 > 0;
         silverIcon.visible = UnknownVarFromTransferNftsTab_Int_1 > 0;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function updateReadyState() : void
      {
         loadedContainer.visible = isReady;
         loadingContainer.visible = !isReady;
      }
      
      private function updateTransferButtonState() : void
      {
         var _loc1_:* = UnknownVarFromTransferNftsTab_Int_1 <= UnknownVarFromTransferNftsTab_CollectiblesController_1.catalog.getPurse().silverBalance;
         var _loc2_:Boolean = UnknownVarFromTransferNftsTab_CollectiblesView_1.stardustWallet != null && UnknownVarFromTransferNftsTab_CollectiblesView_1.stardustWallet != "";
         var _loc4_:* = !_isTransferring;
         var _loc3_:* = selectedWallet != null;
         if(_loc1_ && _loc2_ && _loc4_ && _loc3_)
         {
            transferButton.enable();
         }
         else
         {
            transferButton.disable();
         }
      }
      
      public function onSilverBalanceUpdated() : void
      {
         updateTransferButtonState();
      }
      
      private function onTransferClicked(param1:WindowMouseEvent) : void
      {
         transferButton.disable();
         var _loc2_:UnknownICoreWindowUtils2 = UnknownVarFromTransferNftsTab_CollectiblesController_1.windowManager.confirm("${collectibles.transfer}","${collectibles.transfer.confirm}",0,onTransferConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onTransferConfirm(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _isTransferring = true;
            UnknownVarFromTransferNftsTab_CollectiblesController_1.send(new NftTransferAssetsMessageComposer(selectedWallet));
         }
         updateTransferButtonState();
      }
      
      private function onNftTransferResultMessage(param1:NftTransferAssetsResultMessageEvent) : void
      {
         var _loc2_:NftTransferAssetsResultMessageEventParser = param1.getParser();
         UnknownVarFromTransferNftsTab_CollectiblesController_1.notifications.addItem(_loc2_.success ? localization.getLocalization("collectibles.transfer.success") : localization.getLocalizationWithParams("collectibles.transfer.error","","id",_loc2_.resultCode),"info","icon_curator_stamp_large_png");
         _isTransferring = false;
         updateTransferButtonState();
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeTransferWallets(param1);
      }
      
      private function initializeTransferWallets(param1:Array) : void
      {
         transferWalletSelection.populate(param1);
         UnknownVarFromTransferNftsTab_Array_1 = param1;
         if(param1.length == 0)
         {
            transferWalletSelection.color = 13421772;
            transferWalletSelection.disable();
         }
         else
         {
            transferWalletSelection.color = 16777215;
            transferWalletSelection.enable();
            transferWalletSelection.selection = 0;
         }
         _waitingForAddresses = false;
         updateReadyState();
         updateTransferButtonState();
      }
      
      private function get selectedWallet() : String
      {
         if(UnknownVarFromTransferNftsTab_Array_1 == null)
         {
            return null;
         }
         var _loc1_:int = transferWalletSelection.selection;
         if(_loc1_ < 0 || _loc1_ >= UnknownVarFromTransferNftsTab_Array_1.length)
         {
            return null;
         }
         return UnknownVarFromTransferNftsTab_Array_1[_loc1_];
      }
      
      private function initializeData() : void
      {
         UnknownVarFromTransferNftsTab_Boolean_1 = true;
         UnknownVarFromTransferNftsTab_CollectiblesController_1.send(new GetNftTransferFeeMessageComposer());
         var _loc1_:Array = UnknownVarFromTransferNftsTab_CollectiblesView_1.walletAddresses;
         if(_loc1_)
         {
            initializeTransferWallets(_loc1_);
         }
         _waitingForAddresses = _loc1_ == null;
      }
      
      private function get isReady() : Boolean
      {
         return !_waitingForAddresses && !UnknownVarFromTransferNftsTab_Boolean_1;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromTransferNftsTab_CollectiblesController_1.localizationManager;
      }
      
      private function removeMessageEvents() : void
      {
         if(!UnknownVarFromTransferNftsTab_CollectiblesController_1 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromTransferNftsTab_CollectiblesController_1.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         removeMessageEvents();
         UnknownVarFromTransferNftsTab_CollectiblesController_1.removeUpdateReceiver(this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(!isReady)
         {
            _loc2_ = CollectionsTab.UnknownVarFromShopTab_Number_1 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : IWindowController_1
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("loading_contents") as IWindowController_1;
      }
      
      private function get loadedContainer() : IWindowController_1
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("loaded_content") as IWindowController_1;
      }
      
      private function get silverFeeText() : ITextWindow
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("transfer_fee_text") as ITextWindow;
      }
      
      private function get transferButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("transfer_button") as UnknownICoreWindowComponents4;
      }
      
      private function get transferWalletSelection() : IDropBaseController_1
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("transfer_wallet_selection") as IDropBaseController_1;
      }
      
      private function get silverIcon() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromTransferNftsTab_IWindowController_1_1.findChildByName("transfer_fee_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

