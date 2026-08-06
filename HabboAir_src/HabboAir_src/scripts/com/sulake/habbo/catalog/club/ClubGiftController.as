package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class ClubGiftController
   {
      private var UnknownVarFromClubGiftController_ClubGiftWidget_1:ClubGiftWidget;
      
      private var _daysUntilNextGift:int;
      
      private var _giftsAvailable:int;
      
      private var _offers:Array;
      
      private var _giftData:Map;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1:ClubGiftConfirmationDialog;
      
      public function ClubGiftController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         if(UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1)
         {
            UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1.dispose();
            UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1 = null;
         }
      }
      
      public function set widget(param1:ClubGiftWidget) : void
      {
         UnknownVarFromClubGiftController_ClubGiftWidget_1 = param1;
         _catalog.connection.send(new GetClubGiftMessageComposer());
      }
      
      public function get daysUntilNextGift() : int
      {
         return _daysUntilNextGift;
      }
      
      public function get giftsAvailable() : int
      {
         return _giftsAvailable;
      }
      
      public function setInfo(param1:int, param2:int, param3:Array, param4:Map) : void
      {
         _daysUntilNextGift = param1;
         _giftsAvailable = param2;
         _offers = param3;
         _giftData = param4;
         if(UnknownVarFromClubGiftController_ClubGiftWidget_1)
         {
            UnknownVarFromClubGiftController_ClubGiftWidget_1.update();
         }
      }
      
      public function selectGift(param1:UnknownIHabboCatalog1) : void
      {
         closeConfirmation();
         UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1 = new ClubGiftConfirmationDialog(this,param1);
      }
      
      public function confirmSelection(param1:String) : void
      {
         if(!param1 || !_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new SelectClubGiftComposer(param1));
         _giftsAvailable--;
         UnknownVarFromClubGiftController_ClubGiftWidget_1.update();
         closeConfirmation();
      }
      
      public function closeConfirmation() : void
      {
         if(UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1)
         {
            UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1.dispose();
            UnknownVarFromClubGiftController_ClubGiftConfirmationDialog_1 = null;
         }
      }
      
      public function getOffers() : Array
      {
         return _offers;
      }
      
      public function getGiftData() : Map
      {
         return _giftData;
      }
      
      public function get hasClub() : Boolean
      {
         if(!_catalog || !_catalog.getPurse())
         {
            return false;
         }
         return _catalog.getPurse().clubDays > 0;
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
      
      public function get roomEngine() : IRoomEngine
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.roomEngine;
      }
      
      public function getProductData(param1:String) : IProductData
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getProductData(param1);
      }
      
      public function get purse() : IPurse
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getPurse();
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
   }
}

