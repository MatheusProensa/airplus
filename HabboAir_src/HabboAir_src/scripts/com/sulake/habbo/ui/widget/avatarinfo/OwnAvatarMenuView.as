package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   
   public class OwnAvatarMenuView extends AvatarContextInfoButtonView
   {
      private static const MODE_NORMAL:int = 0;
      
      private static const MODE_CLUB_DANCES:int = 1;
      
      private static const MODE_NAME_CHANGE:int = 2;
      
      private static const MODE_EXPRESSIONS:int = 3;
      
      private static const MODE_SIGNS:int = 4;
      
      private static const MODE_CHANGE_LOOKS:int = 5;
      
      private static const EXPRESSION_67_ENABLED_KEY:String = "avatar.expression.67.enabled";
      
      private static var UnknownVarFromOwnAvatarMenuView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1:AvatarInfoData;
      
      private var _mode:int;
      
      public function OwnAvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1 as UnknownIHabboUiWidgetContextmenu1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
      }
      
      public static function setup(param1:OwnAvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:AvatarInfoData) : void
      {
         if(param1 == null || param1.widget == null)
         {
            return;
         }
         param1.UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1 = param6;
         if(!UnknownVarFromOwnAvatarMenuView_Boolean_1 && param1.widget.configuration.getInteger("new.identity",0) > 0 && param1.widget.configuration.getBoolean("new.user.reception.enabled"))
         {
            param1._mode = 0;
            OwnAvatarMenuView.UnknownVarFromOwnAvatarMenuView_Boolean_1 = true;
         }
         else if(param1.widget.isDancing && param1.widget.hasClub && !param1.widget.hasEffectOn)
         {
            param1._mode = 1;
         }
         else if(param6.allowNameChange && param1.widget.useMinimizedOwnAvatarMenu)
         {
            param1._mode = 2;
         }
         else
         {
            param1._mode = 0;
         }
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1 = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc4_:IItemGridWindow = null;
         var _loc3_:IIterator = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:IWindowController_1 = null;
         var _loc2_:IWindowController_1 = null;
         var _loc7_:IRegionWindow = null;
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
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("own_avatar_menu")).content as XML;
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
            _loc4_ = _window.findChildByName("signs_grid") as IItemGridWindow;
            _loc3_ = _loc4_.iterator;
            _loc5_ = int(_loc3_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = _loc3_[_loc6_] as IWindowController_1;
               _loc2_ = _loc8_.findChildByName("button") as IWindowController_1;
               _loc2_.procedure = gridEventProc;
               _loc6_++;
            }
            _loc7_ = _window.findChildByName("profile_link") as IRegionWindow;
            if(_loc7_)
            {
               _loc7_.procedure = buttonEventProc;
               _loc7_.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip","Click to view profile");
               _loc7_.toolTipDelay = 100;
            }
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      public function updateButtons() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!_window || !UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1 || !UnknownVarFromButtonMenuView_IItemListWindow_1)
         {
            return;
         }
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = false;
         var _loc3_:int = UnknownVarFromButtonMenuView_IItemListWindow_1.numListItems;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            UnknownVarFromButtonMenuView_IItemListWindow_1.getListItemAt(_loc4_).visible = false;
            _loc4_++;
         }
         var _loc5_:Boolean = widget.isCurrentUserRiding;
         switch(_mode)
         {
            case 0:
               showButton("change_name",UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1.allowNameChange);
               showButton("decorate",decorateModeSupported() && (UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1.myRoomControllerLevel >= 1 || UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1.amIOwner));
               showButton("change_looks");
               showButton("dance_menu",widget.hasClub && !_loc5_,!widget.hasEffectOn);
               showButton("dance",!widget.hasClub && !widget.isDancing && !_loc5_,!widget.hasEffectOn);
               showButton("dance_stop",!widget.hasClub && widget.isDancing && !_loc5_);
               if(!(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager as Component).getBoolean("memenu.effects.widget.disabled"))
               {
                  showButton("effects",!_loc5_);
               }
               showButton("handitem",UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1.carryItemType > 0 && UnknownVarFromOwnAvatarMenuView_AvatarInfoData_1.carryItemType < 999999 && widget.configuration.getBoolean("handitem.drop.enabled") && !widget.handler.roomEngine.activeRoomHasHanditemControlBlocked);
               _loc1_ = widget.configuration.getBoolean("avatar.expressions_menu.enabled");
               showButton(_loc1_ ? "expressions" : "wave");
               _loc2_ = widget.configuration.getBoolean("avatar.signs.enabled");
               showButton("signs",_loc2_);
               showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
               break;
            case 1:
               showButton("dance_stop",true,widget.isDancing);
               showButton("dance_1");
               showButton("dance_2");
               showButton("dance_3");
               showButton("dance_4");
               showButton("back");
               break;
            case 2:
               showButton("change_name");
               showButton("more");
               break;
            case 3:
               showButton("wave",true,!widget.isSwimming);
               showButton("laugh",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("blow",true,!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("67",widget.configuration.getBoolean("avatar.expression.67.enabled"),!widget.hasEffectOn && !widget.isSwimming && widget.hasVip,!widget.hasVip);
               showButton("idle",true);
               if(widget.configuration.getBoolean("avatar.sitting.enabled") && !widget.isSwimming && !_loc5_)
               {
                  showButton("sit",widget.ownAvatarPosture == "std");
                  showButton("stand",widget.canStandUp);
               }
               showButton("back");
               break;
            case 4:
               showButtonGrid("signs_grid");
               showButton("back");
               break;
            case 5:
               showButton("change_looks");
               showButton("more");
         }
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = true;
         UnknownVarFromButtonMenuView_IItemListWindow_1.visible = true;
      }
      
      private function gridEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc4_ = true;
               _loc7_ = "_";
               _loc3_ = !!param2.parent.name ? param2.parent.name : "";
               _loc6_ = _loc3_.substr(0,_loc3_.lastIndexOf(_loc7_));
               _loc5_ = parseInt(_loc3_.substr(_loc3_.lastIndexOf(_loc7_) + 1));
               var _loc8_:* = _loc6_;
               if("sign" === _loc8_)
               {
                  widget.sendSignRequest(_loc5_);
                  HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sign",null,_loc5_);
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc4_)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:RoomWidgetMessage = null;
         var _loc5_:IWindowModel = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc5_ = (param2 as IWindowController_1).getChildByName("icon_vip");
               if(_loc5_ != null && _loc5_.visible && !widget.hasVip)
               {
                  UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.catalog.openClubCenter();
                  return;
               }
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "change_name":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE");
                     break;
                  case "decorate":
                     if(decorateModeSupported())
                     {
                        widget.isUserDecorating = true;
                     }
                     break;
                  case "change_looks":
                     widget.openAvatarEditor();
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","clothes");
                     break;
                  case "expressions":
                     _loc3_ = false;
                     changeMode(3);
                     break;
                  case "sit":
                     _loc4_ = new RoomWidgetChangePostureMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","sit");
                     break;
                  case "stand":
                     _loc4_ = new RoomWidgetChangePostureMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","stand");
                     break;
                  case "wave":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.WAVE);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","wave");
                     break;
                  case "blow":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.BLOW);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","blow");
                     break;
                  case "67":
                     if(widget.configuration.getBoolean("avatar.expression.67.enabled"))
                     {
                        _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.EXPRESSION_67);
                        HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","67");
                     }
                     break;
                  case "jump":
                     break;
                  case "laugh":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.LAUGH);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","laugh");
                     break;
                  case "idle":
                     _loc4_ = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.UnknownConstFromAvatarExpressionEnum_AvatarExpressionEnum_1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","idle");
                     break;
                  case "dance_menu":
                     _loc3_ = false;
                     changeMode(1);
                     break;
                  case "dance":
                     _loc4_ = new RoomWidgetDanceMessage(1);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "dance_stop":
                     _loc4_ = new RoomWidgetDanceMessage(0);
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_stop");
                     break;
                  case "dance_1":
                  case "dance_2":
                  case "dance_3":
                  case "dance_4":
                     _loc4_ = new RoomWidgetDanceMessage(parseInt(param2.parent.name.charAt(param2.parent.name.length - 1)));
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","dance_start");
                     break;
                  case "effects":
                     _loc4_ = new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS");
                     HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","click","effects");
                     break;
                  case "signs":
                     _loc3_ = false;
                     changeMode(4);
                     break;
                  case "back":
                     _loc3_ = false;
                     changeMode(0);
                     break;
                  case "more":
                     _loc3_ = false;
                     widget.useMinimizedOwnAvatarMenu = false;
                     changeMode(0);
                     break;
                  case "handitem":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_DROP_CARRY_ITEM",_userId);
                     break;
                  case "wired_inspect":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT",_userId);
               }
            }
            if(param2.name == "profile_link")
            {
               _loc3_ = true;
               _loc4_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",userId,"ownAvatarContextMenu");
            }
            if(_loc4_)
            {
               UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.messageListener.processWidgetMessage(_loc4_);
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_ && !_disposed)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
      
      private function changeMode(param1:int) : void
      {
         _mode = param1;
         updateButtons();
      }
      
      private function decorateModeSupported() : Boolean
      {
         return widget.hasClub;
      }
   }
}

