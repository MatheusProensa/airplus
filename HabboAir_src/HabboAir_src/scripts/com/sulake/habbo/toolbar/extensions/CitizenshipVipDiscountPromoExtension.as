package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CitizenshipVipDiscountPromoExtension
   {
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var _expanded:Boolean = true;
      
      private var UnknownVarFromCitizenshipVipDiscountPromoExtension_Int_1:int = 216;
      
      private var UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1:Timer;
      
      public function CitizenshipVipDiscountPromoExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      private function createWindow() : UnknownICoreWindowComponents6
      {
         var _loc1_:UnknownICoreWindowComponents6 = null;
         var _loc2_:ISoundAsset = _toolbar.assets.getAssetByName("vip_discount_promotion_v2_xml");
         if(_loc2_)
         {
            _loc1_ = _toolbar.windowManager.buildFromXML(_loc2_.content as XML,1) as UnknownICoreWindowComponents6;
            if(_loc1_)
            {
               UnknownICoreWindowComponents4(_loc1_.findChildByName("extend_button").addEventListener("WME_CLICK",onButtonClicked));
               IRegionWindow(_loc1_.findChildByName("minimize_region")).addEventListener("WME_CLICK",onMinMax);
               IRegionWindow(_loc1_.findChildByName("maximize_region")).addEventListener("WME_CLICK",onMinMax);
               UnknownVarFromCitizenshipVipDiscountPromoExtension_Int_1 = _loc1_.height;
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1)
         {
            UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1.dispose();
            UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1 = null;
         }
         destroyExpirationTimer();
      }
      
      private function get extensionView() : IExtensionView
      {
         return _toolbar.extensionView;
      }
      
      public function dispose() : void
      {
         if(_toolbar == null)
         {
            return;
         }
         if(extensionView != null)
         {
            extensionView.detachExtension("club_promo");
         }
         destroyWindow();
         _toolbar = null;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_toolbar.inventory.clubLevel == 2)
         {
            _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo","citizenshipdiscount","client.club.extend.discount.clicked"));
            _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
         }
      }
      
      private function assignState() : void
      {
         UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1.findChildByName("content_itemlist").visible = _expanded;
         UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1.findChildByName("promo_img").visible = _expanded;
         UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1.height = _expanded ? UnknownVarFromCitizenshipVipDiscountPromoExtension_Int_1 : 33;
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.citizenshipVipIsExpiring && UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1 == null && isExtensionEnabled())
         {
            UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1 = createWindow();
            if(UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1 != null)
            {
               destroyExpirationTimer();
            }
            if(_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0)
            {
               UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000,1);
               UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1.addEventListener("timerComplete",onExtendOfferExpire);
               UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1.start();
            }
            assignState();
            if(!_toolbar.extensionView.hasExtension("vip_quests"))
            {
               _toolbar.extensionView.attachExtension("club_promo",UnknownVarFromCitizenshipVipDiscountPromoExtension_UnknownICoreWindowComponents6_1,10);
            }
         }
         else
         {
            _toolbar.extensionView.detachExtension("vip_quests");
            destroyWindow();
         }
      }
      
      private function destroyExpirationTimer() : void
      {
         if(UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1)
         {
            UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1.stop();
            UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1.removeEventListener("timerComplete",onExtendOfferExpire);
            UnknownVarFromCitizenshipVipDiscountPromoExtension_Timer_1 = null;
         }
      }
      
      private function onExtendOfferExpire(param1:TimerEvent) : void
      {
         _toolbar.extensionView.detachExtension("club_promo");
         destroyWindow();
      }
      
      private function isExtensionEnabled() : Boolean
      {
         return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
      }
      
      private function onMinMax(param1:WindowMouseEvent) : void
      {
         _expanded = !_expanded;
         assignState();
      }
   }
}

