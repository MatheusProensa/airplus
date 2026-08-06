package com.sulake.habbo.catalog.club
{
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class VipBuyItem implements IComponentInterfaceQueue
   {
      private var _offer:ClubBuyOfferData;
      
      private var _window:IWindowController_1;
      
      private var _catalog:HabboCatalog;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromVipBuyItem_String_1:String;
      
      public function VipBuyItem(param1:ClubBuyOfferData, param2:HabboCatalog, param3:String)
      {
         var _loc4_:ILocalization = null;
         super();
         _offer = param1;
         _catalog = param2;
         UnknownVarFromVipBuyItem_String_1 = param3;
         _window = _catalog.utils.createWindow("vip_buy_item") as IWindowController_1;
         var _loc5_:IHabboLocalizationManager = _catalog.localization;
         if(param1.months > 0)
         {
            _loc5_.registerParameter("catalog.vip.item.header.months","num_months",String(param1.months));
            _loc4_ = _loc5_.getLocalizationRaw("catalog.vip.item.header.months");
         }
         else
         {
            _loc5_.registerParameter("catalog.vip.item.header.days","num_days",String(param1.extraDays));
            _loc4_ = _loc5_.getLocalizationRaw("catalog.vip.item.header.days");
         }
         _window.findChildByName("item_header").caption = _loc4_ != null ? _loc4_.value : "-";
         _catalog.utils.showPriceInContainer(_window.findChildByName("item_price") as IWindowController_1,_offer);
         _window.findChildByName("item_buy").addEventListener("WME_CLICK",onBuy);
         if(param1.giftable)
         {
            _window.findChildByName("item_gift").addEventListener("WME_CLICK",onGift);
         }
         else
         {
            _window.findChildByName("item_gift").visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _window.dispose();
            _window = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onBuy(param1:WindowMouseEvent) : void
      {
         _catalog.purchaseWillBeGift(false);
         _catalog.showPurchaseConfirmation(_offer,_offer.page?.pageId);
      }
      
      private function onGift(param1:WindowMouseEvent) : void
      {
         _catalog.purchaseWillBeGift(true);
         _catalog.showPurchaseConfirmation(_offer,_offer.page?.pageId);
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
   }
}

