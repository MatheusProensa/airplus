package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferPurchaseConfirmationView extends OfferView
   {
      private var UnknownVarFromTargetedOfferPurchaseConfirmationView_Int_1:int;
      
      public function TargetedOfferPurchaseConfirmationView(param1:OfferController, param2:TargetedOffer, param3:int)
      {
         super(param1,param2);
         UnknownVarFromTargetedOfferPurchaseConfirmationView_Int_1 = param3;
         _window = IWindowController_1(UnknownVarFromOfferView_OfferController_1.catalog.windowManager.buildFromXML(XML(UnknownVarFromOfferView_OfferController_1.catalog.assets.getAssetByName("targeted_offer_purchase_confirmation_xml").content)));
         var _loc4_:HabboCatalog = UnknownVarFromOfferView_OfferController_1.catalog as HabboCatalog;
         if(_loc4_.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            _window.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         ITextWindow(_window.findChildByName("product_name")).text = getLocalization(param2.title);
         var _loc5_:IWindowController_1 = _window.findChildByName("purchase_cost_box") as IWindowController_1;
         _loc4_.utils.showPriceInContainer(_loc5_,param2,param3);
         var _loc6_:ITextWindow = _window.findChildByName("quantity") as ITextWindow;
         if(_loc6_ != null)
         {
            if(param1.catalog.multiplePurchaseEnabled && UnknownVarFromTargetedOfferPurchaseConfirmationView_Int_1 > 1)
            {
               _loc6_.text = "X " + UnknownVarFromTargetedOfferPurchaseConfirmationView_Int_1;
            }
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("select_button");
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
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!UnknownVarFromOfferView_OfferController_1)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "spending_disclaimer":
                  setDisclaimerAccepted(UnknownICoreWindowComponents2(param2).isSelected);
                  break;
               case "header_button_close":
               case "cancel_button":
                  UnknownVarFromOfferView_OfferController_1.maximizeOffer(_offer);
                  break;
               case "buy_button":
                  UnknownVarFromOfferView_OfferController_1.purchaseTargetedOffer(_offer,UnknownVarFromTargetedOfferPurchaseConfirmationView_Int_1);
            }
         }
      }
   }
}

