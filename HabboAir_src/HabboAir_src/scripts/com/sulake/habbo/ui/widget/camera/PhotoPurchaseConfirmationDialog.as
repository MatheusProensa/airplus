package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.utils.TextWindowUtils;
   import com.sulake.habbo.window.utils.AlertDialogCaption;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   
   internal class PhotoPurchaseConfirmationDialog
   {
      private static const STATE_LOADING_IMAGE:String = "loading_image";
      
      private static const STATE_IMAGE_LOADED:String = "image_loaded";
      
      private static const STATE_WAITING_PURCHASE_TO_COMPLETE:String = "waiting_purchase_to_complete";
      
      private static const STATE_WAITING_PUBLISH_TO_COMPLETE:String = "waiting_publish_to_complete";
      
      private static const STATE_WAITING_COMPETITION_SUBMIT_TO_COMPLETE:String = "waiting_competition_submit_to_complete";
      
      private static const STATE_RENDERING_FAILED:String = "rendering_failed";
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_String_1:String;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1:CameraWidget;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1:BitmapData;
      
      private var _caption:String;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_1:Boolean;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_2:Boolean = false;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_3:Boolean = false;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_String_2:String = null;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1:Timer;
      
      private var UnknownVarFromPhotoPurchaseConfirmationDialog_Int_1:int = 0;
      
      public function PhotoPurchaseConfirmationDialog(param1:CameraWidget, param2:String)
      {
         super();
         UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1 = param1;
         _caption = param2;
         _window = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.getXmlWindow("photo_purchase_confirmation") as IWindowController_1;
         var _loc3_:IItemListWindow = (_window as IFrameController).content.getChildByName("contentlist") as IItemListWindow;
         if(param1.component.getBoolean("camera.competition.enabled"))
         {
            TextWindowUtils.setHTMLLinkStyle(_window.findChildByName("competition_info") as ITextWindow,16777215,16777215,16777215);
         }
         else
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("competition_wrapper"));
         }
         if(param1.component.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("disclaimer"));
            setDisclaimerAccepted(true);
         }
         if(!param1.component.getBoolean("camera.photo.publishing.enabled"))
         {
            _loc3_.removeListItem(_loc3_.getListItemByName("publish_wrapper"));
         }
         (_window as IFrameController).resizeToFitContent();
         setState("loading_image");
         _window.center();
         _window.procedure = windowEventHandler;
      }
      
      private function checkPurse(param1:int, param2:int) : Boolean
      {
         var _loc3_:IPurse = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.catalog.getPurse();
         if(_loc3_.credits < param1)
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.catalog.showNotEnoughCreditsAlert();
            return false;
         }
         if(_loc3_.getActivityPointsForType(0) < param2)
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.catalog.showNotEnoughActivityPointsAlert(0);
            return false;
         }
         return true;
      }
      
      private function disableButtons(param1:Boolean) : void
      {
         var _loc4_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("buy_button"));
         var _loc2_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("publish_button"));
         var _loc3_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("competition_button"));
         if(_loc4_)
         {
            _loc4_.disable();
         }
         if(_loc2_)
         {
            _loc2_.disable();
         }
         if(_loc3_)
         {
            _loc3_.disable();
         }
         if(param1)
         {
            UnknownICoreWindowComponents4(_window.findChildByName("cancel_button")).caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("generic.close");
            _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.purchase.pleasewait");
         }
      }
      
      private function setState(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 = param1;
         var _loc4_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("buy_button"));
         var _loc2_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("publish_button"));
         var _loc3_:UnknownICoreWindowComponents4 = UnknownICoreWindowComponents4(_window.findChildByName("competition_button"));
         switch(param1)
         {
            case "loading_image":
               disableButtons(false);
               break;
            case "image_loaded":
               if(UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_1)
               {
                  _loc4_.enable();
               }
               if(!UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_3)
               {
                  if(_loc2_)
                  {
                     _loc2_.enable();
                  }
               }
               if(!UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_2 && _loc3_)
               {
                  _loc3_.enable();
               }
               break;
            case "waiting_purchase_to_complete":
               disableButtons(true);
               if(UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.getBoolean("disclaimer.credit_spending.enabled"))
               {
                  setDisclaimerAccepted(false);
               }
               break;
            case "waiting_publish_to_complete":
               UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_3 = true;
               disableButtons(true);
               break;
            case "waiting_competition_submit_to_complete":
               UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_2 = true;
               disableButtons(true);
               break;
            case "rendering_failed":
               disableButtons(false);
               _window.findChildByName("status_info").caption = "";
         }
      }
      
      public function animateIconToToolbar() : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("product_image") as IBitmapWrapperController;
         var _loc4_:Point = new Point();
         _loc2_.getGlobalPosition(_loc4_);
         var _loc1_:String = "HTIE_ICON_INVENTORY";
         var _loc6_:BitmapData = new BitmapData(120,120);
         var _loc3_:Number = _loc6_.width / UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1.width;
         var _loc5_:Matrix = new Matrix(_loc3_,0,0,_loc3_,0,0);
         _loc6_.draw(UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1,_loc5_);
         UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.toolbar.createTransitionToIcon(_loc1_,_loc6_,_loc4_.x,_loc4_.y);
         _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.purchase.successful");
         _window.findChildByName("buy_button").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.buy.another.button.text");
         _window.findChildByName("inventory_link_area").visible = true;
         UnknownVarFromPhotoPurchaseConfirmationDialog_Int_1++;
         _window.findChildByName("purchase_count").caption = "";
         _window.findChildByName("purchase_count").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_Int_1.toString();
         setState("image_loaded");
      }
      
      public function setImageUrl(param1:String) : void
      {
         var _loc2_:BitmapFileLoader = null;
         if(UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1 == null)
         {
            return;
         }
         if(param1 && param1.length > 0)
         {
            param1 = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.context.configuration.getProperty("stories.image_url_base") + param1;
            _loc2_ = new BitmapFileLoader("image/png",new URLRequest(param1));
            _loc2_.addEventListener("AssetLoaderEventComplete",onImageLoaded);
         }
         else
         {
            setRenderingFailed();
            UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.windowManager.alert("${generic.alert.title}","${camera.render.count.info}",0,null);
         }
      }
      
      private function onImageLoaded(param1:AssetLoaderEvent) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:Bitmap = BitmapFileLoader(param1.target).content as Bitmap;
         if(_loc2_)
         {
            setImage(_loc2_.bitmapData);
         }
         _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.confirm_phase.info");
         setState("image_loaded");
      }
      
      private function setImage(param1:BitmapData) : void
      {
         if(_window == null || param1 == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName("product_image") as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
            _loc3_.bitmap = null;
         }
         if(_loc3_.bitmap == null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         }
         var _loc2_:Number = _loc3_.width / param1.width;
         _loc3_.bitmap.draw(param1,new Matrix(_loc2_,0,0,_loc2_,0,0),null,null,null,true);
         UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1 = param1;
      }
      
      public function setRenderingFailed() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:IBitmapWrapperController = _window.findChildByName("product_image") as IBitmapWrapperController;
         if(_loc1_ != null)
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1 = new BitmapData(_loc1_.width,_loc1_.height,false,0);
            if(_loc1_.bitmap == null)
            {
               _loc1_.bitmap = UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1;
            }
            else
            {
               _loc1_.bitmap.dispose();
               _loc1_.bitmap.draw(UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1);
            }
         }
         setState("rendering_failed");
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(_window == null)
         {
            return;
         }
         if(param1.getParser().isOk())
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_String_2 = param1.getParser().getExtraDataId();
            _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.publish.successful");
            _window.findChildByName("publish_explanation").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.publish.successful");
            _window.findChildByName("publish_detailed_explanation").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.publish.success.short.info");
            _window.findChildByName("publish_button").visible = false;
            _window.findChildByName("publish_price_area").visible = false;
            _window.findChildByName("publish_link_area").visible = true;
            if(UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 != null)
            {
               UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.reset();
            }
         }
         else
         {
            _loc4_ = param1.getParser().getSecondsToWait();
            _loc3_ = _loc4_ / 60 + 1;
            _loc2_ = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.registerParameter("camera.publish.wait","minutes",_loc3_.toString());
            UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.windowManager.alert("${generic.alert.title}",_loc2_,0,null);
            _window.findChildByName("status_info").caption = "";
            if(UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 == null)
            {
               UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 = new Timer(_loc4_ * 1000,1);
               UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.addEventListener("timerComplete",onPublishTimerComplete);
            }
            else
            {
               UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.reset();
               UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.delay = _loc4_ * 1000;
            }
            UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.start();
         }
         setState("image_loaded");
      }
      
      private function onPublishTimerComplete(param1:TimerEvent) : void
      {
         var _loc2_:UnknownICoreWindowComponents4 = null;
         UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_3 = false;
         UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 = null;
         if(UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 == "image_loaded")
         {
            _loc2_ = UnknownICoreWindowComponents4(_window.findChildByName("publish_button"));
            _loc2_.enable();
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         var _loc2_:UnknownICoreWindowUtils2 = null;
         if(_window == null || _window.findChildByName("competition_wrapper") == null)
         {
            return;
         }
         if(param1.getParser().isOk())
         {
            _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.competition.submitted.status");
            _window.findChildByName("competition_name").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.competition.submitted.info");
         }
         else if(param1.getParser().getErrorReason() == "too-many-submits")
         {
            _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("generic.failed");
            _window.findChildByName("competition_name").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("camera.competition.limit.info");
         }
         else if(param1.getParser().getErrorReason() == "email-not-verified")
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_2 = false;
            _window.findChildByName("status_info").caption = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("generic.failed");
            _loc2_ = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.windowManager.confirm("${generic.alert.title}","${camera.competition.email.not.verified}",0x10 | 0x20,onEmailVerificationGo);
            _loc2_.setButtonCaption(16,new AlertDialogCaption(UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("email.settings"),"",true));
            _loc2_.setButtonCaption(32,new AlertDialogCaption(UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.localizations.getLocalization("groupforum.settings.cancel"),"",true));
         }
         setState("image_loaded");
         var _loc3_:IWindowModel = _window.findChildByName("competition_button");
         if(_loc3_ != null && _loc3_.y < 10)
         {
            _loc3_.y = 10;
         }
      }
      
      private function onEmailVerificationGo(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         if(param2.type == "WE_OK")
         {
            _loc4_ = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.context.configuration.getProperty("email.verification.url");
            if(!StringUtil.isEmpty(_loc4_))
            {
               _loc3_ = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.getInteger("spaweb",0) == 1 ? "" : "_blank";
               navigateToURL(new URLRequest(_loc4_),_loc3_);
            }
         }
         param1.dispose();
      }
      
      public function setPrices(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:ITextWindow = _window.findChildByName("purchase_credit_cost_text") as ITextWindow;
         _loc4_.text = param1.toString();
         var _loc5_:ITextWindow = _window.findChildByName("purchase_ducket_cost_text") as ITextWindow;
         if(param2 > 0)
         {
            _loc5_.text = param2.toString();
         }
         else
         {
            _loc5_.visible = false;
            _window.findChildByName("ducket_icon").visible = false;
         }
         var _loc6_:ITextWindow = _window.findChildByName("publish_ducket_cost_text") as ITextWindow;
         if(_loc6_)
         {
            _loc6_.text = param3.toString();
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!param1 || !param2)
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
            case "competition_button":
               if(UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 == "image_loaded")
               {
                  setState("waiting_competition_submit_to_complete");
                  UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.confirmPhotoCompetitionSubmit();
               }
               break;
            case "buy_button":
               if(UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 == "image_loaded" && UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_1 && checkPurse(UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.creditPrice,UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.ducketPrice))
               {
                  setState("waiting_purchase_to_complete");
                  UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.confirmPhotoPurchase();
               }
               break;
            case "publish_button":
               if(UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 == "image_loaded" && checkPurse(0,UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.publishDucketPrice))
               {
                  setState("waiting_publish_to_complete");
                  UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.handler.confirmPhotoPublish();
               }
               break;
            case "inventory_link":
               UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.component.context.createLinkEvent("inventory/open/furni");
               break;
            case "publish_link":
               _loc3_ = UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.container.sessionDataManager.userName;
               _loc4_ = "/profile/" + _loc3_ + "/photo/" + UnknownVarFromPhotoPurchaseConfirmationDialog_String_2;
               HabboWebTools.openPage(_loc4_);
               break;
            case "header_button_close":
            case "cancel_button":
               UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1.startTakingPhoto("photoPurchaseCancel");
               hide();
         }
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("buy_button");
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromPhotoPurchaseConfirmationDialog_Boolean_1 = param1;
         if(param1 && UnknownVarFromPhotoPurchaseConfirmationDialog_String_1 == "image_loaded")
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      public function hide() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromPhotoPurchaseConfirmationDialog_BitmapData_1 = null;
         UnknownVarFromPhotoPurchaseConfirmationDialog_CameraWidget_1 = null;
         if(UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 != null)
         {
            UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1.stop();
            UnknownVarFromPhotoPurchaseConfirmationDialog_Timer_1 = null;
         }
      }
   }
}

