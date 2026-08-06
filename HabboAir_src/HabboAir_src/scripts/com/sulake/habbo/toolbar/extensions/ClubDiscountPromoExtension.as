package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ClubDiscountPromoExtension
   {
      private static const UnknownConstFromClubDiscountPromoExtension_String_1:String = "club_promo";
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromClubDiscountPromoExtension_Timer_1:Timer;
      
      private var UnknownVarFromClubDiscountPromoExtension_Int_1:int = 0;
      
      private var _animBlockMoveAmount:int;
      
      private var UnknownVarFromClubDiscountPromoExtension_Timer_2:Timer;
      
      private var UnknownVarFromClubDiscountPromoExtension_BitmapData_1:BitmapData;
      
      private var UnknownVarFromClubDiscountPromoExtension_Timer_3:Timer;
      
      public function ClubDiscountPromoExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      private function createWindow() : IWindowController_1
      {
         var _loc4_:ISoundAsset = null;
         var _loc2_:IRegionWindow = null;
         var _loc1_:IWindowController_1 = null;
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("club_discount_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            _loc1_ = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowController_1;
            if(_loc1_)
            {
               UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1 = _loc1_.findChildByName("flashing_animation") as IBitmapWrapperController;
               if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1)
               {
                  _loc4_ = _toolbar.assets.getAssetByName("extend_hilite_png") as ISoundAsset;
                  if(_loc4_)
                  {
                     UnknownVarFromClubDiscountPromoExtension_BitmapData_1 = _loc4_.content as BitmapData;
                     if(UnknownVarFromClubDiscountPromoExtension_BitmapData_1)
                     {
                        UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap = UnknownVarFromClubDiscountPromoExtension_BitmapData_1.clone();
                     }
                  }
                  UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.visible = false;
               }
               _loc2_ = _loc1_.findChildByName("text_region") as IRegionWindow;
               if(_loc2_)
               {
                  _loc2_.addEventListener("WME_CLICK",onTextRegionClicked);
                  _loc2_.addEventListener("WME_OVER",onTextRegionMouseOver);
                  _loc2_.addEventListener("WME_OUT",onTextRegionMouseOut);
               }
               assignState();
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1)
         {
            UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.dispose();
            UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1 = null;
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1 = null;
         }
         animate(false);
         destroyExpirationTimer();
      }
      
      public function dispose() : void
      {
         if(_disposed || !_toolbar)
         {
            return;
         }
         if(_toolbar.extensionView)
         {
            _toolbar.extensionView.detachExtension("club_promo");
         }
         clearAnimation();
         destroyWindow();
         _toolbar = null;
         _disposed = true;
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(_toolbar.inventory.clubLevel == 2)
         {
            _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo","discount","client.club.extend.discount.clicked"));
            _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
         }
      }
      
      private function assignState() : void
      {
         switch(_toolbar.inventory.clubLevel)
         {
            case 0:
               setText("${discount.bar.no.club.promo}");
               setClubIcon(14);
               break;
            case 2:
               setText("${discount.bar.vip.expiring}");
               setClubIcon(14);
         }
         animate(true);
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1 && isExtensionEnabled())
         {
            UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1 = createWindow();
            if(UnknownVarFromClubDiscountPromoExtension_Timer_3 != null)
            {
               destroyExpirationTimer();
            }
            if(_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0)
            {
               UnknownVarFromClubDiscountPromoExtension_Timer_3 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000,1);
               UnknownVarFromClubDiscountPromoExtension_Timer_3.addEventListener("timerComplete",onExtendOfferExpire);
               UnknownVarFromClubDiscountPromoExtension_Timer_3.start();
            }
            assignState();
            _toolbar.extensionView.attachExtension("club_promo",UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1,10);
         }
         else
         {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
         }
      }
      
      private function destroyExpirationTimer() : void
      {
         if(UnknownVarFromClubDiscountPromoExtension_Timer_3)
         {
            UnknownVarFromClubDiscountPromoExtension_Timer_3.stop();
            UnknownVarFromClubDiscountPromoExtension_Timer_3.removeEventListener("timerComplete",onExtendOfferExpire);
            UnknownVarFromClubDiscountPromoExtension_Timer_3 = null;
         }
      }
      
      private function onExtendOfferExpire(param1:TimerEvent) : void
      {
         _toolbar.extensionView.detachExtension("club_promo");
         destroyWindow();
      }
      
      private function isExtensionEnabled() : Boolean
      {
         if(_toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            return true;
         }
         return false;
      }
      
      private function setText(param1:String) : void
      {
         var _loc2_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         if(UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1)
         {
            _loc2_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.findChildByName("promo_text") as ITextWindow;
            _loc3_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.findChildByName("promo_text_shadow") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = param1;
            }
            if(_loc3_)
            {
               _loc3_.text = param1;
            }
         }
      }
      
      private function animate(param1:Boolean) : void
      {
         if(param1)
         {
            Logger.log("Animate window");
            if(UnknownVarFromClubDiscountPromoExtension_Timer_2)
            {
               UnknownVarFromClubDiscountPromoExtension_Timer_2.stop();
            }
            UnknownVarFromClubDiscountPromoExtension_Timer_2 = new Timer(15000);
            UnknownVarFromClubDiscountPromoExtension_Timer_2.addEventListener("timer",onTriggerTimer);
            UnknownVarFromClubDiscountPromoExtension_Timer_2.start();
         }
         else
         {
            if(UnknownVarFromClubDiscountPromoExtension_Timer_2)
            {
               UnknownVarFromClubDiscountPromoExtension_Timer_2.stop();
               UnknownVarFromClubDiscountPromoExtension_Timer_2 = null;
            }
            clearAnimation();
         }
      }
      
      private function clearAnimation() : void
      {
         if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1)
         {
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.visible = false;
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap = null;
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1 = null;
            UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.invalidate();
            if(UnknownVarFromClubDiscountPromoExtension_Timer_1)
            {
               UnknownVarFromClubDiscountPromoExtension_Timer_1.stop();
               UnknownVarFromClubDiscountPromoExtension_Timer_1 = null;
            }
         }
      }
      
      private function onTriggerTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1)
         {
            if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.context)
            {
               UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.visible = true;
               resetAnimationVariables();
               startAnimationTimer();
            }
         }
      }
      
      private function resetAnimationVariables() : void
      {
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.x = 3;
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.y = 3;
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap = UnknownVarFromClubDiscountPromoExtension_BitmapData_1.clone();
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.height = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.height - 6;
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.width = UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap.width;
         UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.invalidate();
         _animBlockMoveAmount = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.width - 7 - UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap.width;
         UnknownVarFromClubDiscountPromoExtension_Int_1 = 0;
      }
      
      private function startAnimationTimer() : void
      {
         UnknownVarFromClubDiscountPromoExtension_Timer_1 = new Timer(25,26);
         UnknownVarFromClubDiscountPromoExtension_Timer_1.addEventListener("timer",onAnimationTimer);
         UnknownVarFromClubDiscountPromoExtension_Timer_1.addEventListener("timerComplete",onAnimationTimerComplete);
         UnknownVarFromClubDiscountPromoExtension_Timer_1.start();
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BitmapData = null;
         if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1)
         {
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.x = 3 + UnknownVarFromClubDiscountPromoExtension_Int_1 / 20 * _animBlockMoveAmount;
            if(UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.x > _animBlockMoveAmount)
            {
               _loc2_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.width - 4 - UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.x;
               _loc3_ = new BitmapData(_loc2_,UnknownVarFromClubDiscountPromoExtension_BitmapData_1.height);
               _loc3_.copyPixels(UnknownVarFromClubDiscountPromoExtension_BitmapData_1,new Rectangle(0,0,_loc2_,UnknownVarFromClubDiscountPromoExtension_BitmapData_1.height),new Point(0,0));
               UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.bitmap = _loc3_;
               UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.width = _loc2_;
            }
            UnknownVarFromClubDiscountPromoExtension_IBitmapWrapperController_1.invalidate();
            UnknownVarFromClubDiscountPromoExtension_Int_1++;
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         clearAnimation();
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = null;
         if(UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1)
         {
            _loc2_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.findChildByName("club_icon") as IIconWindow;
            if(_loc2_)
            {
               _loc2_.style = param1;
               _loc2_.invalidate();
            }
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1)
         {
            _loc2_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 12247545;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1)
         {
            _loc2_ = UnknownVarFromClubDiscountPromoExtension_IWindowController_1_1.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 16777215;
         }
      }
   }
}

