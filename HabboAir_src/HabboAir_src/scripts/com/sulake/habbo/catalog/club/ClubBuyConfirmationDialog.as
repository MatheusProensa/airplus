package com.sulake.habbo.catalog.club
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class ClubBuyConfirmationDialog
   {
      private var _offer:ClubBuyOfferData;
      
      private var UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1:ClubBuyController;
      
      private var UnknownVarFromClubBuyConfirmationDialog_IFrameController_1:IFrameController;
      
      private var UnknownVarFromClubBuyConfirmationDialog_Int_1:int;
      
      public function ClubBuyConfirmationDialog(param1:ClubBuyController, param2:ClubBuyOfferData, param3:int)
      {
         super();
         _offer = param2;
         UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1 = param1;
         UnknownVarFromClubBuyConfirmationDialog_Int_1 = param3;
         showConfirmation();
      }
      
      public function dispose() : void
      {
         UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1 = null;
         _offer = null;
         if(UnknownVarFromClubBuyConfirmationDialog_IFrameController_1)
         {
            UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.dispose();
            UnknownVarFromClubBuyConfirmationDialog_IFrameController_1 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1)
         {
            return;
         }
         UnknownVarFromClubBuyConfirmationDialog_IFrameController_1 = UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.catalog.utils.createWindow("club_buy_confirmation") as IFrameController;
         if(!UnknownVarFromClubBuyConfirmationDialog_IFrameController_1)
         {
            return;
         }
         UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.procedure = windowEventHandler;
         UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.center();
         if(UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.catalog.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         var _loc1_:IHabboLocalizationManager = UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.localization;
         var _loc4_:IPurse = UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.getPurse();
         var _loc5_:String = _loc4_.hasClubLeft && _loc4_.isVIP ? "extension." : "subscription.";
         var _loc3_:String = _offer.months == 0 ? "days" : "months";
         var _loc2_:String = "catalog.vip.buy.confirm." + _loc5_ + _loc3_;
         _loc1_.registerParameter(_loc2_,"num_" + _loc3_,String(_offer.months == 0 ? _offer.extraDays : _offer.months));
         UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.findChildByName("subscription_name").caption = _loc1_.getLocalization(_loc2_);
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","day",String(_offer.day));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","month",String(_offer.month));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","year",String(_offer.year));
         UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.catalog.utils.showPriceInContainer(UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.findChildByName("purchase_cost_box") as IWindowController_1,_offer);
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(UnknownVarFromClubBuyConfirmationDialog_IFrameController_1 == null)
         {
            return;
         }
         var _loc2_:IWindowModel = UnknownVarFromClubBuyConfirmationDialog_IFrameController_1.findChildByName("select_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!param1 || !param2 || !UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOUBLE_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "spending_disclaimer":
               setDisclaimerAccepted(UnknownICoreWindowComponents2(param2).isSelected);
               break;
            case "select_button":
               UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.catalog.doNotCloseAfterVipPurchase();
               UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.confirmSelection(_offer,UnknownVarFromClubBuyConfirmationDialog_Int_1);
               break;
            case "header_button_close":
            case "cancel_button":
               UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.catalog.forgetPageDuringVipPurchase();
               UnknownVarFromClubBuyConfirmationDialog_ClubBuyController_1.closeConfirmation();
         }
      }
   }
}

