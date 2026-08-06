package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public interface IMarketPlace
   {
      function get windowManager() : IHabboWindowManagerComponent;
      
      function get localization() : IHabboLocalizationManager;
      
      function registerVisualization(param1:IMarketPlaceVisualization = null) : void;
      
      function onOffers(param1:IMessageEvent) : void;
      
      function onOwnOffers(param1:IMessageEvent) : void;
      
      function onBuyResult(param1:IMessageEvent) : void;
      
      function onCancelResult(param1:IMessageEvent) : void;
      
      function onCancelAllResult(param1:IMessageEvent) : void;
      
      function onClearOwnHistoryResult(param1:IMessageEvent) : void;
      
      function requestOffersByName(param1:String, param2:Boolean = true) : void;
      
      function requestOffersByPrice(param1:int, param2:Boolean = true) : void;
      
      function requestOffers(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true) : void;
      
      function refreshOffers() : void;
      
      function requestOwnItems(param1:int = 1) : void;
      
      function requestItemStats(param1:IMarketPlaceOfferData) : void;
      
      function buyOffer(param1:int) : void;
      
      function redeemExpiredOffer(param1:int) : void;
      
      function recallAllOffers() : void;
      
      function clearOwnHistory(param1:int) : void;
      
      function get ownOffersCategory() : int;
      
      function latestOffers() : Map;
      
      function latestOwnOffers() : Map;
      
      function totalItemsFound() : int;
      
      function set itemStats(param1:MarketplaceItemStats) : void;
      
      function get itemStats() : MarketplaceItemStats;
      
      function get creditsWaiting() : int;
      
      function get averagePricePeriod() : int;
      
      function set averagePricePeriod(param1:int) : void;
      
      function getNameLocalizationKey(param1:IMarketPlaceOfferData) : String;
      
      function getDescriptionLocalizationKey(param1:IMarketPlaceOfferData) : String;
      
      function isAccountSafetyLocked() : Boolean;
   }
}

