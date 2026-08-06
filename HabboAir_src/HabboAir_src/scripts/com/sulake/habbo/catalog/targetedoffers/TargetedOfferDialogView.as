package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import flash.text.StyleSheet;
   
   public class TargetedOfferDialogView extends OfferView
   {
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default.png";
      
      private var UnknownVarFromTargetedOfferDialogView_Int_1:int = 1;
      
      public function TargetedOfferDialogView(param1:OfferController, param2:TargetedOffer)
      {
         super(param1,param2);
      }
      
      public function buildWindow(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(!UnknownVarFromOfferView_OfferController_1.catalog || !UnknownVarFromOfferView_OfferController_1.catalog.windowManager)
         {
            return;
         }
         _window = IWindowController_1(UnknownVarFromOfferView_OfferController_1.catalog.windowManager.buildFromXML(XML(UnknownVarFromOfferView_OfferController_1.catalog.assets.getAssetByName(param1).content)));
         if(IFrameController(_window))
         {
            IFrameController(_window).title.text = getLocalization(_offer.title);
         }
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(_offer.title);
         }
         _loc5_ = ITextWindow(_window.findChildByName("txt_description"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(_offer.description);
            setLinkStyle(_loc5_);
         }
         _loc5_ = ITextWindow(_window.findChildByName("txt_price_label"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization("targeted.offer.price.label");
         }
         var _loc6_:Map = UnknownVarFromOfferView_OfferController_1.catalog.utils.getPriceMap(_offer,UnknownVarFromTargetedOfferDialogView_Int_1);
         renderPrice(_window,_loc6_);
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration"));
         if(_loc3_)
         {
            _loc2_ = (UnknownVarFromOfferView_OfferController_1.catalog as IComponent_1).getProperty("image.library.url");
            _loc4_ = getPreviewImageOverride(_offer);
            if(_loc4_ == null || _loc4_.length == 0)
            {
               _loc4_ = _offer.imageUrl && _offer.imageUrl.length > 0 ? _offer.imageUrl : "targetedoffers/offer_default.png";
            }
            _loc3_.assetUri = _loc2_ + _loc4_;
         }
         UnknownVarFromOfferView_String_1 = getLocalization("targeted.offer.timeleft","");
         if(_offer.expirationTime == 0)
         {
            if(_window.findChildByName("cnt_time_left"))
            {
               _window.findChildByName("cnt_time_left").visible = false;
            }
         }
         else
         {
            startUpdateTimer();
         }
         var _loc7_:ITextFieldWindow = _window.findChildByName("quantity_input") as ITextFieldWindow;
         if(_loc7_)
         {
            _loc7_.addEventListener("WKE_KEY_UP",onQuantityInputEvent);
         }
         _window.procedure = onInput;
         _window.center();
         updatePriceText();
         updateButtonStates();
      }
      
      private function renderPrice(param1:IWindowController_1, param2:Map) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:* = param2.getValue("credit");
         param1.findChildByName("txt_price_credits").caption = _loc3_.amount;
         var _loc4_:* = param2.getValue("activityPoint");
         if(_loc4_ != null)
         {
            param1.findChildByName("txt_price_activityPoints").caption = _loc4_.amount;
            setActivityPointIconStyle("activityPoints_icon",param1,_loc4_.activityPointType);
         }
         else
         {
            param1.findChildByName("txt_price_activityPoints").caption = "0";
            setActivityPointIconStyle("activityPoints_icon",param1,5);
         }
      }
      
      private function setActivityPointIconStyle(param1:String, param2:IWindowController_1, param3:int) : void
      {
         var _loc4_:IWindowModel = param2.findChildByName(param1);
         _loc4_.style = ActivityPointTypeEnum.getIconStyleFor(param3,UnknownVarFromOfferView_OfferController_1.catalog,true);
      }
      
      override protected function setTimeLeft(param1:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
         if(!_loc3_)
         {
            return;
         }
         _loc3_.text = param1;
         if(!UnknownVarFromOfferView_String_1)
         {
            return;
         }
         var _loc4_:int = Math.max(UnknownVarFromOfferView_String_1.indexOf("%timeleft%"),0);
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left_label_1"));
         if(_loc2_)
         {
            _loc2_.text = UnknownVarFromOfferView_String_1.substr(0,_loc4_ - 1);
         }
         _loc2_ = ITextWindow(_window.findChildByName("txt_time_left_label_2"));
         if(_loc2_)
         {
            _loc2_.text = UnknownVarFromOfferView_String_1.substr(_loc4_ + 10,UnknownVarFromOfferView_String_1.length);
         }
      }
      
      public function updateButtonStates() : void
      {
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("txt_status"));
         if(!_loc4_)
         {
            return;
         }
         var _loc1_:Boolean = _offer.checkPurseBalance(UnknownVarFromOfferView_OfferController_1.catalog.getPurse(),UnknownVarFromTargetedOfferDialogView_Int_1);
         if(_loc1_)
         {
            _loc4_.text = "";
         }
         else if(_window.findChildByName("btn_buy"))
         {
            _window.findChildByName("btn_buy").disable();
         }
         if(_window.findChildByName("cnt_quantity"))
         {
            _window.findChildByName("cnt_quantity").visible = _offer.purchaseLimit > 1;
         }
         if(_window.findChildByName("btn_get_credits"))
         {
            _window.findChildByName("btn_get_credits").visible = !_loc1_;
         }
         var _loc2_:IWindowModel = _window.findChildByName("btn_buy");
         if(_loc2_)
         {
            if(_loc1_ && isQuantityValid())
            {
               _loc2_.enable();
            }
            else
            {
               _loc2_.disable();
            }
         }
         var _loc3_:IItemListWindow = IItemListWindow(_window.findChildByName("itemlist_buttonbar"));
         if(_loc3_)
         {
            _loc3_.arrangeListItems();
            _loc3_.arrangeListItems();
         }
      }
      
      private function updatePriceText() : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_price_credits"));
         if(_loc2_)
         {
            _loc2_.text = UnknownVarFromTargetedOfferDialogView_Int_1 * _offer.priceInCredits + "";
         }
         var _loc1_:ITextWindow = ITextWindow(_window.findChildByName("txt_price_activityPoints"));
         if(_loc1_)
         {
            _loc1_.text = UnknownVarFromTargetedOfferDialogView_Int_1 * _offer.priceInActivityPoints + "";
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
               case "header_button_close":
                  UnknownVarFromOfferView_OfferController_1.minimizeOffer(_offer);
                  break;
               case "btn_get_credits":
                  UnknownVarFromOfferView_OfferController_1.purchaseCredits(_offer);
                  break;
               case "btn_buy":
                  if(!isQuantityValid())
                  {
                     return;
                  }
                  UnknownVarFromOfferView_OfferController_1.showConfirmation(_offer,UnknownVarFromTargetedOfferDialogView_Int_1);
                  break;
            }
         }
      }
      
      private function isQuantityValid() : Boolean
      {
         return UnknownVarFromTargetedOfferDialogView_Int_1 >= 1 && UnknownVarFromTargetedOfferDialogView_Int_1 <= _offer.purchaseLimit;
      }
      
      private function onQuantityInputEvent(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:int = parseInt(param1.target.caption);
         if(_loc2_ == 0 && param1.target.caption != "" || _loc2_ > 999 || _loc2_ > _offer.purchaseLimit)
         {
            param1.target.caption = UnknownVarFromTargetedOfferDialogView_Int_1.toString();
            return;
         }
         UnknownVarFromTargetedOfferDialogView_Int_1 = _loc2_;
         updatePriceText();
         updateButtonStates();
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.textDecoration = "underline";
         _loc3_.setStyle("a:link",_loc2_);
         param1.styleSheet = _loc3_;
      }
      
      private function getPreviewImageOverride(param1:TargetedOffer) : String
      {
         return UnknownVarFromOfferView_OfferController_1.catalog.getProperty("targeted.offer.override.preview_image." + param1.id);
      }
   }
}

