package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.SeasonalCalendarDailyOfferMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSeasonalCalendarDailyComposer;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.session.product.UnknownIHabboSessionProduct1;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CatalogPromo implements IComponentInterfaceQueue, UnknownIHabboRoom1, UnknownIHabboSessionProduct1
   {
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCatalogPromo_IConnection_1:IConnection;
      
      private var UnknownVarFromCatalogPromo_MainWindow_1:MainWindow;
      
      private var UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1:CatalogPageMessageProductData = null;
      
      private var _offerId:int = -1;
      
      private var UnknownVarFromCatalogPromo_Int_1:int = -1;
      
      private var UnknownVarFromCatalogPromo_SeasonalCalendarDailyOfferMessageEvent_1:SeasonalCalendarDailyOfferMessageEvent = null;
      
      private var UnknownVarFromCatalogPromo_IMessageEvent_1:IMessageEvent = null;
      
      private var UnknownVarFromCatalogPromo_IMessageEvent_2:IMessageEvent = null;
      
      public function CatalogPromo(param1:HabboQuestEngine, param2:MainWindow)
      {
         super();
         _questEngine = param1;
         UnknownVarFromCatalogPromo_MainWindow_1 = param2;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromCatalogPromo_IConnection_1)
         {
            if(UnknownVarFromCatalogPromo_IMessageEvent_1)
            {
               UnknownVarFromCatalogPromo_IConnection_1.removeMessageEvent(UnknownVarFromCatalogPromo_IMessageEvent_1);
               UnknownVarFromCatalogPromo_IMessageEvent_1 = null;
            }
            if(UnknownVarFromCatalogPromo_IMessageEvent_2)
            {
               UnknownVarFromCatalogPromo_IConnection_1.removeMessageEvent(UnknownVarFromCatalogPromo_IMessageEvent_2);
               UnknownVarFromCatalogPromo_IMessageEvent_2 = null;
            }
            UnknownVarFromCatalogPromo_IConnection_1 = null;
         }
         _questEngine = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(param1 == getActivityPointType())
         {
            _questEngine.localization.registerParameter("quests.seasonalcalendar.promo.balance","amount","" + param2);
            if(_window != null)
            {
               refresh();
            }
         }
      }
      
      private function getActivityPointType() : int
      {
         var _loc1_:String = _questEngine.configuration.getProperty("seasonalQuestCalendar.currency");
         return isNaN(Number(_loc1_)) ? 0 : int(_loc1_);
      }
      
      public function prepare(param1:IFrameController) : void
      {
         _window = IWindowController_1(param1.findChildByName("catalog_promo_cont"));
         _window.findChildByName("buy_button").disable();
         _window.findChildByName("buy_button").procedure = onBuyButton;
         UnknownVarFromCatalogPromo_IConnection_1 = _questEngine.communication.connection;
         if(UnknownVarFromCatalogPromo_IConnection_1 != null)
         {
            UnknownVarFromCatalogPromo_IMessageEvent_1 = new SeasonalCalendarDailyOfferMessageEvent(onDailyOfferMessage);
            UnknownVarFromCatalogPromo_IMessageEvent_2 = new CatalogPublishedMessageEvent(onCatalogPublished);
            UnknownVarFromCatalogPromo_IConnection_1.addMessageEvent(UnknownVarFromCatalogPromo_IMessageEvent_1);
            UnknownVarFromCatalogPromo_IConnection_1.addMessageEvent(UnknownVarFromCatalogPromo_IMessageEvent_2);
            UnknownVarFromCatalogPromo_IConnection_1.send(new GetSeasonalCalendarDailyComposer());
         }
      }
      
      public function refresh() : void
      {
         var _loc5_:String = null;
         var _loc2_:UnknownHabboRoom1 = null;
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("your_balance_txt"));
         var _loc1_:IWindowController_1 = IWindowController_1(_window.findChildByName("currency_icon_cont"));
         _loc1_.x = _loc4_.x + _loc4_.width;
         Util.hideChildren(_loc1_);
         var _loc3_:IWindowModel = _loc1_.findChildByName("currency_icon_" + getActivityPointType());
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         if(UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1 != null)
         {
            _loc5_ = null;
            _loc2_ = null;
            if(UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1.productType == "i")
            {
               _loc2_ = _questEngine.roomEngine.getWallItemImage(UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1.furniClassId,new Vector3d(90,0,0),64,this,0,UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1.extraParam);
            }
            else if(UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1.productType == "s")
            {
               _loc2_ = _questEngine.roomEngine.getFurnitureImage(UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1.furniClassId,new Vector3d(90,0,0),64,this);
            }
            if(_loc2_ != null && _loc2_.data != null)
            {
               setPromoFurniImage(_loc2_.data);
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setPromoFurniImage(param2);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBuyButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            Logger.log("Buy button clicked");
            if(_offerId != -1)
            {
               _questEngine.catalog.openCatalogPageById(UnknownVarFromCatalogPromo_Int_1,_offerId,"NORMAL");
            }
         }
      }
      
      private function onDailyOfferMessage(param1:SeasonalCalendarDailyOfferMessageEvent) : void
      {
         _window.findChildByName("buy_button").enable();
         var _loc2_:IProductData = _questEngine.sessionDataManager.getProductData(param1.offer.localizationId);
         if(_loc2_ != null)
         {
            ITextWindow(_window.findChildByName("promo_info")).text = _loc2_.name;
            UnknownVarFromCatalogPromo_Int_1 = param1.pageId;
            _offerId = param1.offer.offerId;
            if(param1.offer.products.length > 0)
            {
               UnknownVarFromCatalogPromo_CatalogPageMessageProductData_1 = CatalogPageMessageProductData(param1.offer.products[0]);
               refresh();
            }
         }
         else if(UnknownVarFromCatalogPromo_SeasonalCalendarDailyOfferMessageEvent_1 == null)
         {
            UnknownVarFromCatalogPromo_SeasonalCalendarDailyOfferMessageEvent_1 = param1;
            _questEngine.sessionDataManager.addProductsReadyEventListener(this);
         }
      }
      
      public function productDataReady() : void
      {
         onDailyOfferMessage(UnknownVarFromCatalogPromo_SeasonalCalendarDailyOfferMessageEvent_1);
      }
      
      private function setPromoFurniImage(param1:BitmapData) : void
      {
         var _loc5_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName("furni_preview"));
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:Rectangle = param1.rect;
         if(_loc3_.width > _loc2_.rect.width)
         {
            _loc3_.x = (_loc3_.width - _loc2_.rect.width) / 2;
            _loc3_.width = _loc2_.rect.width;
         }
         if(_loc3_.height > _loc2_.rect.height)
         {
            _loc3_.y = (_loc3_.height - _loc2_.rect.height) / 2;
            _loc3_.height = _loc2_.rect.height;
         }
         var _loc4_:Point = new Point(0,0);
         if(_loc2_.rect.width > _loc3_.width)
         {
            _loc4_.x = (_loc2_.rect.width - _loc3_.width) / 2;
         }
         if(_loc2_.rect.height > _loc3_.height)
         {
            _loc4_.y = (_loc2_.rect.height - _loc3_.height) / 2;
         }
         _loc2_.copyPixels(param1,_loc3_,_loc4_);
         _loc5_.bitmap = _loc2_;
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         if(UnknownVarFromCatalogPromo_IConnection_1 != null)
         {
            UnknownVarFromCatalogPromo_IConnection_1.send(new GetSeasonalCalendarDailyComposer());
         }
      }
   }
}

