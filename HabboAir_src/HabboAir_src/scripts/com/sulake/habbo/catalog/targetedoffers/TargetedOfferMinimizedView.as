package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferMinimizedView extends OfferView
   {
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
      
      public function TargetedOfferMinimizedView(param1:OfferController, param2:TargetedOffer)
      {
         var _loc6_:IItemListWindow = null;
         super(param1,param2);
         _window = IWindowController_1(UnknownVarFromOfferView_OfferController_1.catalog.windowManager.buildFromXML(XML(UnknownVarFromOfferView_OfferController_1.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc5_:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
         if(_loc5_)
         {
            _loc5_.text = getLocalization(param2.title);
         }
         var _loc3_:String = (UnknownVarFromOfferView_OfferController_1.catalog as IComponent_1).getProperty("image.library.url");
         var _loc4_:String = param2.iconImageUrl && param2.iconImageUrl.length > 0 ? param2.iconImageUrl : "targetedoffers/offer_default_icon.png";
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + _loc4_;
         UnknownVarFromOfferView_String_1 = getLocalization("targeted.offer.minimized.timeleft","");
         if(_offer.expirationTime == 0)
         {
            _loc6_ = _window.findChildByName("itemlist") as IItemListWindow;
            if(_loc6_)
            {
               _loc6_.removeListItem(_window.findChildByName("cnt_time_left"));
            }
         }
         else
         {
            startUpdateTimer();
         }
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
            UnknownVarFromOfferView_OfferController_1.maximizeOffer(_offer);
            param2.name;
         }
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
   }
}

