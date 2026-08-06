package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   
   public class AvatarMenuView extends AvatarContextInfoButtonView
   {
      protected static const MODE_ACTIONS:uint = 1;
      
      protected static const MODE_MODERATE:uint = 2;
      
      protected static const MODE_BAN:uint = 4;
      
      protected static const MODE_MUTE:uint = 5;
      
      protected static const MODE_RELATIONSHIP:uint = 6;
      
      protected static const MODE_AMBASSADOR:uint = 7;
      
      protected static var lastViewMode:uint = 1;
      
      protected var UnknownVarFromAvatarMenuView_AvatarInfoData_1:AvatarInfoData;
      
      protected var _mode:uint = 1;
      
      protected var UnknownVarFromAvatarMenuView_Boolean_1:Boolean;
      
      public function AvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
      }
      
      public static function setup(param1:AvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:AvatarInfoData) : void
      {
         param1.UnknownVarFromAvatarMenuView_AvatarInfoData_1 = param6;
         param1._mode = 1;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         UnknownVarFromAvatarMenuView_AvatarInfoData_1 = null;
         super.dispose();
      }
      
      protected function updateButtons() : void
      {
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:AvatarInfoWidgetHandler = null;
         var _loc11_:Boolean = false;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc12_:IRoomObject = null;
         var _loc7_:int = 0;
         if(!_window || !UnknownVarFromAvatarMenuView_AvatarInfoData_1)
         {
            return;
         }
         var _loc4_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc4_)
         {
            return;
         }
         _loc4_.procedure = buttonEventProc;
         _loc4_.autoArrangeItems = false;
         var _loc8_:int = _loc4_.numListItems;
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc4_.getListItemAt(_loc10_).visible = false;
            _loc10_++;
         }
         var _loc9_:Boolean = UnknownVarFromAvatarMenuView_AvatarInfoData_1.isBlocked;
         if(_mode == 1)
         {
            showButton("open_profile",_loc9_);
            showButton("moderate",moderateMenuHasContent());
            showButton("friend",UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeAskedAsFriend && !_loc9_);
            showButton("ignore",!UnknownVarFromAvatarMenuView_AvatarInfoData_1.isIgnored && !_loc9_);
            showButton("unignore",UnknownVarFromAvatarMenuView_AvatarInfoData_1.isIgnored && !_loc9_);
            showButton("report",widget.configuration && widget.configuration.getBoolean("infostand.report.show") && !_loc9_);
            _loc5_ = UnknownVarFromAvatarMenuView_AvatarInfoData_1.respectLeft;
            _loc1_ = UnknownVarFromAvatarMenuView_AvatarInfoData_1.respectReplenishesLeft;
            widget.localizations.registerParameter("infostand.button.respect","count",_loc5_.toString());
            showButton("respect",_loc5_ > 0 && !_loc9_);
            showButton("replenish_respect",_loc5_ <= 0 && _loc1_ > 0 && !_loc9_);
            _loc2_ = widget.handler;
            _loc11_ = _loc2_.container.sessionDataManager.isAccountSafetyLocked();
            showButton("trade",citizenshipTalentTrackEnabled || !_loc11_ && UnknownVarFromAvatarMenuView_AvatarInfoData_1.canTrade && !_loc9_);
            switch(UnknownVarFromAvatarMenuView_AvatarInfoData_1.canTradeReason - 2)
            {
               case 0:
                  _loc6_ = "${infostand.button.trade.tooltip.shutdown}";
                  break;
               case 1:
                  _loc6_ = "${infostand.button.trade.tooltip.tradingroom}";
                  break;
               default:
                  _loc6_ = "";
            }
            IInteractiveWindow(IWindowController_1(_loc4_.getListItemByName("trade")).getChildByName("button")).toolTipCaption = _loc6_;
            showButton("whisper",!_loc9_);
            if(widget.configuration.getBoolean("handitem.give.enabled") && !_loc2_.container.roomEngine.activeRoomHasHanditemControlBlocked)
            {
               _loc3_ = _loc2_.container.roomSession.ownUserRoomId;
               _loc12_ = _loc2_.container.roomEngine.getRoomObject(_loc2_.roomSession.roomId,_loc3_,100);
               if(_loc12_ != null)
               {
                  _loc7_ = _loc12_.getModel().getNumber("figure_carry_object");
                  if(_loc7_ > 0 && _loc7_ < 999999)
                  {
                     showButton("pass_handitem");
                  }
               }
            }
            showButton("relationship",widget.configuration.getBoolean("relationship.status.enabled") && UnknownVarFromAvatarMenuView_AvatarInfoData_1.isFriend && !_loc9_);
            showButton("ambassador",ambassadorMenuHasContent());
            showButton("wired_inspect",_loc2_.container.userDefinedRoomEvents.showInspectButton());
         }
         if(_mode == 2)
         {
            showButton("kick",UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeKicked);
            showButton("ban_with_duration",UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeBanned);
            showButton("mute",UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeMuted);
            showButton("give_rights",isShowGiveRights());
            showButton("remove_rights",isShowRemoveRights());
            showButton("actions");
         }
         if(_mode == 4)
         {
            showButton("ban_hour");
            showButton("ban_day");
            showButton("perm_ban");
            showButton("actions");
         }
         if(_mode == 5)
         {
            showButton("mute_2min");
            showButton("mute_5min");
            showButton("mute_10min");
            showButton("actions");
         }
         if(_mode == 6)
         {
            showButtonGrid("relationship_grid");
            showButton("no_relationship");
            showButton("actions");
         }
         if(_mode == 7)
         {
            showButton("ambassador_kick");
            showButton("ambassador_alert");
            showButton("ambassador_mute_15min");
            showButton("ambassador_mute_60min");
            showButton("ambassador_mute_18hour");
            showButton("ambassador_mute_36hour");
            showButton("ambassador_mute_72hour");
            showButton("ambassador_unmute");
            showButton("actions");
         }
         _loc4_.autoArrangeItems = true;
         _loc4_.visible = true;
         lastViewMode = _mode;
         UnknownVarFromAvatarMenuView_Boolean_1 = false;
      }
      
      private function ambassadorMenuHasContent() : Boolean
      {
         return UnknownVarFromAvatarMenuView_AvatarInfoData_1.isAmbassador;
      }
      
      private function moderateMenuHasContent() : Boolean
      {
         return UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeKicked || UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeBanned || UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeMuted || isShowGiveRights() || isShowRemoveRights();
      }
      
      private function isShowGiveRights() : Boolean
      {
         return UnknownVarFromAvatarMenuView_AvatarInfoData_1.amIOwner && UnknownVarFromAvatarMenuView_AvatarInfoData_1.targetRoomControllerLevel < 1;
      }
      
      private function isShowRemoveRights() : Boolean
      {
         return UnknownVarFromAvatarMenuView_AvatarInfoData_1.amIOwner && UnknownVarFromAvatarMenuView_AvatarInfoData_1.targetRoomControllerLevel == 1;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc7_:ITextWindow = null;
         var _loc4_:IItemGridWindow = null;
         var _loc3_:IIterator = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:IWindowController_1 = null;
         var _loc2_:IWindowController_1 = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(UnknownVarFromContextInfoView_Boolean_1)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("avatar_menu_widget")).content as XML;
               _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            UnknownVarFromButtonMenuView_IItemListWindow_1 = _window.findChildByName("buttons") as IItemListWindow;
            UnknownVarFromButtonMenuView_IItemListWindow_1.procedure = buttonEventProc;
            _window.findChildByName("profile_link").procedure = buttonEventProc;
            _loc7_ = _window.findChildByName("name") as ITextWindow;
            if(UnknownVarFromAvatarMenuView_AvatarInfoData_1.isBlocked)
            {
               _loc7_.italic = true;
               _loc7_.caption = "${infostand.blocked_user}";
            }
            else
            {
               _loc7_.italic = false;
               _window.findChildByName("name").caption = _userName;
            }
            _window.visible = false;
            activeView = _window;
            updateButtons();
            updateRelationshipStatus();
            _loc4_ = _window.findChildByName("relationship_grid") as IItemGridWindow;
            _loc3_ = _loc4_.iterator;
            _loc5_ = int(_loc3_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = _loc3_[_loc6_] as IWindowController_1;
               _loc2_ = _loc8_.findChildByName("button") as IWindowController_1;
               _loc2_.procedure = buttonEventProc;
               _loc6_++;
            }
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc6_:String = null;
         var _loc4_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc5_:RoomWidgetMessage = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "whisper":
                     _loc6_ = "RWUAM_WHISPER_USER";
                     break;
                  case "friend":
                     param2.disable();
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.canBeAskedAsFriend = false;
                     _loc6_ = "RWUAM_SEND_FRIEND_REQUEST";
                     break;
                  case "respect":
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.respectLeft -= 1;
                     _loc4_ = UnknownVarFromAvatarMenuView_AvatarInfoData_1.respectLeft;
                     widget.localizations.registerParameter("infostand.button.respect","count",_loc4_.toString());
                     showButton("respect",UnknownVarFromAvatarMenuView_AvatarInfoData_1.respectLeft > 0);
                     _loc6_ = "RWUAM_RESPECT_USER";
                     if(_loc4_ > 0)
                     {
                        _loc3_ = false;
                     }
                     break;
                  case "replenish_respect":
                     _loc6_ = "RWUAM_REPLENISH_RESPECT_USER";
                     break;
                  case "wired_inspect":
                     _loc6_ = "RWUAM_WIRED_INSPECT";
                     break;
                  case "open_profile":
                     _loc6_ = "RWUAM_OPEN_PROFILE";
                     break;
                  case "ignore":
                     param2.parent.visible = false;
                     _window.findChildByName("unignore").visible = true;
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.isIgnored = true;
                     _loc6_ = "RWUAM_IGNORE_USER";
                     break;
                  case "unignore":
                     param2.parent.visible = false;
                     _window.findChildByName("ignore").visible = true;
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.isIgnored = false;
                     _loc6_ = "RWUAM_UNIGNORE_USER";
                     break;
                  case "kick":
                     _loc6_ = "RWUAM_KICK_USER";
                     break;
                  case "ban_hour":
                     _loc6_ = "RWUAM_BAN_USER_HOUR";
                     break;
                  case "ban_day":
                     _loc6_ = "RWUAM_BAN_USER_DAY";
                     break;
                  case "perm_ban":
                     _loc6_ = "RWUAM_BAN_USER_PERM";
                     break;
                  case "mute_2min":
                     _loc6_ = "RWUAM_MUTE_USER_2MIN";
                     break;
                  case "mute_5min":
                     _loc6_ = "RWUAM_MUTE_USER_5MIN";
                     break;
                  case "mute_10min":
                     _loc6_ = "RWUAM_MUTE_USER_10MIN";
                     break;
                  case "ban_with_duration":
                     _mode = 4;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "mute":
                     _mode = 5;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "give_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("remove_rights").visible = true;
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.myRoomControllerLevel = 1;
                     _loc6_ = "RWUAM_GIVE_RIGHTS";
                     break;
                  case "remove_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("give_rights").visible = true;
                     UnknownVarFromAvatarMenuView_AvatarInfoData_1.myRoomControllerLevel = 0;
                     _loc6_ = "RWUAM_TAKE_RIGHTS";
                     break;
                  case "trade":
                     _loc6_ = "RWUAM_START_TRADING";
                     break;
                  case "moderate":
                     _mode = 2;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "report":
                     _loc6_ = "RWUAM_REPORT_CFH_OTHER";
                     break;
                  case "actions":
                     _mode = 1;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "relationship":
                     _mode = 6;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "pass_handitem":
                     _loc6_ = "RWUAM_PASS_CARRY_ITEM";
                     break;
                  case "relationship_heart":
                     setRelationship(1);
                     break;
                  case "relationship_smile":
                     setRelationship(2);
                     break;
                  case "relationship_bobba":
                     setRelationship(3);
                     break;
                  case "no_relationship":
                     setRelationship(0);
                     break;
                  case "ambassador":
                     _mode = 7;
                     UnknownVarFromAvatarMenuView_Boolean_1 = true;
                     _loc3_ = false;
                     break;
                  case "ambassador_alert":
                     _loc6_ = "RWUAM_AMBASSADOR_ALERT_USER";
                     break;
                  case "ambassador_kick":
                     _loc6_ = "RWUAM_AMBASSADOR_KICK_USER";
                     break;
                  case "ambassador_mute_2min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_2MIN";
                     break;
                  case "ambassador_mute_10min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_10MIN";
                     break;
                  case "ambassador_mute_15min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_15MIN";
                     break;
                  case "ambassador_mute_60min":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_60MIN";
                     break;
                  case "ambassador_mute_18hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_18HOUR";
                     break;
                  case "ambassador_mute_36hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_36HOUR";
                     break;
                  case "ambassador_mute_72hour":
                     _loc6_ = "RWUAM_AMBASSADOR_MUTE_72HOUR";
                     break;
                  case "ambassador_unmute":
                     _loc6_ = "RWUAM_AMBASSADOR_UNMUTE";
               }
            }
            if(param2.name == "profile_link")
            {
               _loc3_ = true;
               _loc5_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",_userId,"avatarContextMenu");
            }
            if(_loc6_ != null)
            {
               _loc5_ = new RoomWidgetUserActionMessage(_loc6_,_userId);
               HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc6_);
            }
            if(_loc5_ != null)
            {
               UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.messageListener.processWidgetMessage(_loc5_);
            }
            updateButtons();
         }
         else if(param1.type == "WME_OVER")
         {
            if(param2.name == "button")
            {
               switch(param2.parent.name)
               {
                  case "kick":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.kick.hover");
                     break;
                  case "perm_ban":
                  case "ban_hour":
                  case "ban_day":
                  case "ban_with_duration":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.ban.hover");
                     break;
                  case "mute":
                  case "mute_2min":
                  case "mute_5min":
                  case "mute_10min":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.mute.hover");
                     break;
                  case "unignore":
                  case "ignore":
                     HabboTracking.getInstance().trackEventLogOncePerSession("InterfaceExplorer","hover","avatar.ignore.hover");
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
      
      private function get citizenshipTalentTrackEnabled() : Boolean
      {
         return AvatarInfoWidget(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1).configuration.getBoolean("talent.track.citizenship.enabled");
      }
      
      private function setRelationship(param1:int) : void
      {
         UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.friendList.setRelationshipStatus(_userId,param1);
      }
   }
}

