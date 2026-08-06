package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IVideoOfferLauncher;
   import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class VideoOfferExtension implements IVideoOfferLauncher
   {
      private static const UnknownConstFromVideoOfferExtension_String_1:String = "video_offer";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private static const CLOSE_COLOR_NORMAL:uint = 6710886;
      
      private static const CLOSE_COLOR_OVER:uint = 13421772;
      
      private var _toolbar:HabboToolbar;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromVideoOfferExtension_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromVideoOfferExtension_IIconWindow_1:IIconWindow;
      
      private var UnknownVarFromVideoOfferExtension_Boolean_1:Boolean = false;
      
      public function VideoOfferExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !_window && isClubExtensionEnabled())
         {
            _toolbar.extensionView.detachExtension("video_offer");
            destroyWindow();
            return;
         }
         if(!UnknownVarFromVideoOfferExtension_Boolean_1 && !_window)
         {
            _toolbar.catalog.videoOffers.load(this);
         }
      }
      
      private function isClubExtensionEnabled() : Boolean
      {
         return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
      }
      
      public function offersAvailable(param1:int) : void
      {
         if(_toolbar == null)
         {
            return;
         }
         if(param1 <= 0 || UnknownVarFromVideoOfferExtension_Boolean_1 || _toolbar.inventory.clubIsExpiring && isClubExtensionEnabled())
         {
            if(_window)
            {
               destroyWindow();
            }
            return;
         }
         if(!_window)
         {
            _window = createWindow();
         }
      }
      
      private function createWindow() : IWindowController_1
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc5_:BitmapData = null;
         var _loc8_:IBitmapWrapperController = null;
         var _loc1_:IWindowController_1 = null;
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("video_offer_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            _loc1_ = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowController_1;
            if(_loc1_)
            {
               _loc2_ = _toolbar.localization.getLocalization("supersaverads.video.promo.offer","Watch a video and earn a credit!");
               _loc6_ = _loc1_.findChildByName("promo_text") as ITextWindow;
               _loc7_ = _loc1_.findChildByName("promo_text_shadow") as ITextWindow;
               if(_loc6_)
               {
                  _loc6_.text = _loc2_;
               }
               if(_loc7_)
               {
                  _loc7_.text = _loc2_;
               }
               _loc4_ = _toolbar.assets.getAssetByName("offer_icon_png") as BitmapDataAsset;
               if(_loc4_ != null)
               {
                  _loc5_ = _loc4_.content as BitmapData;
                  _loc8_ = _loc1_.findChildByName("promo_icon") as IBitmapWrapperController;
                  if(_loc5_ != null && _loc8_ != null)
                  {
                     _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc8_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
                  }
               }
               UnknownVarFromVideoOfferExtension_IRegionWindow_1 = _loc1_.findChildByName("text_region") as IRegionWindow;
               if(UnknownVarFromVideoOfferExtension_IRegionWindow_1)
               {
                  UnknownVarFromVideoOfferExtension_IRegionWindow_1.addEventListener("WME_CLICK",onTextRegionClicked);
                  UnknownVarFromVideoOfferExtension_IRegionWindow_1.addEventListener("WME_OVER",onTextRegionMouseOver);
                  UnknownVarFromVideoOfferExtension_IRegionWindow_1.addEventListener("WME_OUT",onTextRegionMouseOut);
               }
               UnknownVarFromVideoOfferExtension_IIconWindow_1 = _loc1_.findChildByName("promo_close_icon") as IIconWindow;
               if(UnknownVarFromVideoOfferExtension_IIconWindow_1)
               {
                  UnknownVarFromVideoOfferExtension_IIconWindow_1.addEventListener("WME_CLICK",onCloseClicked);
                  UnknownVarFromVideoOfferExtension_IIconWindow_1.addEventListener("WME_OVER",onCloseMouseOver);
                  UnknownVarFromVideoOfferExtension_IIconWindow_1.addEventListener("WME_OUT",onCloseMouseOut);
               }
               _toolbar.extensionView.attachExtension("video_offer",_loc1_,10);
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            if(UnknownVarFromVideoOfferExtension_IRegionWindow_1)
            {
               UnknownVarFromVideoOfferExtension_IRegionWindow_1.removeEventListener("WME_CLICK",onTextRegionClicked);
               UnknownVarFromVideoOfferExtension_IRegionWindow_1.removeEventListener("WME_OVER",onTextRegionMouseOver);
               UnknownVarFromVideoOfferExtension_IRegionWindow_1.removeEventListener("WME_OUT",onTextRegionMouseOut);
               UnknownVarFromVideoOfferExtension_IRegionWindow_1 = null;
            }
            if(UnknownVarFromVideoOfferExtension_IIconWindow_1)
            {
               UnknownVarFromVideoOfferExtension_IIconWindow_1.removeEventListener("WME_CLICK",onCloseClicked);
               UnknownVarFromVideoOfferExtension_IIconWindow_1.removeEventListener("WME_OVER",onCloseMouseOver);
               UnknownVarFromVideoOfferExtension_IIconWindow_1.removeEventListener("WME_OUT",onCloseMouseOut);
               UnknownVarFromVideoOfferExtension_IIconWindow_1 = null;
            }
            _window.dispose();
            _window = null;
         }
      }
      
      public function dispose() : void
      {
         if(_toolbar == null)
         {
            return;
         }
         _toolbar.extensionView.detachExtension("video_offer");
         destroyWindow();
         _toolbar = null;
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromVideoOfferExtension_Boolean_1 = true;
         destroyWindow();
         _toolbar.connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.close_clicked"));
      }
      
      private function onCloseMouseOver(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromVideoOfferExtension_IIconWindow_1)
         {
            UnknownVarFromVideoOfferExtension_IIconWindow_1.color = 13421772;
         }
      }
      
      private function onCloseMouseOut(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromVideoOfferExtension_IIconWindow_1)
         {
            UnknownVarFromVideoOfferExtension_IIconWindow_1.color = 6710886;
         }
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(!_toolbar.catalog.videoOffers.launch(VideoOfferTypeEnum.CREDIT))
         {
            destroyWindow();
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(_window)
         {
            _loc2_ = _window.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 12247545;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(_window)
         {
            _loc2_ = _window.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 16777215;
         }
      }
   }
}

