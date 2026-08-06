package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class ClubExtendController
   {
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1:ClubExtendConfirmationDialog;
      
      private var _offer:ClubOfferExtendData;
      
      private var _disposed:Boolean = false;
      
      public function ClubExtendController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeConfirmation();
         _offer = null;
         _catalog = null;
         _disposed = true;
      }
      
      public function onOffer(param1:HabboClubExtendOfferMessageEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:HabboClubExtendOfferMessageParser = param1.getParser();
         _offer = _loc2_.offer();
         showConfirmation();
         if(_catalog.connection)
         {
            if(_offer.vip)
            {
               _catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","vip.membership.extension.purchase"));
            }
            else
            {
               _catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","basic.membership.extension.purchase"));
            }
         }
      }
      
      public function closeConfirmation() : void
      {
         if(UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1)
         {
            UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1.dispose();
            UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         closeConfirmation();
         UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1 = new ClubExtendConfirmationDialog(this,_offer);
         UnknownVarFromClubExtendController_ClubExtendConfirmationDialog_1.showConfirmation();
      }
      
      public function confirmSelection() : void
      {
         if(!_catalog || !_catalog.connection || !_offer)
         {
            return;
         }
         if(_catalog.getPurse().credits < _offer.priceCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_offer.vip)
         {
            _catalog.purchaseVipMembershipExtension(_offer.offerId);
         }
         else
         {
            _catalog.purchaseBasicMembershipExtension(_offer.offerId);
         }
         closeConfirmation();
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.localization;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.assets;
      }
      
      public function get config() : IComponent_1
      {
         return _catalog;
      }
   }
}

