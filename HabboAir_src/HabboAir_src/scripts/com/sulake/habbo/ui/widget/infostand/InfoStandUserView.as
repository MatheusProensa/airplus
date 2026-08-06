package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfo;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.groups.UnknownHabboGroups1;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class InfoStandUserView
   {
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
      
      protected var UnknownVarFromInfoStandUserView_InfoStandWidget_1:InfoStandWidget;
      
      protected var _window:IItemListWindow;
      
      protected var UnknownVarFromInfoStandUserView_IItemListWindow_1:IItemListWindow;
      
      protected var UnknownVarFromInfoStandUserView_IItemListWindow_2:IItemListWindow;
      
      private var UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromInfoStandUserView_TagListRenderer_1:TagListRenderer;
      
      private var _badgeDetails:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromInfoStandUserView_Int_1:int;
      
      protected var UnknownVarFromInfoStandUserView_IRegionWindow_1:IRegionWindow;
      
      private const ITEM_SPACER:int = 5;
      
      private const MOTTO_TEXT_OFFSET:int = 3;
      
      private const MOTTO_EDITED_COLOR:int = 11184810;
      
      private const MOTTO_UNCHANGED_COLOR:int = 16777215;
      
      private const UnknownConstFromInfoStandUserView_Int_1:int = 2000;
      
      private const MAX_MOTTO_HEIGHT:int = 50;
      
      private const MIN_MOTTO_HEIGHT:int = 23;
      
      private const TOOLTIP_DELAY:int = 100;
      
      public function InfoStandUserView(param1:InfoStandWidget, param2:String)
      {
         super();
         UnknownVarFromInfoStandUserView_InfoStandWidget_1 = param1;
         createWindow(param2);
         UnknownVarFromInfoStandUserView_TagListRenderer_1 = new TagListRenderer(param1,onTagSelected);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromInfoStandUserView_IRegionWindow_1)
         {
            UnknownVarFromInfoStandUserView_IRegionWindow_1.dispose();
            UnknownVarFromInfoStandUserView_IRegionWindow_1 = null;
         }
         clearBadgeGlowEffects();
         UnknownVarFromInfoStandUserView_InfoStandWidget_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromInfoStandUserView_TagListRenderer_1.dispose();
         UnknownVarFromInfoStandUserView_TagListRenderer_1 = null;
         disposeBadgeDetails();
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function updateWindow() : void
      {
         if(UnknownVarFromInfoStandUserView_IItemListWindow_1 == null || UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1 == null)
         {
            return;
         }
         UnknownVarFromInfoStandUserView_IItemListWindow_1.height = UnknownVarFromInfoStandUserView_IItemListWindow_1.scrollableRegion.height;
         UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.height = UnknownVarFromInfoStandUserView_IItemListWindow_1.height + 20;
         _window.width = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.width;
         _window.height = _window.scrollableRegion.height;
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.refreshContainer();
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc9_:BitmapDataAsset = null;
         var _loc8_:BitmapData = null;
         var _loc3_:IWindowModel = null;
         var _loc7_:int = 0;
         _window = UnknownVarFromInfoStandUserView_InfoStandWidget_1.getXmlWindow("user_view") as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1 = _window.getListItemByName("info_border") as UnknownICoreWindowComponents6;
         if(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1 != null)
         {
            UnknownVarFromInfoStandUserView_IItemListWindow_1 = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("infostand_element_list") as IItemListWindow;
            UnknownVarFromInfoStandUserView_IItemListWindow_2 = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("relationship_status_container") as IItemListWindow;
            UnknownVarFromInfoStandUserView_IItemListWindow_2.visible = UnknownVarFromInfoStandUserView_InfoStandWidget_1.config.getBoolean("relationship.status.enabled");
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("heart_randomusername").procedure = onRelationshipUserNameLinkClicked;
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("smile_randomusername").procedure = onRelationshipUserNameLinkClicked;
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("bobba_randomusername").procedure = onRelationshipUserNameLinkClicked;
         }
         _window.name = param1;
         var _loc6_:IBitmapWrapperController = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("home_icon") as IBitmapWrapperController;
         if(_loc6_ != null)
         {
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc9_ = UnknownVarFromInfoStandUserView_InfoStandWidget_1.assets.getAssetByName("icon_home") as BitmapDataAsset;
            _loc8_ = _loc9_.content as BitmapData;
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc6_.bitmap.copyPixels(_loc8_,_loc8_.rect,new Point(0,0));
            _loc6_.addEventListener("WME_CLICK",onButtonClicked);
         }
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.mainContainer.addChild(_window);
         var _loc5_:IWindowModel = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByTag("close");
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onClose);
         }
         _loc7_ = 0;
         while(_loc7_ < 5)
         {
            _loc3_ = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_" + _loc7_);
            if(_loc3_ != null)
            {
               _loc3_.addEventListener("WME_OVER",showBadgeInfo);
               _loc3_.addEventListener("WME_OUT",hideBadgeInfo);
            }
            _loc7_++;
         }
         _loc3_ = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_group");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",selectGroupBadge);
            _loc3_.addEventListener("WME_OVER",showGroupBadgeInfo);
            _loc3_.addEventListener("WME_OUT",hideGroupBadgeInfo);
         }
         var _loc2_:IWindowModel = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("avatar_image_profile_link");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onProfileLink;
         }
         var _loc4_:IWindowModel = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badges_rank_region");
         if(_loc4_ != null)
         {
            _loc4_.procedure = onBadgesRankClicked;
         }
         if(UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler.isActivityDisplayEnabled)
         {
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("score_spacer").visible = true;
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("score_value").visible = true;
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("score_text").visible = true;
         }
      }
      
      private function selectGroupBadge(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.groupId < 0)
         {
            return;
         }
         var _loc2_:* = UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.type == "RWUIUE_OWN_USER";
         var _loc3_:RoomWidgetGetBadgeDetailsMessage = new RoomWidgetGetBadgeDetailsMessage(_loc2_,UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.groupId);
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.messageListener.processWidgetMessage(_loc3_);
      }
      
      private function showGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.groupId < 0)
         {
            return;
         }
         if(param1.window == null)
         {
            return;
         }
         populateBadgeDetails(UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.groupName,"",null);
         var _loc2_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc2_);
         _badgeDetails.x = _loc2_.left - _badgeDetails.width;
         _badgeDetails.y = _loc2_.top + (_loc2_.height - _badgeDetails.height) / 2;
      }
      
      private function hideGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function showBadgeInfo(param1:WindowMouseEvent) : void
      {
         if(param1.window == null)
         {
            return;
         }
         var _loc7_:int = int(param1.window.name.replace("badge_",""));
         if(_loc7_ < 0)
         {
            return;
         }
         var _loc2_:Array = UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.badges;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc7_ >= _loc2_.length)
         {
            return;
         }
         var _loc4_:String = UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.badges[_loc7_];
         var _loc6_:SelectedBadgeData = UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.getSelectedBadge(_loc7_);
         var _loc3_:IBadgeImageWidget = IWidgetWindowController(param1.window).widget as IBadgeImageWidget;
         if(_loc4_ == null)
         {
            return;
         }
         if(_loc3_ != null && _loc3_.glowColor >= 0)
         {
            _loc3_.playGlow(uint(_loc3_.glowColor));
         }
         populateBadgeDetails(UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getBadgeName(_loc4_),UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getBadgeDesc(_loc4_),_loc6_);
         if(_badgeDetails.desktop != null)
         {
            _badgeDetails.desktop.addChild(_badgeDetails);
         }
         _badgeDetails.activate();
         var _loc5_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc5_);
         _badgeDetails.x = _loc5_.left - _badgeDetails.width;
         _badgeDetails.y = _loc5_.top + (_loc5_.height - _badgeDetails.height) / 2;
      }
      
      private function hideBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function createBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            return;
         }
         var _loc1_:XmlAsset = UnknownVarFromInfoStandUserView_InfoStandWidget_1.assets.getAssetByName("badge_details") as XmlAsset;
         if(_loc1_ == null)
         {
            return;
         }
         _badgeDetails = UnknownVarFromInfoStandUserView_InfoStandWidget_1.windowManager.buildFromXML(_loc1_.content as XML) as UnknownICoreWindowComponents6;
         if(_badgeDetails == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
      }
      
      private function populateBadgeDetails(param1:String, param2:String, param3:SelectedBadgeData) : void
      {
         var _loc10_:Boolean = false;
         createBadgeDetails();
         var _loc6_:IItemListWindow = _badgeDetails.findChildByName("details_list") as IItemListWindow;
         var _loc9_:ITextWindow = _badgeDetails.findChildByName("name") as ITextWindow;
         var _loc5_:ITextWindow = _badgeDetails.findChildByName("description") as ITextWindow;
         var _loc7_:UnknownICoreWindowComponents6 = _badgeDetails.findChildByName("rarity_tag") as UnknownICoreWindowComponents6;
         var _loc4_:ITextWindow = _badgeDetails.findChildByName("rarity_border") as ITextWindow;
         var _loc12_:ITextWindow = _badgeDetails.findChildByName("rarity") as ITextWindow;
         var _loc8_:ITextWindow = _badgeDetails.findChildByName("owner_count") as ITextWindow;
         _loc9_.text = param1;
         _loc5_.visible = param2 != "";
         _loc5_.text = param2;
         var _loc11_:* = param3 != null;
         _loc7_.visible = _loc11_;
         _loc4_.text = "";
         _loc12_.text = "";
         if(_loc11_)
         {
            _loc10_ = isUncommonBadgeRarityEnabled();
            _loc12_.textColor = 16777215;
            _loc12_.text = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalizationWithParams("badge.rarity.badge","","rarity",UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization(BadgeRarity.getLabelLocalizationKey(param3.badgeRarityId,_loc10_)));
            _loc4_.text = _loc12_.text;
            _loc7_.color = BadgeRarity.getWhiteBackgroundTagColor(param3.badgeRarityId,_loc10_);
         }
         var _loc13_:Boolean = param3 != null && UnknownHabboGroups1.shouldShowOwnerCount(param3.ownerCount);
         _loc8_.visible = _loc13_;
         _loc8_.text = "";
         if(_loc13_)
         {
            _loc8_.text = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalizationWithParams("badge.owner_count","","count",UnknownHabboGroups1.formatOwnerCount(param3.ownerCount));
         }
         if(_loc6_ != null)
         {
            _loc6_.arrangeListItems();
            _badgeDetails.height = _loc6_.y + _loc6_.height + 6;
         }
      }
      
      private function disposeBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            _badgeDetails.dispose();
            _badgeDetails = null;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.close();
      }
      
      public function set name(param1:String) : void
      {
         if(UnknownVarFromInfoStandUserView_IRegionWindow_1 == null)
         {
            UnknownVarFromInfoStandUserView_IRegionWindow_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("profile_link") as IRegionWindow;
            if(UnknownVarFromInfoStandUserView_IRegionWindow_1 == null)
            {
               return;
            }
            UnknownVarFromInfoStandUserView_IRegionWindow_1.procedure = onProfileLink;
            UnknownVarFromInfoStandUserView_IRegionWindow_1.visible = true;
         }
         var _loc2_:ITextWindow = UnknownVarFromInfoStandUserView_IRegionWindow_1.findChildByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      public function set realName(param1:String) : void
      {
         var _loc2_:ITextWindow = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("realname_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1.length == 0)
         {
            _loc2_.text = "";
         }
         else
         {
            UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.registerParameter("infostand.text.realname","realname",param1);
            _loc2_.text = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization("infostand.text.realname");
         }
         _loc2_.height = _loc2_.textHeight + 5;
         _loc2_.visible = param1.length > 0;
      }
      
      public function setFigure(param1:String) : void
      {
         var _loc2_:IAvatarImageWidget = IWidgetWindowController(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("avatar_image")).widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      public function setMotto(param1:String, param2:Boolean) : void
      {
         var _loc7_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("motto_container") as IWindowController_1;
         if(!_loc7_)
         {
            return;
         }
         var _loc3_:IWindowModel = _loc7_.findChildByName("changemotto.image");
         var _loc6_:ITextWindow = _loc7_.findChildByName("motto_text") as ITextWindow;
         var _loc5_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("motto_spacer") as IWindowController_1;
         if(_loc6_ == null || _loc5_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2)
         {
            _loc3_.visible = true;
            if(param1 == "")
            {
               param1 = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization("infostand.motto.change");
               _loc6_.textColor = 11184810;
            }
            else
            {
               _loc6_.textColor = 16777215;
            }
            _loc6_.enable();
         }
         else
         {
            _loc3_.visible = false;
            _loc6_.textColor = 16777215;
            _loc6_.disable();
         }
         if(!UnknownVarFromInfoStandUserView_InfoStandWidget_1.config.getBoolean("infostand.motto.change.enabled"))
         {
            _loc6_.disable();
         }
         _loc6_.text = param1;
         _loc6_.height = Math.min(_loc6_.textHeight + 5,50);
         _loc6_.height = Math.max(_loc6_.height,23);
         _loc7_.height = _loc6_.height + 3;
         if(param2)
         {
            _loc6_.addEventListener("WKE_KEY_UP",onMottoKeyboard);
            _loc6_.addEventListener("WME_CLICK",onMottoClicked);
         }
         else
         {
            _loc6_.removeEventListener("WKE_KEY_UP",onMottoClicked);
         }
         var _loc4_:Boolean = _loc6_.text && _loc6_.text.toLowerCase().indexOf("crikey") >= 0;
         if(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1)
         {
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("sticker_croco").visible = _loc4_;
            UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("avatar_image").visible = !_loc4_;
         }
         updateWindow();
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler.isActivityDisplayEnabled)
         {
            return;
         }
         var _loc2_:ITextWindow = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("score_value") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = String(param1);
      }
      
      public function set carryItem(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("handitem_txt") as ITextWindow;
         var _loc3_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("handitem_spacer") as IWindowController_1;
         if(_loc6_ == null || _loc3_ == null)
         {
            return;
         }
         if(param1 > 0 && param1 < 999999)
         {
            _loc2_ = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization("handitem" + param1,"handitem" + param1);
            UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.registerParameter("infostand.text.handitem","item",_loc2_);
         }
         _loc6_.height = _loc6_.textHeight + 5;
         var _loc4_:Boolean = Boolean(_loc6_.visible);
         var _loc5_:Boolean = param1 > 0 && param1 < 999999;
         _loc6_.visible = _loc5_;
         _loc3_.visible = _loc5_;
         if(_loc5_ != _loc4_)
         {
            UnknownVarFromInfoStandUserView_IItemListWindow_1.arrangeListItems();
         }
         updateWindow();
      }
      
      public function set xp(param1:int) : void
      {
         var _loc5_:ITextWindow = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("xp_text") as ITextWindow;
         var _loc2_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("xp_spacer") as IWindowController_1;
         if(_loc5_ == null || _loc2_ == null)
         {
            return;
         }
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.registerParameter("infostand.text.xp","xp",param1.toString());
         _loc5_.height = _loc5_.textHeight + 5;
         var _loc3_:Boolean = Boolean(_loc5_.visible);
         var _loc4_:* = param1 > 0;
         _loc5_.visible = _loc4_;
         _loc2_.visible = _loc4_;
         if(_loc4_ != _loc3_)
         {
            UnknownVarFromInfoStandUserView_IItemListWindow_1.arrangeListItems();
         }
         updateWindow();
      }
      
      public function setBadge(param1:int, param2:String, param3:SelectedBadgeData = null, param4:Boolean = false) : void
      {
         var _loc6_:IWidgetWindowController = IWidgetWindowController(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_" + param1));
         var _loc5_:IBadgeImageWidget = _loc6_.widget as IBadgeImageWidget;
         var _loc7_:Boolean = isUncommonBadgeRarityEnabled();
         _loc5_.badgeId = param2;
         _loc5_.glowColor = param3 != null && BadgeRarity.isStandaloneTier(param3.badgeRarityId,_loc7_) ? int(BadgeRarity.getGlowColor(param3.badgeRarityId,_loc7_)) : -1;
         if(param2 != null && param2 != "" && param4 && _loc5_.glowColor >= 0)
         {
            _loc5_.playGlow(uint(_loc5_.glowColor));
         }
      }
      
      private function isUncommonBadgeRarityEnabled() : Boolean
      {
         return UnknownVarFromInfoStandUserView_InfoStandWidget_1 != null && UnknownVarFromInfoStandUserView_InfoStandWidget_1.config != null && UnknownVarFromInfoStandUserView_InfoStandWidget_1.config.getBoolean("badge_rarity.uncommon");
      }
      
      public function clearBadges() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IBadgeImageWidget = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = IWidgetWindowController(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_" + _loc2_)).widget as IBadgeImageWidget;
            _loc1_.badgeId = "";
            _loc2_++;
         }
      }
      
      public function clearGroupBadge() : void
      {
         var _loc1_:IBadgeImageWidget = IWidgetWindowController(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_group")).widget as IBadgeImageWidget;
         _loc1_.badgeId = "";
      }
      
      public function setGroupBadge(param1:String) : void
      {
         var _loc2_:IBadgeImageWidget = IWidgetWindowController(UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_group")).widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      private function onTagSelected(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromInfoStandUserView_InfoStandWidget_1.messageListener.processWidgetMessage(new RoomWidgetRoomTagSearchMessage(_loc2_.text));
      }
      
      public function update(param1:RoomWidgetUserInfoUpdateEvent, param2:Boolean = true, param3:Boolean = false) : void
      {
         if(!param3)
         {
            clearBadges();
         }
         clearGroupBadge();
         setGroupBadge(param1.groupBadgeId);
         updateInfo(param1,param2,!param3);
      }
      
      public function setRelationshipStatuses(param1:Map) : void
      {
         var _loc5_:String = null;
         var _loc2_:IWindowModel = null;
         var _loc3_:RelationshipStatusInfo = null;
         var _loc7_:String = null;
         var _loc6_:IWindowModel = null;
         if(!UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1 || !UnknownVarFromInfoStandUserView_InfoStandWidget_1)
         {
            return;
         }
         for each(var _loc4_ in RelationshipStatusEnum.displayableStatuses)
         {
            _loc5_ = RelationshipStatusEnum.statusAsString(_loc4_);
            _loc2_ = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("relationship_" + _loc5_);
            _loc3_ = param1.getValue(_loc4_);
            if(_loc3_)
            {
               _loc2_.visible = _loc3_.friendCount > 0;
               _loc7_ = _loc5_ + "_randomusername";
               _loc6_ = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName(_loc7_);
               if(_loc6_)
               {
                  _loc6_.caption = _loc3_.randomFriendName;
                  _loc6_.id = _loc3_.randomFriendId;
               }
               UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName(_loc5_ + "_others").visible = _loc3_.friendCount > 1;
               UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.registerParameter("infostand.relstatus." + _loc5_ + ".others","amount",(_loc3_.friendCount - 1).toString());
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      protected function updateInfo(param1:RoomWidgetUserInfoUpdateEvent, param2:Boolean = true, param3:Boolean = true) : void
      {
         name = param1.name;
         setMotto(param1.motto,param1.type == "RWUIUE_OWN_USER");
         achievementScore = param1.achievementScore;
         badgesRank = param1.badgesRank;
         carryItem = param1.carryItem;
         xp = param1.xp;
         setFigure(param1.figure);
         if(param3)
         {
            updateBadges(param1.badges,param1.selectedBadges,param2);
         }
      }
      
      public function set badgesRank(param1:int) : void
      {
         var _loc2_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("badges_rank_spacer") as IWindowController_1;
         var _loc5_:IRegionWindow = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("badges_rank_region") as IRegionWindow;
         var _loc3_:ITextWindow = _loc5_.getChildByName("badges_rank_text") as ITextWindow;
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc6_:* = param1 >= 0;
         var _loc4_:Boolean = Boolean(_loc5_.visible);
         _loc2_.visible = _loc6_;
         _loc5_.visible = _loc6_;
         if(_loc6_)
         {
            _loc3_.text = UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalizationWithParams("infostand.text.badges_rank","","rank","#" + param1);
         }
         if(_loc6_ != _loc4_)
         {
            UnknownVarFromInfoStandUserView_IItemListWindow_1.arrangeListItems();
         }
         updateWindow();
      }
      
      private function onBadgesRankClicked(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:Component = null;
         if(param1.type != "WME_CLICK" || UnknownVarFromInfoStandUserView_InfoStandWidget_1 == null || UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData == null || UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.badgesRank < 0)
         {
            return;
         }
         _loc3_ = UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler != null && UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler.container != null ? UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler.container.roomEngine as Component : null;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.context.createLinkEvent(UnknownHabboGroups1.getLink(0,-1,getBadgeLeaderboardPageForCurrentUser()));
      }
      
      private function getBadgeLeaderboardPageForCurrentUser() : int
      {
         return 0;
      }
      
      public function updateBadges(param1:Array, param2:Array, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         clearBadges();
         if(param2 != null && param2.length > 0)
         {
            for each(var _loc4_ in param2)
            {
               if(!(_loc4_ == null || _loc4_.slotIndex < 0 || _loc4_.slotIndex > 4))
               {
                  setBadge(_loc4_.slotIndex,_loc4_.badgeCode,_loc4_,param3);
               }
            }
            return;
         }
         if(param1 == null)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < param1.length && _loc5_ < 5)
         {
            setBadge(_loc5_,param1[_loc5_]);
            _loc5_++;
         }
      }
      
      private function clearBadgeGlowEffects() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IBadgeImageWidget = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = getBadgeWidget(_loc2_);
            if(_loc1_ != null)
            {
               _loc1_.clearGlow();
            }
            _loc2_++;
         }
      }
      
      private function getBadgeWidget(param1:int) : IBadgeImageWidget
      {
         var _loc2_:IWidgetWindowController = UnknownVarFromInfoStandUserView_UnknownICoreWindowComponents6_1.findChildByName("badge_" + param1) as IWidgetWindowController;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.widget as IBadgeImageWidget;
      }
      
      protected function onMottoKeyboard(param1:WindowKeyboardEvent) : void
      {
         var _loc5_:RoomWidgetChangeMottoMessage = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("motto_container") as IWindowController_1;
         if(!_loc7_)
         {
            return;
         }
         var _loc4_:ITextFieldWindow = _loc7_.findChildByName("motto_text") as ITextFieldWindow;
         var _loc3_:String = _loc4_.text;
         if(param1.keyCode == 13)
         {
            _loc2_ = getTimer();
            if(_loc2_ - UnknownVarFromInfoStandUserView_Int_1 > 2000 && _loc3_ != UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization("infostand.motto.change"))
            {
               _loc6_ = UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.userId;
               _loc5_ = new RoomWidgetChangeMottoMessage(_loc3_);
               UnknownVarFromInfoStandUserView_InfoStandWidget_1.messageListener.processWidgetMessage(_loc5_);
               UnknownVarFromInfoStandUserView_Int_1 = _loc2_;
               _loc4_.textColor = 16777215;
               _loc4_.unfocus();
            }
         }
         else
         {
            _loc4_.textColor = 11184810;
         }
         _loc4_.height = Math.min(_loc4_.textHeight + 5,50);
         _loc4_.height = Math.max(_loc4_.height,23);
         _loc7_.height = _loc4_.height + 3;
      }
      
      protected function onMottoClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindowController_1 = UnknownVarFromInfoStandUserView_IItemListWindow_1.getListItemByName("motto_container") as IWindowController_1;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:ITextWindow = _loc3_.findChildByName("motto_text") as ITextWindow;
         if(_loc2_.text == UnknownVarFromInfoStandUserView_InfoStandWidget_1.localizations.getLocalization("infostand.motto.change"))
         {
            _loc2_.text = "";
         }
         _loc2_.textColor = 11184810;
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:RoomWidgetMessage = null;
         var _loc4_:String = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc5_:* = _loc2_.name;
         if("home_icon" === _loc5_)
         {
            _loc4_ = "RWUAM_OPEN_HOME_PAGE";
         }
         if(_loc4_ != null)
         {
            _loc3_ = new RoomWidgetUserActionMessage(_loc4_,UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.userId);
            HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc4_);
         }
         if(_loc3_ != null)
         {
            UnknownVarFromInfoStandUserView_InfoStandWidget_1.messageListener.processWidgetMessage(_loc3_);
         }
         updateWindow();
      }
      
      protected function onProfileLink(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:ITextWindow = null;
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromInfoStandUserView_InfoStandWidget_1.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",UnknownVarFromInfoStandUserView_InfoStandWidget_1.userData.userId,"infoStand_userView"));
         }
         if(param2.name == "profile_link")
         {
            if(param1.type == "WME_OVER")
            {
               _loc3_ = UnknownVarFromInfoStandUserView_IRegionWindow_1.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 9552639;
            }
            if(param1.type == "WME_OUT")
            {
               _loc3_ = UnknownVarFromInfoStandUserView_IRegionWindow_1.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 16777215;
            }
         }
      }
      
      private function onRelationshipUserNameLinkClicked(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && param2 is ITextLinkWindow)
         {
            UnknownVarFromInfoStandUserView_InfoStandWidget_1.handler.container.connection.send(new GetExtendedProfileMessageComposer(param2.id));
         }
      }
   }
}

