package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutFurniMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutStripItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetRentOrBuyoutOfferMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.FurniRentOrBuyoutOfferMessageParser;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class RentConfirmationWindow implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private static const MODE_INFOSTAND:int = 1;
      
      private static const MODE_INVENTORY:int = 2;
      
      private static const MODE_CATALOGUE:int = 3;
      
      private var _disposed:Boolean;
      
      private var _offerMessageEvent:FurniRentOrBuyoutOfferMessageEvent;
      
      private var _window:IWindowController_1;
      
      private var _isBuyout:Boolean;
      
      private var UnknownVarFromRentConfirmationWindow_Int_1:int = -1;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromRentConfirmationWindow_IFurnitureData_1:IFurnitureData;
      
      private var _mode:int;
      
      private var UnknownVarFromRentConfirmationWindow_Int_2:int = -1;
      
      private var UnknownVarFromRentConfirmationWindow_Int_3:int;
      
      public function RentConfirmationWindow(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _offerMessageEvent = new FurniRentOrBuyoutOfferMessageEvent(onFurniRentOrBuyoutOffer);
         _catalog.connection.addMessageEvent(_offerMessageEvent);
      }
      
      private function onFurniRentOrBuyoutOffer(param1:FurniRentOrBuyoutOfferMessageEvent) : void
      {
         var _loc3_:UnknownHabboRoom1 = null;
         if(UnknownVarFromRentConfirmationWindow_IFurnitureData_1 == null)
         {
            return;
         }
         var _loc2_:FurniRentOrBuyoutOfferMessageParser = param1.getParser();
         if(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.fullName != _loc2_.furniTypeName)
         {
            return;
         }
         _isBuyout = _loc2_.buyout;
         if(_catalog.getPurse().credits < _loc2_.priceInCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_catalog.getPurse().getActivityPointsForType(_loc2_.activityPointType) < _loc2_.priceInActivityPoints)
         {
            _catalog.showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
            return;
         }
         _window = _catalog.windowManager.buildFromXML(_catalog.assets.getAssetByName("rent_confirmation").content as XML) as IWindowController_1;
         if(_loc2_.priceInCredits > 0)
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInCredits.toString();
            IStaticBitmapWrapperWindow(_window.findChildByName("price_type")).assetUri = "toolbar_credit_icon_0";
         }
         else
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInActivityPoints.toString();
         }
         if(_isBuyout)
         {
            _window.caption = "${rent.confirmation.title.buyout}";
            _window.findChildByName("rental_description").visible = false;
            _window.findChildByName("ok_button").caption = "${catalog.purchase_confirmation.buy}";
         }
         _window.findChildByName("furni_name").caption = UnknownVarFromRentConfirmationWindow_IFurnitureData_1.localizedName;
         IItemListWindow(_window.findChildByName("content_list")).arrangeListItems();
         _window.center();
         _window.procedure = windowProcedure;
         switch(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.type)
         {
            case "s":
               _loc3_ = roomEngine.getFurnitureImage(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.id,new Vector3d(90,0,0),64,this);
               break;
            case "i":
               _loc3_ = roomEngine.getWallItemImage(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.id,new Vector3d(90,0,0),64,this);
         }
         IBitmapWrapperController(_window.findChildByName("image")).bitmap = _loc3_.data;
         UnknownVarFromRentConfirmationWindow_Int_1 = _loc3_.id;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         close();
         if(_offerMessageEvent != null)
         {
            _catalog.connection.removeMessageEvent(_offerMessageEvent);
            _offerMessageEvent = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show(param1:IFurnitureData, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         close();
         UnknownVarFromRentConfirmationWindow_IFurnitureData_1 = param1;
         UnknownVarFromRentConfirmationWindow_Int_2 = param3;
         UnknownVarFromRentConfirmationWindow_Int_3 = param4;
         if(param5)
         {
            _mode = 3;
         }
         else if(UnknownVarFromRentConfirmationWindow_Int_2 > -1)
         {
            _mode = 1;
         }
         else
         {
            _mode = 2;
         }
         var _loc6_:* = param1.type == "i";
         _catalog.connection.send(new GetRentOrBuyoutOfferMessageComposer(_loc6_,param1.fullName,param2));
      }
      
      private function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK" || _window == null)
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
            case "header_button_close":
               close();
               break;
            case "ok_button":
               switch(_mode - 1)
               {
                  case 0:
                     _catalog.connection.send(new ExtendRentOrBuyoutFurniMessageComposer(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.type == "i",UnknownVarFromRentConfirmationWindow_Int_2,_isBuyout));
                     break;
                  case 1:
                     _catalog.connection.send(new ExtendRentOrBuyoutStripItemMessageComposer(UnknownVarFromRentConfirmationWindow_Int_3,_isBuyout));
                     break;
                  case 2:
                     _catalog.purchaseOffer(UnknownVarFromRentConfirmationWindow_IFurnitureData_1.rentOfferId);
               }
               close();
         }
      }
      
      private function close() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
         UnknownVarFromRentConfirmationWindow_Int_1 = -1;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(_window != null && param1 == UnknownVarFromRentConfirmationWindow_Int_1)
         {
            IBitmapWrapperController(_window.findChildByName("image")).bitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

