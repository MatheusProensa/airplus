package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.catalog.collectibles.tabs.MintInventoryListTab;
   import com.sulake.habbo.catalog.collectibles.tabs.RewardClaimsTab;
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   import com.sulake.habbo.catalog.collectibles.tabs.TransferNftsTab;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleWalletAddressesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsScoreMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleWalletAddressesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectorScoreMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleWalletAddressesMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollectionsScoreMessageEventParser;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class CollectiblesView implements IComponentInterfaceQueue
   {
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static const STARDUST_WALLET_DISPLAY_NAME:String = "Collector Wallet";
      
      private static const TAB_COLLECTIONS:String = "top_view_collections_button";
      
      private static const TAB_MINT:String = "top_view_minting_button";
      
      private static const TAB_INFO:String = "top_view_info_button";
      
      private static const TAB_TRANSFER:String = "top_view_transfer_button";
      
      private static const TAB_SHOP:String = "top_view_shop_button";
      
      private static const TAB_REWARDS:String = "top_view_rewards_button";
      
      private static const TAB_COLLECTOR_PROFILE:String = "top_view_profile_button";
      
      private static const TAB_LEVELS:String = "top_view_levels_button";
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromCollectiblesView_CollectiblesController_1:CollectiblesController;
      
      private var _window:IWindowController_1;
      
      private var _currentTab:String = "top_view_rewards_button";
      
      private var _mintInventoryListWidget:MintInventoryListTab;
      
      private var _collectionsWidget:CollectionsTab;
      
      private var _transferWidget:TransferNftsTab;
      
      private var UnknownVarFromCollectiblesView_ShopTab_1:ShopTab;
      
      private var UnknownVarFromCollectiblesView_RewardClaimsTab_1:RewardClaimsTab;
      
      private var UnknownVarFromCollectiblesView_Boolean_1:Boolean = false;
      
      private var _walletAddresses:Array = null;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _activeWallet:String;
      
      private var _stardustWallet:String;
      
      public function CollectiblesView(param1:CollectiblesController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromCollectiblesView_CollectiblesController_1 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(UnknownVarFromCollectiblesView_CollectiblesController_1.assets.getAssetByName("collectible_view_xml").content),1) as IWindowController_1;
         _window.findChildByName("top_view_profile_button").procedure = onTab;
         _window.findChildByName("top_view_collections_button").procedure = onTab;
         _window.findChildByName("top_view_levels_button").procedure = onTab;
         _window.findChildByName("top_view_minting_button").procedure = onTab;
         _window.findChildByName("top_view_info_button").procedure = onTab;
         _window.findChildByName("top_view_transfer_button").procedure = onTab;
         _window.findChildByName("top_view_shop_button").procedure = onTab;
         _window.findChildByName("top_view_rewards_button").procedure = onTab;
         _window.findChildByName("top_view_collections_button").caption = "${collectibles.collections.title}";
         _window.findChildByName("top_view_shop_button").caption = "${collectibles.shop.title}";
         _window.findChildByName("top_view_minting_button").caption = "${shop.minting.title}";
         _window.findChildByName("top_view_transfer_button").caption = "${collectibles.transfer}";
         _window.findChildByName("top_view_info_button").caption = "${collectibles.info.title}";
         _window.findChildByName("top_view_rewards_button").caption = "${collectibles.claim.title}";
         addMessageEvents();
         refresh();
         requestWalletAddresses();
         var _loc6_:Boolean = param1.context.configuration.getBoolean("nft.minting.enabled");
         _window.findChildByName("top_view_minting_button").visible = _loc6_;
         var _loc3_:Boolean = param1.context.configuration.getBoolean("collectibles.transfer.enabled");
         _window.findChildByName("top_view_transfer_button").visible = _loc3_;
         var _loc4_:Boolean = param1.context.configuration.getBoolean("nft.shop.enabled");
         _window.findChildByName("top_view_shop_button").visible = _loc4_;
         levelTitle.caption = param1.localizationManager.getLocalization("collectibles.level").toUpperCase();
         centerTabLayout();
         initWidgets();
         var _loc5_:IWindowModel = _window.findChildByName("header_button_close");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onWindowClose);
         }
         infoLink.addEventListener("WE_LINK",onClickHtmlLink);
         infoLink.initializeLinkStyle();
         transferLink.addEventListener("WE_LINK",onClickHtmlLink);
         transferLink.initializeLinkStyle();
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
      
      private function hideWindow() : void
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
      
      public function showWindow() : void
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
      }
      
      private function centerTabLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:IWindowModel = null;
         var _loc4_:ISelectorListWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context")).selector;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.numSelectables)
         {
            _loc1_ = _loc4_.getSelectableAt(_loc3_);
            if(_loc1_.visible)
            {
               _loc2_ += _loc1_.width;
            }
            else
            {
               _loc1_.width = 0;
            }
            _loc3_++;
         }
         _loc4_.x = _window.width / 2 - _loc2_ / 2;
         window.findChildByName("tab_bg").visible = _loc2_ > 350;
      }
      
      private function addMessageEvents() : void
      {
         if(!UnknownVarFromCollectiblesView_CollectiblesController_1)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CollectibleWalletAddressesMessageEvent(onCollectableWalletAddressMessage));
         _messageEvents.push(new NftCollectionsScoreMessageEvent(onCollectionsScoreMessage));
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromCollectiblesView_CollectiblesController_1.addMessageEvent(_loc1_);
         }
      }
      
      public function updateBalances(param1:IPurse) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("emerald_currency_value");
         if(_loc2_)
         {
            _loc2_.caption = "" + param1.emeraldBalance;
         }
         var _loc3_:IWindowModel = _window.findChildByName("silver_currency_value");
         if(_loc3_)
         {
            _loc3_.caption = "" + param1.silverBalance;
         }
         if(_transferWidget)
         {
            _transferWidget.onSilverBalanceUpdated();
         }
      }
      
      private function onCollectionsScoreMessage(param1:NftCollectionsScoreMessageEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:NftCollectionsScoreMessageEventParser = param1.getParser();
         levelValue.caption = String(_loc2_.level);
         scoreValue.caption = String(_loc2_.score);
         hiscoreValue.caption = String(_loc2_.highestScore);
         var _loc4_:int;
         switch(_loc4_ = Math.max(0,(_loc2_.level - 1) / 5))
         {
            case 0:
               _loc3_ = 8162450;
               break;
            case 1:
               _loc3_ = 2529547;
               break;
            case 2:
               _loc3_ = 32234;
               break;
            case 3:
               _loc3_ = 13828339;
               break;
            default:
               _loc3_ = 15571457;
         }
         collectorLevelBg.color = _loc3_;
         collectorLevelBg2.color = _loc3_;
      }
      
      private function onCollectableWalletAddressMessage(param1:CollectibleWalletAddressesMessageEvent) : void
      {
         UnknownVarFromCollectiblesView_Boolean_1 = false;
         var _loc2_:CollectibleWalletAddressesMessageEventParser = param1.getParser();
         _walletAddresses = _loc2_.walletAddresses;
         _stardustWallet = _loc2_.stardustWalletAddress;
         if(_collectionsWidget)
         {
            _collectionsWidget.onWalletsAddressesUpdated(_walletAddresses);
         }
         if(_transferWidget)
         {
            _transferWidget.onWalletsAddressesUpdated(nonStardustWallets);
         }
         if(UnknownVarFromCollectiblesView_RewardClaimsTab_1)
         {
            UnknownVarFromCollectiblesView_RewardClaimsTab_1.onWalletsAddressesUpdated(_walletAddresses);
         }
         setActiveWalletIndex(0);
      }
      
      public function get nonStardustWallets() : Array
      {
         if(_walletAddresses == null)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(var _loc1_ in _walletAddresses)
         {
            if(_loc1_ != _stardustWallet)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function walletsLoaded() : Boolean
      {
         return _walletAddresses != null;
      }
      
      public function setActiveWalletIndex(param1:int) : void
      {
         if(_walletAddresses.length > 0 && (param1 < 0 || param1 >= _walletAddresses.length || _walletAddresses[param1] == _activeWallet))
         {
            return;
         }
         _activeWallet = _walletAddresses.length > 0 ? _walletAddresses[param1] : null;
         if(_collectionsWidget)
         {
            _collectionsWidget.activeWallet = _activeWallet;
         }
         if(_mintInventoryListWidget)
         {
            _mintInventoryListWidget.activeWallet = _activeWallet;
         }
         if(_activeWallet != null)
         {
            UnknownVarFromCollectiblesView_CollectiblesController_1.send(new GetCollectorScoreMessageComposer(_activeWallet));
         }
      }
      
      private function requestWalletAddresses() : void
      {
         if(UnknownVarFromCollectiblesView_Boolean_1)
         {
            return;
         }
         UnknownVarFromCollectiblesView_Boolean_1 = true;
         UnknownVarFromCollectiblesView_CollectiblesController_1.send(new GetCollectibleWalletAddressesMessageComposer());
      }
      
      public function get walletAddresses() : Array
      {
         return _walletAddresses;
      }
      
      private function refresh() : void
      {
         var _loc1_:ITabContextWindow = ITabContextWindow(_window.findChildByName("top_view_select_tab_context"));
         _loc1_.selector.setSelected(ISelectableWindow(_window.findChildByName(_currentTab)));
         hideAllTabContainers();
         switch(_currentTab)
         {
            case "top_view_profile_button":
               _window.findChildByName("collectorProfileContainer").visible = true;
               break;
            case "top_view_collections_button":
               _window.findChildByName("collectionsContainer").visible = true;
               if(!_collectionsWidget)
               {
                  _collectionsWidget = new CollectionsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
               }
               break;
            case "top_view_levels_button":
               _window.findChildByName("levelsContainer").visible = true;
               break;
            case "top_view_minting_button":
               _window.findChildByName("mintingContainer").visible = true;
               if(!_mintInventoryListWidget)
               {
                  _mintInventoryListWidget = new MintInventoryListTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
               }
               break;
            case "top_view_transfer_button":
               _window.findChildByName("transferContainer").visible = true;
               if(!_transferWidget)
               {
                  _transferWidget = new TransferNftsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
               }
               break;
            case "top_view_info_button":
               _window.findChildByName("infoContainer").visible = true;
               break;
            case "top_view_shop_button":
               _window.findChildByName("shopContainer").visible = true;
               if(!UnknownVarFromCollectiblesView_ShopTab_1)
               {
                  UnknownVarFromCollectiblesView_ShopTab_1 = new ShopTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
               }
               break;
            case "top_view_rewards_button":
               _window.findChildByName("rewardsContainer").visible = true;
               if(!UnknownVarFromCollectiblesView_RewardClaimsTab_1)
               {
                  UnknownVarFromCollectiblesView_RewardClaimsTab_1 = new RewardClaimsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
               }
         }
      }
      
      private function initWidgets() : void
      {
         if(!_collectionsWidget)
         {
            _collectionsWidget = new CollectionsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
         }
         if(!_mintInventoryListWidget)
         {
            _mintInventoryListWidget = new MintInventoryListTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
         }
         if(!_transferWidget)
         {
            _transferWidget = new TransferNftsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
         }
         if(!UnknownVarFromCollectiblesView_ShopTab_1)
         {
            UnknownVarFromCollectiblesView_ShopTab_1 = new ShopTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
         }
         if(!UnknownVarFromCollectiblesView_RewardClaimsTab_1)
         {
            UnknownVarFromCollectiblesView_RewardClaimsTab_1 = new RewardClaimsTab(this,UnknownVarFromCollectiblesView_CollectiblesController_1);
         }
      }
      
      public function get activeWallet() : String
      {
         return _activeWallet;
      }
      
      private function hideAllTabContainers() : void
      {
         _window.findChildByName("collectorProfileContainer").visible = false;
         _window.findChildByName("collectionsContainer").visible = false;
         _window.findChildByName("levelsContainer").visible = false;
         _window.findChildByName("mintingContainer").visible = false;
         _window.findChildByName("transferContainer").visible = false;
         _window.findChildByName("infoContainer").visible = false;
         _window.findChildByName("shopContainer").visible = false;
         _window.findChildByName("rewardsContainer").visible = false;
      }
      
      private function onTab(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _currentTab = param2.name;
         refresh();
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!UnknownVarFromCollectiblesView_CollectiblesController_1 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromCollectiblesView_CollectiblesController_1.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function get stardustWallet() : String
      {
         return _stardustWallet;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         if(_collectionsWidget)
         {
            _collectionsWidget.dispose();
            _collectionsWidget = null;
         }
         if(_mintInventoryListWidget)
         {
            _mintInventoryListWidget.dispose();
            _mintInventoryListWidget = null;
         }
         if(_transferWidget)
         {
            _transferWidget.dispose();
            _transferWidget = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get mintInventoryListWidget() : MintInventoryListTab
      {
         return _mintInventoryListWidget;
      }
      
      public function get transferWidget() : TransferNftsTab
      {
         return _transferWidget;
      }
      
      public function get collectionsWidget() : CollectionsTab
      {
         return _collectionsWidget;
      }
      
      private function get scoreValue() : ITextWindow
      {
         return _window.findChildByName("current_score_value") as ITextWindow;
      }
      
      private function get hiscoreValue() : ITextWindow
      {
         return _window.findChildByName("current_hiscore_value") as ITextWindow;
      }
      
      private function get levelValue() : ITextWindow
      {
         return _window.findChildByName("collector_level") as ITextWindow;
      }
      
      private function get levelTitle() : ITextWindow
      {
         return _window.findChildByName("level_title") as ITextWindow;
      }
      
      private function get collectorLevelBg() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg") as IStaticBitmapWrapperWindow;
      }
      
      private function get collectorLevelBg2() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("collector_level_bg2") as IStaticBitmapWrapperWindow;
      }
      
      private function get infoLink() : IHTMLTextController
      {
         return _window.findChildByName("info_desc") as IHTMLTextController;
      }
      
      private function get transferLink() : IHTMLTextController
      {
         return _window.findChildByName("transfer_desc") as IHTMLTextController;
      }
   }
}

