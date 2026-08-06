package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferDialogView
   {
      private var UnknownVarFromMallOfferDialogView_OfferController_1:OfferController;
      
      private var _window:IWindowController_1;
      
      private var _offer:HabboMallOffer;
      
      public function MallOfferDialogView(param1:OfferController, param2:HabboMallOffer)
      {
         var _loc3_:String = null;
         super();
         UnknownVarFromMallOfferDialogView_OfferController_1 = param1;
         _offer = param2;
         _window = IWindowController_1(UnknownVarFromMallOfferDialogView_OfferController_1.catalog.windowManager.buildFromXML(XML(UnknownVarFromMallOfferDialogView_OfferController_1.catalog.assets.getAssetByName("targeted_offer_habbomall_xml").content)));
         IFrameController(_window).title.text = getLocalization(_offer.title);
         ITextWindow(_window.findChildByName("txt_title")).text = getLocalization(_offer.title);
         if(param2.imageUrl && param2.imageUrl.length > 0)
         {
            _loc3_ = (UnknownVarFromMallOfferDialogView_OfferController_1.catalog as IComponent_1).getProperty("image.library.url");
            IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration")).assetUri = _loc3_ + param2.imageUrl;
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!UnknownVarFromMallOfferDialogView_OfferController_1 || !_offer)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "header_button_close":
                  UnknownVarFromMallOfferDialogView_OfferController_1.onHabboMallOfferClosed(_offer);
                  break;
               case "btn_buy":
                  UnknownVarFromMallOfferDialogView_OfferController_1.onHabboMallOfferOpened(_offer);
            }
         }
      }
      
      private function getLocalization(param1:String, param2:String = null) : String
      {
         return UnknownVarFromMallOfferDialogView_OfferController_1.catalog.localization.getLocalization(param1,param2 || param1);
      }
   }
}

