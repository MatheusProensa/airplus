package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class ClubExtendConfirmationDialog
   {
      private static const CREDIT_IMAGE_COUNT:int = 7;
      
      private static const YOUR_PRICE_ICON_BITMAP_ELEMENT_NAME:String = "your_price_icon_left";
      
      private static const UnknownConstFromClubExtendConfirmationDialog_String_1:String = "${image.library.catalogue.url}catalogue/vip_extend_tsr.png";
      
      private static const TEASER_IMAGE_MIME_TYPE:String = "image/png";
      
      private static const ANIMATION_TRIGGER_INTERVAL:int = 2000;
      
      private static const UnknownConstFromClubExtendConfirmationDialog_Int_1:int = 75;
      
      private static const LINK_COLOR_DEFAULT:uint = 0;
      
      private static const LINK_COLOR_HOVER:uint = 9552639;
      
      private var UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1:ClubExtendController;
      
      private var UnknownVarFromClubExtendConfirmationDialog_IFrameController_1:IFrameController;
      
      private var _offer:ClubOfferExtendData;
      
      private var UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _creditImages:Vector.<BitmapData>;
      
      private var UnknownVarFromClubExtendConfirmationDialog_Timer_1:Timer;
      
      private var UnknownVarFromClubExtendConfirmationDialog_Timer_2:Timer;
      
      private var _animationFrame:int = 0;
      
      private var UnknownVarFromClubExtendConfirmationDialog_Int_1:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var _localizationKey:String = "catalog.club.extend.";
      
      public function ClubExtendConfirmationDialog(param1:ClubExtendController, param2:ClubOfferExtendData)
      {
         super();
         UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1 = param1;
         _offer = param2;
         _creditImages = new Vector.<BitmapData>(7);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_disposed)
         {
            return;
         }
         _offer = null;
         UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1 = null;
         clearAnimation();
         if(UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1.removeEventListener("WME_OUT",onMouseOutLaterRegion);
            UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1.removeEventListener("WME_OVER",onMouseOverLaterRegion);
            UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1 = null;
         }
         if(UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1 = null;
         }
         if(UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1 = null;
         }
         if(_creditImages)
         {
            while(_loc1_ < 7)
            {
               _creditImages[_loc1_].dispose();
               _creditImages[_loc1_] = null;
               _loc1_++;
            }
            _creditImages = null;
         }
         if(UnknownVarFromClubExtendConfirmationDialog_IFrameController_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.dispose();
            UnknownVarFromClubExtendConfirmationDialog_IFrameController_1 = null;
         }
         _disposed = true;
      }
      
      public function showConfirmation() : void
      {
         var _loc10_:IIconWindow = null;
         var _loc11_:String = null;
         var _loc8_:int = 0;
         var _loc6_:BitmapDataAsset = null;
         var _loc12_:BitmapData = null;
         if(!_offer || !UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1 || _disposed)
         {
            return;
         }
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1 = createWindow("club_extend_confirmation") as IFrameController;
         if(!UnknownVarFromClubExtendConfirmationDialog_IFrameController_1)
         {
            return;
         }
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.procedure = windowEventHandler;
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.center();
         if(!_offer.vip)
         {
            _localizationKey += "basic.";
            _loc10_ = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("club_level_icon") as IIconWindow;
            if(_loc10_)
            {
               _loc10_.style = 17;
               _loc10_.x += 15;
            }
         }
         var _loc3_:IHabboLocalizationManager = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.localization;
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("normal_price_price_left").caption = _offer.originalPrice.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("normal_price_price_right").caption = _offer.originalActivityPointPrice.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("you_save_price_left").caption = _offer.discountCreditAmount.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("you_save_price_right").caption = _offer.discountActivityPointAmount.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("your_price_price_left").caption = _offer.priceCredits.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("your_price_price_right").caption = _offer.priceActivityPoints.toString();
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.title.caption = _loc3_.getLocalization(_localizationKey + "confirm.caption");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("extend_title").caption = _loc3_.getLocalization(_localizationKey + "confirm.title");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("normal_price_label").caption = _loc3_.getLocalization(_localizationKey + "normal.label");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("you_save_label").caption = _loc3_.getLocalization(_localizationKey + "save.label");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("your_price_label").caption = _loc3_.getLocalization(_localizationKey + "price.label");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("buy_now_button").caption = _loc3_.getLocalization(_localizationKey + "buy.button");
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("maybe_later_link").caption = _loc3_.getLocalization(_localizationKey + "later.link");
         if(_offer.subscriptionDaysLeft > 1)
         {
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","day",_offer.subscriptionDaysLeft.toString());
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","duration",(31 * _offer.months).toString());
            _loc11_ = _loc3_.getLocalization(_localizationKey + "expiration_days_left");
         }
         else
         {
            _loc11_ = _loc3_.getLocalization(_localizationKey + "expires_today");
         }
         UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("offer_expiration").caption = _loc11_;
         UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1 = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("maybe_later_region") as IRegionWindow;
         UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1 = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("maybe_later_link") as ITextWindow;
         if(!UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1 || !UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1)
         {
            return;
         }
         UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1.addEventListener("WME_OUT",onMouseOutLaterRegion);
         UnknownVarFromClubExtendConfirmationDialog_IRegionWindow_1.addEventListener("WME_OVER",onMouseOverLaterRegion);
         var _loc5_:BitmapData = getBitmapDataFromAsset("icon_credit_0");
         setElementBitmapData("normal_price_icon_left",_loc5_);
         setElementBitmapData("you_save_icon_left",_loc5_);
         setActivityPointIconStyle("normal_price_icon_right");
         setActivityPointIconStyle("you_save_icon_right");
         setActivityPointIconStyle("your_price_icon_right");
         var _loc1_:IBitmapWrapperController = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("club_teaser") as IBitmapWrapperController;
         _loc1_.x = 1;
         _loc1_.y = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.height - 144;
         _loc1_.height = 144;
         _loc1_.width = 133;
         var _loc7_:String = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.config.interpolate("${image.library.catalogue.url}catalogue/vip_extend_tsr.png");
         if(UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.config)
         {
            _loc7_ = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.config.updateUrlProtocol(_loc7_);
         }
         loadAssetFromUrl("club_teaser","club_teaser",_loc7_,"image/png",onTeaserLoaded);
         var _loc9_:IItemListWindow = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("itemlist_vertical") as IItemListWindow;
         if(!_loc9_)
         {
            return;
         }
         var _loc4_:IWindowController_1 = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("total_amount_line") as IWindowController_1;
         if(!_loc4_)
         {
            return;
         }
         var _loc2_:IWindowController_1 = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("background_container") as IWindowController_1;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.height = _loc9_.y + _loc4_.height + _loc4_.y;
         UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1 = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName("your_price_icon_left") as IBitmapWrapperController;
         if(UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1 == null)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc6_ = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.assets.getAssetByName("icon_credit_" + _loc8_) as BitmapDataAsset;
            _loc12_ = _loc6_.content as BitmapData;
            _creditImages[_loc8_] = _loc12_.clone();
            _loc8_++;
         }
         startAnimation();
      }
      
      private function setActivityPointIconStyle(param1:String) : void
      {
         var _loc2_:IWindowModel = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName(param1);
         _loc2_.style = ActivityPointTypeEnum.getIconStyleFor(_offer.originalActivityPointType,UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.config,true);
      }
      
      private function onMouseOutLaterRegion(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1.textColor = 0;
         }
      }
      
      private function onMouseOverLaterRegion(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_ITextWindow_1.textColor = 9552639;
         }
      }
      
      private function startAnimation() : void
      {
         if(UnknownVarFromClubExtendConfirmationDialog_Timer_1)
         {
            clearAnimation();
         }
         setAnimationFrame();
         UnknownVarFromClubExtendConfirmationDialog_Timer_1 = new Timer(2000);
         UnknownVarFromClubExtendConfirmationDialog_Timer_1.addEventListener("timer",onAnimationTrigger);
         UnknownVarFromClubExtendConfirmationDialog_Timer_1.start();
      }
      
      private function clearAnimation() : void
      {
         _animationFrame = 0;
         UnknownVarFromClubExtendConfirmationDialog_Int_1 = 0;
         if(UnknownVarFromClubExtendConfirmationDialog_Timer_2)
         {
            UnknownVarFromClubExtendConfirmationDialog_Timer_2.stop();
            UnknownVarFromClubExtendConfirmationDialog_Timer_2 = null;
         }
         if(UnknownVarFromClubExtendConfirmationDialog_Timer_1)
         {
            UnknownVarFromClubExtendConfirmationDialog_Timer_1.stop();
            UnknownVarFromClubExtendConfirmationDialog_Timer_1 = null;
         }
      }
      
      private function setAnimationFrame() : void
      {
         if(!UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1)
         {
            return;
         }
         if(UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.bitmap)
         {
            UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.bitmap.dispose();
         }
         if(_animationFrame < 7)
         {
            UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.width,UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.height,true,0);
            UnknownVarFromClubExtendConfirmationDialog_IBitmapWrapperController_1.bitmap.copyPixels(_creditImages[_animationFrame],_creditImages[_animationFrame].rect,new Point(0,0));
         }
         else
         {
            Logger.log("Animation frame " + _animationFrame);
         }
      }
      
      private function startAnimationFrame() : void
      {
         UnknownVarFromClubExtendConfirmationDialog_Timer_2 = new Timer(75,7 - 1);
         UnknownVarFromClubExtendConfirmationDialog_Timer_2.addEventListener("timer",onAnimationFrame);
         UnknownVarFromClubExtendConfirmationDialog_Timer_2.addEventListener("timerComplete",onAnimationFrameComplete);
         UnknownVarFromClubExtendConfirmationDialog_Timer_2.start();
      }
      
      private function onAnimationTrigger(param1:TimerEvent) : void
      {
         startAnimationFrame();
      }
      
      private function onAnimationFrame(param1:TimerEvent) : void
      {
         _animationFrame += 1;
         setAnimationFrame();
      }
      
      private function onAnimationFrameComplete(param1:TimerEvent) : void
      {
         if(UnknownVarFromClubExtendConfirmationDialog_Timer_2)
         {
            UnknownVarFromClubExtendConfirmationDialog_Timer_2.stop();
            UnknownVarFromClubExtendConfirmationDialog_Timer_2 = null;
         }
         _animationFrame = 0;
         setAnimationFrame();
         if(UnknownVarFromClubExtendConfirmationDialog_Int_1 == 0)
         {
            UnknownVarFromClubExtendConfirmationDialog_Int_1 = 1;
            startAnimationFrame();
         }
         else
         {
            UnknownVarFromClubExtendConfirmationDialog_Int_1 = 0;
         }
      }
      
      private function getBitmapDataFromAsset(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function setElementBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperController = UnknownVarFromClubExtendConfirmationDialog_IFrameController_1.findChildByName(param1) as IBitmapWrapperController;
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
         }
         if(param2 != null && _loc3_ != null)
         {
            if(_loc3_.width != param2.width)
            {
               _loc3_.width = param2.width;
            }
            if(_loc3_.height != param2.height)
            {
               _loc3_.height = param2.height;
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function loadAssetFromUrl(param1:String, param2:String, param3:String, param4:String, param5:Function) : Boolean
      {
         var _loc8_:BitmapData = getBitmapDataFromAsset(param2);
         if(_loc8_ != null)
         {
            setElementBitmapData(param1,_loc8_);
            return true;
         }
         var _loc6_:URLRequest = new URLRequest(param3);
         var _loc7_:AssetLoaderStruct = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.assets.loadAssetFromFile(param2,_loc6_,param4);
         if(!_loc7_)
         {
            return false;
         }
         _loc7_.addEventListener("AssetLoaderEventComplete",param5);
         return true;
      }
      
      private function onTeaserLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:BitmapData = null;
         if(!_disposed)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               _loc3_ = getBitmapDataFromAsset(_loc2_.assetName);
               setElementBitmapData("club_teaser",_loc3_);
            }
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!param1 || !param2 || !UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1 || !_offer || _disposed)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "buy_now_button":
               UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.confirmSelection();
               break;
            case "header_button_close":
            case "maybe_later_region":
               UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindowModel
      {
         if(!UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1 || !UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.assets || !UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.windowManager || _disposed)
         {
            return null;
         }
         var _loc3_:XmlAsset = UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return UnknownVarFromClubExtendConfirmationDialog_ClubExtendController_1.windowManager.buildFromXML(_loc2_);
      }
   }
}

