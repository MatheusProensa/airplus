package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.RewardCollectibleItemRenderer;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftClaimResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftClaimsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.ClaimNftClaimsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftClaimsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaim;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaimResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaimsMessageEventParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.events.TimerEvent;
   import flash.globalization.DateTimeFormatter;
   import flash.utils.Timer;
   
   public class RewardClaimsTab implements IProfiler_1
   {
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromRewardClaimsTab_CollectiblesView_1:CollectiblesView;
      
      private var UnknownVarFromRewardClaimsTab_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRewardClaimsTab_CollectiblesController_1:CollectiblesController;
      
      private var UnknownVarFromRewardClaimsTab_IItemListWindow_1:IItemListWindow;
      
      private var _listItems:Vector.<RewardCollectibleItemRenderer>;
      
      private var UnknownVarFromRewardClaimsTab_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromRewardClaimsTab_DateTimeFormatter_1:DateTimeFormatter;
      
      private var _isReady:Boolean;
      
      private var UnknownVarFromRewardClaimsTab_Boolean_1:Boolean;
      
      private var UnknownVarFromRewardClaimsTab_Array_1:Array = [];
      
      private var UnknownVarFromRewardClaimsTab_Timer_1:Timer;
      
      private var _isRequestInProgress:Boolean = false;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      public function RewardClaimsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         UnknownVarFromRewardClaimsTab_CollectiblesView_1 = param1;
         UnknownVarFromRewardClaimsTab_CollectiblesController_1 = param2;
         UnknownVarFromRewardClaimsTab_DateTimeFormatter_1 = new DateTimeFormatter("i-default");
         UnknownVarFromRewardClaimsTab_DateTimeFormatter_1.setDateTimePattern("dd/MM/yyyy");
         UnknownVarFromRewardClaimsTab_Timer_1 = new Timer(600);
         UnknownVarFromRewardClaimsTab_Timer_1.addEventListener("timer",processNextRequest);
         UnknownVarFromRewardClaimsTab_IWindowController_1_1 = UnknownVarFromRewardClaimsTab_CollectiblesView_1.window.findChildByName("rewardsContainer") as IWindowController_1;
         _loadingIcon = IStaticBitmapWrapperWindow(UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("loading_icon"));
         UnknownVarFromRewardClaimsTab_IItemListWindow_1 = IItemListWindow(UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("itemlist"));
         UnknownVarFromRewardClaimsTab_IWindowModel_1 = UnknownVarFromRewardClaimsTab_IItemListWindow_1.removeListItem(UnknownVarFromRewardClaimsTab_IItemListWindow_1.getListItemByName("item_template"));
         _listItems = new Vector.<RewardCollectibleItemRenderer>();
         setReady(false);
         addMessageEvents();
         updateClaimButtonState();
         param2.registerUpdateReceiver(this,1);
         claimButton.addEventListener("WME_CLICK",onClaimClicked);
      }
      
      private function addMessageEvents() : void
      {
         if(!UnknownVarFromRewardClaimsTab_CollectiblesController_1)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftClaimsMessageEvent(onNftClaimsMessage));
         _messageEvents.push(new NftClaimResultMessageEvent(onNftClaimResultMessage));
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromRewardClaimsTab_CollectiblesController_1.addMessageEvent(_loc1_);
         }
      }
      
      private function requestRewardClaims(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            requestClaimsForWallet(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         requestRewardClaims(param1);
      }
      
      private function requestClaimsForWallet(param1:String) : void
      {
         UnknownVarFromRewardClaimsTab_Array_1.push(param1);
         if(!UnknownVarFromRewardClaimsTab_Timer_1.running)
         {
            UnknownVarFromRewardClaimsTab_Timer_1.start();
         }
      }
      
      private function processNextRequest(param1:TimerEvent) : void
      {
         if(_isRequestInProgress || UnknownVarFromRewardClaimsTab_Array_1.length == 0)
         {
            return;
         }
         var _loc2_:String = UnknownVarFromRewardClaimsTab_Array_1.shift();
         UnknownVarFromRewardClaimsTab_CollectiblesController_1.send(new GetNftClaimsMessageComposer(_loc2_));
         _isRequestInProgress = true;
      }
      
      private function updateClaimButtonState() : void
      {
         var _loc1_:Boolean = UnknownVarFromRewardClaimsTab_IItemListWindow_1 != null && UnknownVarFromRewardClaimsTab_IItemListWindow_1.numListItems > 0;
         var _loc2_:Boolean = !UnknownVarFromRewardClaimsTab_Boolean_1 && !_isRequestInProgress;
         if(_loc1_ && _loc2_)
         {
            claimButton.enable();
         }
         else
         {
            claimButton.disable();
         }
      }
      
      private function onClaimClicked(param1:WindowMouseEvent) : void
      {
         claimButton.disable();
         UnknownVarFromRewardClaimsTab_Boolean_1 = true;
         UnknownVarFromRewardClaimsTab_CollectiblesController_1.send(new ClaimNftClaimsMessageComposer());
         setReady(false);
      }
      
      private function onNftClaimsMessage(param1:NftClaimsMessageEvent) : void
      {
         var _loc3_:NftClaimsMessageEventParser = param1.getParser();
         for each(var _loc2_ in _loc3_.nftClaims)
         {
            if(_loc2_.claimedAmount < _loc2_.claimLimit)
            {
               createRewardItem(_loc2_);
            }
         }
         _isRequestInProgress = false;
         if(UnknownVarFromRewardClaimsTab_Array_1.length == 0)
         {
            UnknownVarFromRewardClaimsTab_Timer_1.stop();
            setReady(true);
            updateClaimButtonState();
         }
      }
      
      private function onNftClaimResultMessage(param1:NftClaimResultMessageEvent) : void
      {
         var _loc2_:NftClaimResultMessageEventParser = param1.getParser();
         UnknownVarFromRewardClaimsTab_CollectiblesController_1.notifications.addItem(_loc2_.success ? localization.getLocalization("collectibles.claiming.success") : localization.getLocalizationWithParams("collectibles.claiming.failed","","id",_loc2_.resultCode),"info","icon_curator_stamp_large_png");
         if(_loc2_.success)
         {
            clearItems();
         }
         UnknownVarFromRewardClaimsTab_Boolean_1 = false;
         updateClaimButtonState();
         setReady(true);
      }
      
      private function createRewardItem(param1:NftClaim) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:IWindowController_1 = UnknownVarFromRewardClaimsTab_IWindowModel_1.clone() as IWindowController_1;
         var _loc2_:RewardCollectibleItemRenderer = new RewardCollectibleItemRenderer(UnknownVarFromRewardClaimsTab_CollectiblesController_1,param1,_loc3_,this);
         _listItems.push(_loc2_);
         UnknownVarFromRewardClaimsTab_IItemListWindow_1.addListItem(_loc3_);
         _loc2_.updateVisuals();
         _loc2_.updateExpiresText(UnknownVarFromRewardClaimsTab_DateTimeFormatter_1.format(new Date(param1.validTo)));
      }
      
      private function setReady(param1:Boolean) : void
      {
         var _loc2_:Boolean = UnknownVarFromRewardClaimsTab_IItemListWindow_1 != null && UnknownVarFromRewardClaimsTab_IItemListWindow_1.numListItems > 0;
         loadedContainer.visible = param1 && _loc2_;
         noContentContainer.visible = param1 && !_loc2_;
         loadingContainer.visible = !param1;
         _isReady = param1;
      }
      
      private function get isReady() : Boolean
      {
         return _isReady;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromRewardClaimsTab_CollectiblesController_1.localizationManager;
      }
      
      private function removeMessageEvents() : void
      {
         if(!UnknownVarFromRewardClaimsTab_CollectiblesController_1 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromRewardClaimsTab_CollectiblesController_1.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      private function clearItems() : void
      {
         if(_listItems)
         {
            for each(var _loc1_ in _listItems)
            {
               _loc1_.dispose();
            }
            _listItems.length = 0;
         }
         if(UnknownVarFromRewardClaimsTab_IItemListWindow_1)
         {
            UnknownVarFromRewardClaimsTab_IItemListWindow_1.destroyListItems();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clearItems();
         UnknownVarFromRewardClaimsTab_Timer_1.removeEventListener("timer",processNextRequest);
         removeMessageEvents();
         UnknownVarFromRewardClaimsTab_CollectiblesController_1.removeUpdateReceiver(this);
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
         return UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("loading_contents") as IWindowController_1;
      }
      
      private function get loadedContainer() : IWindowController_1
      {
         return UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("loaded_content") as IWindowController_1;
      }
      
      private function get noContentContainer() : IWindowController_1
      {
         return UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("no_content_container") as IWindowController_1;
      }
      
      private function get claimButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromRewardClaimsTab_IWindowController_1_1.findChildByName("claim_button") as UnknownICoreWindowComponents4;
      }
   }
}

