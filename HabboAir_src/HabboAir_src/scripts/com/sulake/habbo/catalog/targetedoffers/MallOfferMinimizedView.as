package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferMinimizedView extends OfferView
   {
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
      
      private var UnknownVarFromMallOfferMinimizedView_HabboMallOffer_1:HabboMallOffer;
      
      public function MallOfferMinimizedView(param1:OfferController, param2:HabboMallOffer)
      {
         super(param1,null);
         UnknownVarFromMallOfferMinimizedView_HabboMallOffer_1 = param2;
         _window = IWindowController_1(UnknownVarFromOfferView_OfferController_1.catalog.windowManager.buildFromXML(XML(UnknownVarFromOfferView_OfferController_1.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc4_)
         {
            _loc4_.text = getLocalization(param2.title);
         }
         var _loc3_:String = (UnknownVarFromOfferView_OfferController_1.catalog as IComponent_1).getProperty("image.library.url");
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + "targetedoffers/offer_default_icon.png";
         _window.procedure = onInput;
         UnknownVarFromOfferView_OfferController_1.attachExtension(_window);
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!UnknownVarFromOfferView_OfferController_1)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            UnknownVarFromOfferView_OfferController_1.maximizeMallOffer(UnknownVarFromMallOfferMinimizedView_HabboMallOffer_1);
            param2.name;
         }
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
   }
}

