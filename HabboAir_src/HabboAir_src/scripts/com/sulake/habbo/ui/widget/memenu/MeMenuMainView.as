package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageParser;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class MeMenuMainView implements IMeMenuView
   {
      public static const VIEW_ELEMENT_TYPE_MINI_MAIL:String = "minimail";
      
      private var UnknownVarFromMeMenuMainView_MeMenuWidget_1:MeMenuWidget;
      
      private var _window:IWindowController_1;
      
      private var _icons:Dictionary;
      
      private var _perkAllowancesMessageEvent:PerkAllowancesMessageEvent;
      
      private var _config:IComponent_1;
      
      public function MeMenuMainView(param1:IComponent_1)
      {
         super();
         _config = param1;
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         _icons = new Dictionary();
         _icons["rooms_icon"] = ["gohome_white","gohome_color"];
         _icons["dance_icon"] = ["dance_white","dance_color"];
         _icons["clothes_icon"] = ["clothes_white","clothes_color"];
         _icons["effects_icon"] = ["effects_white","effects_color"];
         _icons["badges_icon"] = ["badges_white","badges_color"];
         _icons["wave_icon"] = ["wave_white","wave_color"];
         _icons["hc_icon"] = ["_white","_color"];
         _icons["settings_icon"] = ["settings_white","settings_color"];
         _icons["credits_icon"] = ["credits_white","credits_color"];
         _icons["minimail_icon"] = ["minimail_white","minimail_color"];
         _icons["profile_icon"] = ["profile_white","profile_color"];
         _icons["achievements_icon"] = ["achievements_white","achievements_color"];
         _icons["talents_icon"] = ["compass_white","compass_color"];
         _icons["guide_icon"] = ["lighthouse_white","lighthouse_color"];
         UnknownVarFromMeMenuMainView_MeMenuWidget_1 = param1;
         _perkAllowancesMessageEvent = new PerkAllowancesMessageEvent(onPerkAllowances);
         UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.connection.addMessageEvent(_perkAllowancesMessageEvent);
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         if(_perkAllowancesMessageEvent)
         {
            UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.connection.removeMessageEvent(_perkAllowancesMessageEvent);
            _perkAllowancesMessageEvent = null;
         }
         UnknownVarFromMeMenuMainView_MeMenuWidget_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function setIconAssets(param1:String, param2:String, param3:String = null, param4:String = null) : void
      {
         if(_icons[param1] == null)
         {
            return;
         }
         if(param3 != null)
         {
            _icons[param1][0] = param3;
         }
         if(param4 != null)
         {
            _icons[param1][1] = param4;
         }
         setElementImage(param1,param3);
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc12_:Array = null;
         var _loc7_:String = null;
         var _loc3_:Number = NaN;
         var _loc9_:String = null;
         var _loc8_:int = 0;
         var _loc2_:IWindowModel = null;
         var _loc10_:int = 0;
         if(UnknownVarFromMeMenuMainView_MeMenuWidget_1 == null)
         {
            return;
         }
         var _loc5_:String = "memenu_main";
         var _loc6_:Boolean = false;
         if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.config.getBoolean("simple.memenu.enabled"))
         {
            _loc5_ += "_simple";
            _loc6_ = true;
         }
         var _loc4_:XmlAsset = UnknownVarFromMeMenuMainView_MeMenuWidget_1.assets.getAssetByName(_loc5_) as XmlAsset;
         _window = UnknownVarFromMeMenuMainView_MeMenuWidget_1.windowManager.buildFromXML(_loc4_.content as XML) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct me menu main window from XML!");
         }
         _window.name = param1;
         if(!UnknownVarFromMeMenuMainView_MeMenuWidget_1.config.getBoolean("talent.track.enabled") && _loc6_)
         {
            _window.findChildByName("guide").rectangle = _window.findChildByName("talents").rectangle;
            _window.findChildByName("talents").visible = false;
         }
         if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.config.getBoolean("guides.enabled"))
         {
            setGuideToolVisibility(UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL"));
         }
         for(var _loc11_ in _icons)
         {
            _loc12_ = _icons[_loc11_];
            if(!(_loc12_ == null || _loc12_.length == 0))
            {
               _loc7_ = _loc12_[0];
               _loc3_ = 1;
               switch(_loc11_)
               {
                  case "dance_icon":
                  case "wave_icon":
                     if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.hasEffectOn)
                     {
                        _loc3_ = 0.5;
                     }
                     break;
                  case "effects_icon":
                     if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.isDancing)
                     {
                        _loc3_ = 0.5;
                     }
                     break;
                  case "hc_icon":
                     _loc7_ = getClubAssetNameBase() + _loc7_;
                     if(!UnknownVarFromMeMenuMainView_MeMenuWidget_1.isHabboClubActive)
                     {
                        setElementText("hc_text",UnknownVarFromMeMenuMainView_MeMenuWidget_1.localizations.getLocalization("widget.memenu.hc.join"));
                     }
                     else
                     {
                        if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.habboClubLevel == 2)
                        {
                           _loc9_ = "widget.memenu.vip";
                        }
                        else
                        {
                           _loc9_ = "widget.memenu.hc";
                        }
                        if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.habboClubPeriods > 0)
                        {
                           _loc9_ += ".long";
                        }
                        UnknownVarFromMeMenuMainView_MeMenuWidget_1.localizations.registerParameter(_loc9_,"days",String(UnknownVarFromMeMenuMainView_MeMenuWidget_1.habboClubDays));
                        UnknownVarFromMeMenuMainView_MeMenuWidget_1.localizations.registerParameter(_loc9_,"months",String(UnknownVarFromMeMenuMainView_MeMenuWidget_1.habboClubPeriods));
                        setElementText("hc_text",UnknownVarFromMeMenuMainView_MeMenuWidget_1.localizations.getLocalization(_loc9_));
                     }
                     break;
                  case "minimail_icon":
                     if(!UnknownVarFromMeMenuMainView_MeMenuWidget_1.isMinimailEnabled)
                     {
                        _loc3_ = 0.5;
                     }
                     else
                     {
                        _loc8_ = UnknownVarFromMeMenuMainView_MeMenuWidget_1.unreadMiniMailMessageCount;
                        if(_loc8_ == -1 || _loc8_ > 0)
                        {
                           updateUnseenCounter("minimail",_loc8_);
                        }
                     }
               }
               setElementImage(_loc11_,_loc7_,_loc3_);
            }
         }
         _loc10_ = 0;
         while(_loc10_ < _window.numChildren)
         {
            _loc2_ = _window.getChildAt(_loc10_);
            _loc2_.addEventListener("WME_CLICK",onButtonClicked);
            _loc2_.addEventListener("WME_OVER",onMouseOverOrOut);
            _loc2_.addEventListener("WME_OUT",onMouseOverOrOut);
            _loc10_++;
         }
      }
      
      private function updateUnseenCounter(param1:String, param2:int) : void
      {
         var _loc3_:IWindowController_1 = _window.findChildByName(param1) as IWindowController_1;
         var _loc4_:IWindowController_1 = _loc3_.findChildByName("unseen_counter") as IWindowController_1;
         if(param2 == 0)
         {
            if(_loc4_)
            {
               _loc3_.removeChild(_loc4_);
               _loc3_.invalidate();
            }
            return;
         }
         if(!_loc4_)
         {
            _loc4_ = UnknownVarFromMeMenuMainView_MeMenuWidget_1.windowManager.createUnseenItemCounter();
            _loc4_.name = "unseen_counter";
            _loc3_.addChild(_loc4_);
         }
         (_loc4_.findChildByName("count") as ITextWindow).text = param2 > 0 ? param2.toString() : " ";
         _loc4_.x = _loc3_.width - _loc4_.width - 5;
         _loc4_.y = 5;
      }
      
      private function getClubAssetNameBase() : String
      {
         switch(UnknownVarFromMeMenuMainView_MeMenuWidget_1.habboClubLevel)
         {
            case 0:
            case 1:
               return "club";
            case 2:
               return "vip";
            default:
               return null;
         }
      }
      
      private function setElementImage(param1:String, param2:String, param3:Number = 1) : void
      {
         var _loc8_:IBitmapWrapperController = _window.findChildByName(param1) as IBitmapWrapperController;
         var _loc7_:BitmapDataAsset = UnknownVarFromMeMenuMainView_MeMenuWidget_1.assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc8_ == null)
         {
            Logger.log("Could not find element: " + param1);
            return;
         }
         if(_loc7_ == null || _loc7_.content == null)
         {
            Logger.log("Could not find asset: " + param2);
            return;
         }
         var _loc5_:BitmapData = _loc7_.content as BitmapData;
         _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
         var _loc4_:int = (_loc8_.width - _loc5_.width) / 2;
         var _loc6_:int = (_loc8_.height - _loc5_.height) / 2;
         _loc8_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(_loc4_,_loc6_));
         _loc8_.blend = param3;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param2;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc4_:AvatarExpressionEnum = null;
         var _loc5_:String = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "dance":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.hasEffectOn)
               {
                  return;
               }
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.changeView("me_menu_dance_moves_view");
               break;
            case "wave":
            case "blow":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.hasEffectOn)
               {
                  return;
               }
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.isDancing)
               {
                  UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(0));
                  UnknownVarFromMeMenuMainView_MeMenuWidget_1.isDancing = false;
               }
               _loc4_ = AvatarExpressionEnum.WAVE;
               if(_loc3_ == "blow")
               {
                  _loc4_ = AvatarExpressionEnum.BLOW;
               }
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetAvatarExpressionMessage(_loc4_));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "effects":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.isDancing)
               {
                  return;
               }
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "rooms":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetShowOwnRoomsMessage());
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "badges":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage("inventory_badges"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "clothes":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage("RWCM_OPEN_AVATAR_EDITOR"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "hc":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage("RWOCM_CLUB_MAIN"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "settings":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.changeView("me_menu_settings_view");
               break;
            case "minimail":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.isMinimailEnabled)
               {
                  HabboWebTools.openMinimail("#mail/inbox/");
                  UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               }
               break;
            case "credits":
               HabboWebTools.openWebPageAndMinimizeClient(_config.getProperty("web.shop.relativeUrl"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "profile":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",UnknownVarFromMeMenuMainView_MeMenuWidget_1.userId,"me_menu"));
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "achievements":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.questEngine.showAchievements();
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "guide":
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.toolbar.toggleWindowVisibility("GUIDE");
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.hide();
               break;
            case "talents":
               _loc5_ = UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.sessionDataManager.currentTalentTrack;
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.habboTracking.trackTalentTrackOpen(_loc5_,"memenu");
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.handler.container.connection.send(new GetTalentTrackMessageComposer(_loc5_));
               break;
            default:
               Logger.log("Me Menu Main View: unknown button: " + _loc3_);
         }
         HabboTracking.getInstance().trackEventLog("MeMenu","click",_loc3_);
      }
      
      private function onAlertClicked(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onMouseOverOrOut(param1:WindowMouseEvent) : void
      {
         var _loc8_:Array = null;
         var _loc5_:String = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc4_:String = _loc2_.name;
         var _loc7_:String = _loc4_ + "_icon";
         var _loc6_:String = "";
         var _loc3_:int = param1.type == "WME_OVER" ? 1 : 0;
         switch(_loc4_)
         {
            case "dance":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.hasEffectOn)
               {
                  return;
               }
               break;
            case "minimail":
               if(!UnknownVarFromMeMenuMainView_MeMenuWidget_1.isMinimailEnabled)
               {
                  return;
               }
               break;
            case "wave":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.hasEffectOn)
               {
                  return;
               }
               break;
            case "effects":
               if(UnknownVarFromMeMenuMainView_MeMenuWidget_1.isDancing)
               {
                  return;
               }
               break;
            case "hc":
               _loc6_ = getClubAssetNameBase();
         }
         _loc7_ = _loc4_ + "_icon";
         _loc8_ = _icons[_loc7_];
         if(_loc8_ != null)
         {
            _loc5_ = _loc6_ + _loc8_[_loc3_];
            setElementImage(_loc7_,_loc5_);
         }
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:PerkAllowancesMessageParser = param1.getParser();
         setGuideToolVisibility(_loc2_.isPerkAllowed("USE_GUIDE_TOOL"));
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowModel = null;
         if(_window && UnknownVarFromMeMenuMainView_MeMenuWidget_1)
         {
            _loc3_ = _window.findChildByName("guide");
            _loc2_ = _window.findChildByName("achievements");
            if(_loc3_)
            {
               _loc3_.visible = param1;
               _window.height = param1 ? _loc3_.bottom : _loc2_.bottom;
               UnknownVarFromMeMenuMainView_MeMenuWidget_1.updateSize();
            }
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = param1;
         if("minimail" === _loc4_)
         {
            _loc3_ = UnknownVarFromMeMenuMainView_MeMenuWidget_1.unreadMiniMailMessageCount;
            updateUnseenCounter("minimail",_loc3_);
         }
      }
   }
}

