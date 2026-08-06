package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   import flash.display.BitmapData;
   
   public class ClubCenterView implements UnknownIHabboAvatar1
   {
      private var UnknownVarFromClubCenterView_HabboClubCenter_1:HabboClubCenter;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromClubCenterView_IRoomPreviewerWidget_1:IRoomPreviewerWidget;
      
      private var UnknownVarFromClubCenterView_String_1:String;
      
      public function ClubCenterView(param1:HabboClubCenter, param2:IHabboWindowManagerComponent, param3:String)
      {
         super();
         UnknownVarFromClubCenterView_HabboClubCenter_1 = param1;
         _window = param2.buildFromXML(XML(UnknownVarFromClubCenterView_HabboClubCenter_1.assets.getAssetByName("club_center_xml").content)) as IWindowController_1;
         if(!container)
         {
            return;
         }
         if(!UnknownVarFromClubCenterView_HabboClubCenter_1.isKickbackEnabled())
         {
            removeElement("special_breakdown_link");
            removeElement("special_content");
            removeElement("special_content_postit");
            container.invalidate();
         }
         else
         {
            setElementVisibility("special_amount_icon",false);
            setElementVisibility("special_amount_title",false);
            setElementVisibility("special_amount_content",false);
            setElementVisibility("special_breakdown_link",false);
            setElementVisibility("special_time_content",false);
         }
         setElementVisibility("btn_earn",false);
         UnknownVarFromClubCenterView_HabboClubCenter_1.getOffers();
         _window.center();
         _window.addEventListener("WE_RELOCATE",onRelocate);
         UnknownVarFromClubCenterView_String_1 = param3;
         UnknownVarFromClubCenterView_IRoomPreviewerWidget_1 = IWidgetWindowController(_window.findChildByName("avatar")).widget as IRoomPreviewerWidget;
         var _loc4_:IAvatarImage_2 = UnknownVarFromClubCenterView_HabboClubCenter_1.avatarRenderManager.createAvatarImage(param3,"h",null,this);
         if(_loc4_)
         {
            _loc4_.setDirection("full",4);
            UnknownVarFromClubCenterView_IRoomPreviewerWidget_1.showPreview(_loc4_.getCroppedImage("full"));
         }
         container.procedure = onInput;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WE_RELOCATE",onRelocate);
            _window.dispose();
            _window = null;
         }
         UnknownVarFromClubCenterView_HabboClubCenter_1 = null;
      }
      
      public function dataReceived(param1:ScrKickbackData, param2:IPurse, param3:int, param4:BitmapData) : void
      {
         var _loc7_:int = 0;
         var _loc6_:UnknownICoreWindowComponents4 = null;
         var _loc9_:String = UnknownVarFromClubCenterView_HabboClubCenter_1.resolveClubStatus();
         setElementText("status_title","${hccenter.status." + _loc9_ + "}");
         if(!param1 || !param2)
         {
            setElementVisibility("gift_content",false);
            setElementVisibility("special_container",false);
            return;
         }
         setElementVisibility("gift_content",true);
         var _loc5_:String = getLocalization("hccenter.status." + _loc9_ + ".info");
         _loc5_ = _loc5_.replace("%timeleft%",formatMinutes(param2.minutesUntilExpiration));
         _loc5_ = _loc5_.replace("%joindate%",param1.firstSubscriptionDate);
         _loc5_ = _loc5_.replace("%streakduration%",formatDays(param1.currentHcStreak));
         setElementText("status_info",_loc5_);
         var _loc8_:IBitmapWrapperController = container.findChildByName("hc_badge") as IBitmapWrapperController;
         if(_loc8_ && param4)
         {
            _loc8_.bitmap = param4;
         }
         if(UnknownVarFromClubCenterView_HabboClubCenter_1.isKickbackEnabled())
         {
            if(param1.timeUntilPayday < 60)
            {
               setElementText("special_time_content",getLocalization("hccenter.special.time.soon"));
            }
            else
            {
               setElementText("special_time_content",formatMinutes(param1.timeUntilPayday));
            }
            setElementVisibility("special_time_content",true);
            _loc7_ = param1.creditRewardForMonthlySpent + param1.creditRewardForStreakBonus;
            if(_loc7_ > 0)
            {
               setElementVisibility("special_amount_icon",true);
               setElementVisibility("special_amount_title",true);
               setElementVisibility("special_amount_content",true);
               setElementVisibility("special_breakdown_link",true);
               setElementText("special_amount_content",getLocalization("hccenter.special.sum").replace("%credits%",_loc7_));
            }
         }
         _loc6_ = container.findChildByName("btn_gift") as UnknownICoreWindowComponents4;
         if(_loc9_ == "active" && param3 > 0)
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.gifts.redeem}";
            }
            setElementText("gift_info",getLocalization("hccenter.unclaimedgifts").replace("%unclaimedgifts%",param3));
         }
         else
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.gifts.view}";
            }
            setElementText("gift_info",getLocalization("hccenter.gift.info"));
         }
         _loc6_ = container.findChildByName("btn_buy") as UnknownICoreWindowComponents4;
         if(_loc9_ == "active")
         {
            if(_loc6_)
            {
               _loc6_.caption = "${hccenter.btn.extend}";
            }
         }
         else if(_loc6_)
         {
            _loc6_.caption = "${hccenter.btn.buy}";
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:IAvatarImage_2 = null;
         if(param1 == UnknownVarFromClubCenterView_String_1)
         {
            _loc2_ = UnknownVarFromClubCenterView_HabboClubCenter_1.avatarRenderManager.createAvatarImage(UnknownVarFromClubCenterView_String_1,"h",null,this);
            _loc2_.setDirection("full",4);
            UnknownVarFromClubCenterView_IRoomPreviewerWidget_1.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK" || !UnknownVarFromClubCenterView_HabboClubCenter_1)
         {
            return;
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         switch(param2.name)
         {
            case "header_button_close":
               UnknownVarFromClubCenterView_HabboClubCenter_1.removeView();
               return;
            case "special_infolink":
               UnknownVarFromClubCenterView_HabboClubCenter_1.openPaydayHelpPage();
               break;
            case "special_breakdown_link":
               UnknownVarFromClubCenterView_HabboClubCenter_1.showPaydayBreakdownView();
               break;
            case "general_infolink":
               UnknownVarFromClubCenterView_HabboClubCenter_1.openHelpPage();
               break;
            case "btn_gift":
               UnknownVarFromClubCenterView_HabboClubCenter_1.openClubGiftPage();
               break;
            case "btn_buy":
               UnknownVarFromClubCenterView_HabboClubCenter_1.openPurchasePage();
               break;
            case "btn_earn":
               if(UnknownVarFromClubCenterView_HabboClubCenter_1.offerCenter)
               {
                  UnknownVarFromClubCenterView_HabboClubCenter_1.offerCenter.showVideo();
               }
               break;
            default:
               return;
         }
      }
      
      private function onRelocate(param1:WindowEvent) : void
      {
         UnknownVarFromClubCenterView_HabboClubCenter_1.removeBreakdown();
      }
      
      private function get container() : IWindowController_1
      {
         return _window;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:ITextWindow = container.findChildByName(param1) as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = param2;
         }
      }
      
      private function setElementVisibility(param1:String, param2:Boolean) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:IWindowModel = container.findChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      public function getSpecialCalloutAnchor() : IWindowModel
      {
         return !!container ? container.findChildByName("special_content_postit") : null;
      }
      
      private function removeElement(param1:*) : void
      {
         if(!container)
         {
            return;
         }
         var _loc3_:IWindowModel = container.findChildByName(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:IWindowController_1 = _loc3_.parent as IWindowController_1;
         _loc2_.removeChild(_loc3_);
      }
      
      private function getLocalization(param1:String) : String
      {
         if(!UnknownVarFromClubCenterView_HabboClubCenter_1 || !UnknownVarFromClubCenterView_HabboClubCenter_1.localization)
         {
            return "";
         }
         return UnknownVarFromClubCenterView_HabboClubCenter_1.localization.getLocalization(param1,param1);
      }
      
      public function formatMinutes(param1:int) : String
      {
         return FriendlyTime.getShortFriendlyTime(UnknownVarFromClubCenterView_HabboClubCenter_1.localization,param1 * 60);
      }
      
      public function formatDays(param1:int) : String
      {
         return FriendlyTime.getShortFriendlyTime(UnknownVarFromClubCenterView_HabboClubCenter_1.localization,param1 * 86400);
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromClubCenterView_HabboClubCenter_1 == null;
      }
      
      public function setVideoOfferButtonVisibility(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName("btn_earn");
         if(_loc3_)
         {
            _loc3_.visible = param1;
            if(param2)
            {
               _loc3_.enable();
               _loc3_.alpha = 0;
            }
            else
            {
               _loc3_.disable();
               _loc3_.alpha = 51;
            }
         }
      }
   }
}

