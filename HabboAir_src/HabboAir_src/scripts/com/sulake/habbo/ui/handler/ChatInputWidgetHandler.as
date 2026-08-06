package com.sulake.habbo.ui.handler
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredUpdateRoomComposer;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.RoomShakingEffect;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.ui.Mouse;
   
   public class ChatInputWidgetHandler implements IRoomWidgetHandler
   {
      private static const EXPRESSION_67_ENABLED_KEY:String = "avatar.expression.67.enabled";
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromChatInputWidgetHandler_Boolean_1:Boolean = true;
      
      private var _demonicTriggers:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1:RoomChatInputWidget;
      
      public function ChatInputWidgetHandler()
      {
         super();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:RoomChatInputWidget) : void
      {
         UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_INPUT_WIDGET";
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
         UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1 = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWCTM_TYPING_STATUS");
         _loc1_.push("RWCM_MESSAGE_CHAT");
         _loc1_.push("RWCSAM_MESSAGE_SELECT_AVATAR");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:* = null;
         var _loc23_:int = 0;
         var _loc26_:int = 0;
         var _loc32_:RoomWidgetChatTypingMessage = null;
         var _loc27_:RoomWidgetChatMessage = null;
         var _loc7_:String = null;
         var _loc28_:RoomWidgetRequestWidgetMessage = null;
         var _loc33_:Array = null;
         var _loc18_:String = null;
         var _loc34_:String = null;
         var _loc35_:int = 0;
         var _loc6_:IUserData = null;
         var _loc22_:int = 0;
         var _loc13_:IUserData = null;
         var _loc20_:IUserData = null;
         var _loc12_:IUserData = null;
         var _loc24_:IUserData = null;
         var _loc31_:IUserData = null;
         var _loc16_:HabboToolbarEvent = null;
         var _loc4_:String = null;
         var _loc8_:GuestRoomData = null;
         var _loc2_:Date = null;
         var _loc29_:String = null;
         var _loc11_:Array = null;
         var _loc30_:Array = null;
         var _loc19_:Array = null;
         var _loc15_:IFurnitureData = null;
         var _loc17_:int = 0;
         var _loc5_:IRoomObjectSpriteVisualization = null;
         var _loc25_:int = 0;
         var _loc14_:IRoomObjectSprite = null;
         var _loc21_:int = 0;
         var _loc9_:RoomWidgetChatSelectAvatarMessage = null;
         var _loc10_:IUserData = null;
         switch(param1.type)
         {
            case "RWCTM_TYPING_STATUS":
               _loc32_ = param1 as RoomWidgetChatTypingMessage;
               if(_loc32_ != null)
               {
                  if(this._container.windowManager.LilithCustomsInstance.ChatTypingEnabled == false)
                  {
                     return null;
                  }
                  _container.roomSession.sendChatTypingMessage(_loc32_.isTyping);
               }
               break;
            case "RWCM_MESSAGE_CHAT":
               if(_container != null && _container.roomSession != null)
               {
                  _loc27_ = param1 as RoomWidgetChatMessage;
                  if(_loc27_ != null)
                  {
                     if(_loc27_.text == "")
                     {
                        return null;
                     }
                     _loc7_ = _loc27_.text;
                     if(this._container.windowManager.LilithCustomsInstance.ParseChatInput(param1) == false)
                     {
                        return null;
                     }
                     _loc28_ = null;
                     _loc33_ = _loc27_.text.split(" ");
                     if(_loc33_.length > 0)
                     {
                        _loc18_ = _loc33_[0];
                        _loc34_ = "";
                        if(_loc33_.length > 1)
                        {
                           _loc34_ = _loc33_[1];
                        }
                        if(_loc18_.charAt(0) == ":" && _loc34_ == "x")
                        {
                           _loc35_ = _container.roomEngine.getSelectedAvatarId();
                           if(_loc35_ > -1)
                           {
                              _loc6_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc35_);
                              if(_loc6_ != null)
                              {
                                 _loc34_ = _loc6_.name;
                                 _loc7_ = _loc27_.text.replace(" x"," " + _loc6_.name);
                              }
                           }
                        }
                        switch(_loc18_.toLowerCase())
                        {
                           case ":shake":
                              RoomShakingEffect.init(250,5000);
                              RoomShakingEffect.turnVisualizationOn();
                              return null;
                           case ":d":
                           case ";d":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.LAUGH.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","laugh");
                              }
                              break;
                           case ":kiss":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.BLOW.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","blow");
                                 return null;
                              }
                              break;
                           case ":67":
                              if(_container.config.getBoolean("avatar.expression.67.enabled") && _container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.EXPRESSION_67.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","67");
                                 return null;
                              }
                              break;
                           case ":jump":
                              if(_container.sessionDataManager.hasVip)
                              {
                                 _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.JUMP.ordinal);
                                 HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","jump");
                                 return null;
                              }
                              break;
                           case ":news":
                              if(_container.config.getBoolean("client.news.embed.enabled"))
                              {
                                 HabboWebTools.openNews();
                                 return null;
                              }
                              break;
                           case ":mail":
                              if(_container.config.getBoolean("client.minimail.embed.enabled"))
                              {
                                 HabboWebTools.openMinimail("#mail/inbox/");
                                 return null;
                              }
                              break;
                           case ":crashme":
                           case ":resethunt":
                           case ":ss":
                           case ":qss":
                           case ":gd":
                              break;
                           case ":csmm":
                              if(_container.sessionDataManager.hasSecurity(4))
                              {
                                 _container.gameManager.generateChecksumMismatch();
                                 return null;
                              }
                              break;
                           case ":tgl":
                           case ":li":
                              break;
                           case ":kick":
                              if(!container.sessionDataManager.hasSecurity(4))
                              {
                                 if(1 >= 1)
                                 {
                                    _loc13_ = _container.roomSession.userDataManager.getUserDataByName(_loc34_);
                                    if(_loc13_)
                                    {
                                       _container.roomSession.kickUser(_loc13_.webID);
                                    }
                                 }
                                 return null;
                              }
                              break;
                           case ":shutup":
                           case ":mute":
                              if(!_container.sessionDataManager.hasSecurity(4))
                              {
                                 if(1 >= 1)
                                 {
                                    _loc20_ = _container.roomSession.userDataManager.getUserDataByName(_loc34_);
                                    if(_loc20_)
                                    {
                                       _container.roomSession.muteUser(_loc20_.webID,2);
                                    }
                                 }
                                 return null;
                              }
                              break;
                           case ":link":
                           case ":rewardtrack":
                           case ":q":
                           default:
                              break;
                           case "o/":
                           case "_o/":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.WAVE.ordinal);
                              return null;
                           case ":idle":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.UnknownConstFromAvatarExpressionEnum_AvatarExpressionEnum_1.ordinal);
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","idle");
                              return null;
                           case "_b":
                              _container.roomSession.sendAvatarExpressionMessage(AvatarExpressionEnum.RESPECT.ordinal);
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","respect");
                              return null;
                           case ":showstats":
                              _container.roomEngine.setFpsCounterEnabled(true);
                              return null;
                           case ":ping":
                              if(_container.roomSessionManager != null && _container.roomSessionManager.events != null && _container.roomSession != null)
                              {
                                 _loc22_ = int(_container.habboTracking != null ? _container.habboTracking.latencyPingMs : -1);
                                 _container.roomSessionManager.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_container.roomSession,_container.roomSession.ownUserRoomId,"",11,1,null,_loc22_));
                              }
                              return null;
                           case ":fps":
                              (_container.roomEngine as Component).context.displayObjectContainer.stage.frameRate = int(_loc34_);
                              return null;
                           case ":sign":
                              _container.roomSession.sendSignMessage(int(_loc34_));
                              HabboTracking.getInstance().trackEventLog("OwnAvatarMenu","chat","sign",null,int(_loc34_));
                              return null;
                           case ":drop":
                           case ":dropitem":
                              _loc28_ = new RoomWidgetRequestWidgetMessage("RWUAM_DROP_CARRY_ITEM");
                              _container.processWidgetMessage(_loc28_);
                              return null;
                           case ":chooser":
                              if(!_container.roomEngine.activeRoomHasChooserDisabled || 1 >= 1)
                              {
                                 _loc28_ = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
                                 _container.processWidgetMessage(_loc28_);
                              }
                              return null;
                           case ":furni":
                              if(1 >= 1 || _container.sessionDataManager.hasSecurity(2) || _container.sessionDataManager.isAmbassador)
                              {
                                 _loc28_ = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER");
                                 _container.processWidgetMessage(_loc28_);
                              }
                              return null;
                           case ":pickall":
                              _container.sessionDataManager.pickAllFurniture(_container.roomSession.roomId);
                              return null;
                           case ":pickallbc":
                              _container.sessionDataManager.pickAllBuilderFurniture(_container.roomSession.roomId);
                              return null;
                           case ":resetscores":
                              _container.sessionDataManager.resetScores(_container.roomSession.roomId);
                              return null;
                           case ":ejectall":
                              _container.sessionDataManager.ejectAllFurniture(_container.roomSession.roomId,_loc7_);
                              return null;
                           case ":ejectpets":
                              _container.sessionDataManager.ejectPets(_container.roomSession.roomId);
                              return null;
                           case ":reload":
                              if(_container.roomSession.roomControllerLevel >= 4 || _container.sessionDataManager.hasSecurity(5))
                              {
                                 _container.windowManager.confirm("${wiredmenu.settings.room_state.reload}","${wiredmenu.settings.room_state.reload.warning}",0,onReloadConfirmed);
                              }
                              return null;
                           case ":rollback":
                              if(_container.roomSession.roomControllerLevel >= 4 || _container.sessionDataManager.hasSecurity(5))
                              {
                                 _container.windowManager.confirm("${wiredmenu.settings.room_state.roll_back}","${wiredmenu.settings.room_state.roll_back.warning}",0,onRollbackConfirmed).titleBarColor = 13909337;
                              }
                              return null;
                           case ":moonwalk":
                              _container.sessionDataManager.sendSpecialCommandMessage(":moonwalk");
                              return null;
                           case ":habnam":
                              _container.sessionDataManager.sendSpecialCommandMessage(":habnam");
                              return null;
                           case ":yyxxabxa":
                              _container.sessionDataManager.sendSpecialCommandMessage(":yyxxabxa");
                              return null;
                           case ":mutepets":
                              _container.sessionDataManager.sendSpecialCommandMessage(":mutepets");
                              return null;
                           case ":mpgame":
                              _container.sessionDataManager.sendSpecialCommandMessage(_loc7_);
                              return null;
                           case ":wiredreset":
                              _container.userDefinedRoomEvents.resetCache();
                              return null;
                           case ":ignore":
                              if(_loc34_)
                              {
                                 _loc12_ = _container.roomSession.userDataManager.getUserDataByName(_loc34_);
                                 if(_loc12_)
                                 {
                                    _container.sessionDataManager.ignoreUser(_loc12_.webID);
                                 }
                              }
                              return null;
                           case ":unignore":
                              if(_loc34_)
                              {
                                 _loc24_ = _container.roomSession.userDataManager.getUserDataByName(_loc34_);
                                 if(_loc24_)
                                 {
                                    _container.sessionDataManager.unignoreUser(_loc24_.webID);
                                 }
                              }
                              return null;
                           case ":floor":
                           case ":bcfloor":
                              if(3 >= 3)
                              {
                                 _container.windowManager.displayFloorPlanEditor();
                              }
                              return null;
                           case ":lang":
                              (_container.localization as ICoreLocalizationManager).activateLocalizationDefinition(_loc34_);
                              return null;
                           case ":uc":
                              if(_container.sessionDataManager.hasSecurity(4))
                              {
                                 if(_loc34_ == "hotel")
                                 {
                                    _container.roomSession.sendPeerUsersClassificationMessage(_loc33_[2]);
                                 }
                                 else
                                 {
                                    _container.roomSession.sendRoomUsersClassificationMessage(_loc34_);
                                 }
                              }
                              return null;
                           case ":anew":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 _container.roomSession.sendRoomUsersClassificationMessage("new");
                              }
                              return null;
                           case ":avisit":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 if("group" == _loc34_)
                                 {
                                    (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/predefined_group_lobby");
                                 }
                                 else
                                 {
                                    (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                                 }
                              }
                              return null;
                           case ":aalert":
                              if(_container.sessionDataManager.isAmbassador || _container.sessionDataManager.hasSecurity(4))
                              {
                                 _loc31_ = _container.roomSession.userDataManager.getUserDataByName(_loc34_);
                                 if(_loc31_)
                                 {
                                    _container.roomSession.ambassadorAlert(_loc31_.webID);
                                 }
                              }
                              return null;
                           case ":visit":
                              _container.roomSession.sendVisitUserMessage(_loc34_);
                              return null;
                           case ":roomid":
                              _container.roomSession.sendVisitFlatMessage(parseInt(_loc34_));
                              return null;
                           case ":zoom":
                              _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,Number(_loc34_)));
                              return null;
                           case ":cam":
                           case ":camera":
                              if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
                              {
                                 _loc16_ = new HabboToolbarEvent("HTE_ICON_CAMERA");
                                 _loc16_.iconName = "chatCameraCommand";
                                 _container.toolbar.events.dispatchEvent(_loc16_);
                              }
                              return null;
                           case ":fs":
                           case ":fullscreen":
                              _container.windowManager.toggleFullScreen();
                              return null;
                           case ":screenshot":
                              _loc8_ = _container.navigator.enteredGuestRoomData;
                              if(_loc8_)
                              {
                                 _loc4_ = _loc8_.roomName;
                              }
                              if(_loc4_ == null || _loc4_.length == 0)
                              {
                                 _loc2_ = new Date();
                                 _loc29_ = [_loc2_.getFullYear(),_loc2_.getMonth(),_loc2_.getDate()].join("-") + " " + [_loc2_.getHours(),_loc2_.getMinutes(),_loc2_.getSeconds()].join(".");
                                 _loc4_ = "Habbo " + _loc29_;
                              }
                              _container.roomEngine.createScreenShot(_container.roomSession.roomId,_container.getFirstCanvasId(),_loc4_ + ".png");
                              return null;
                           case ":iddqd":
                              _container.roomEngine.events.dispatchEvent(new RoomEngineZoomEvent(_container.roomEngine.activeRoomId,-1,true));
                              return null;
                           case ":hidemouse":
                              if(UnknownVarFromChatInputWidgetHandler_Boolean_1)
                              {
                                 Mouse.hide();
                                 _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,0);
                              }
                              else
                              {
                                 Mouse.show();
                                 _container.roomEngine.setTileCursorState(_container.roomEngine.activeRoomId,1);
                              }
                              _container.roomEngine.toggleTileCursorVisibility(_container.roomEngine.activeRoomId,!UnknownVarFromChatInputWidgetHandler_Boolean_1);
                              UnknownVarFromChatInputWidgetHandler_Boolean_1 = !UnknownVarFromChatInputWidgetHandler_Boolean_1;
                              return null;
                           case ":wf":
                           case ":wired":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open");
                              return null;
                           case ":var":
                           case ":variables":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open/variable_overview");
                              return null;
                           case ":inspect":
                           case ":inspection":
                              (_container.roomEngine as Component).context.createLinkEvent("wiredmenu/open/inspection");
                              return null;
                           case ":playtest":
                              _container.userDefinedRoomEvents.switchPlayTestMode();
                              return null;
                           case ":donate":
                              (_container.roomEngine as Component).context.createLinkEvent("selfdonation/open");
                              return null;
                           case ":demonictriggers":
                              _loc11_ = _container.roomEngine.getObjectsByCategory(10);
                              _demonicTriggers = !_demonicTriggers;
                              _loc30_ = [];
                              if(_demonicTriggers)
                              {
                                 _loc19_ = [-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0];
                                 _loc30_ = [new ColorMatrixFilter(_loc19_)];
                              }
                              for each(var _loc36_ in _loc11_)
                              {
                                 _loc17_ = int(_loc36_.getModel().getNumber("furniture_type_id"));
                                 _loc15_ = _container.sessionDataManager.getFloorItemData(_loc17_);
                                 if(_loc15_.className.indexOf("wf_trg_") == 0)
                                 {
                                    _loc5_ = _loc36_.getVisualization() as IRoomObjectSpriteVisualization;
                                    _loc25_ = 0;
                                    while(_loc25_ < _loc5_.spriteCount)
                                    {
                                       _loc14_ = _loc5_.getSprite(_loc25_);
                                       if(_loc14_.blendMode != "add")
                                       {
                                          _loc14_.filters = _loc30_;
                                       }
                                       _loc25_++;
                                    }
                                 }
                              }
                              return null;
                        }
                     }
                     _loc21_ = _loc27_.styleId;
                     if(_container != null && _container.roomSession != null)
                     {
                        if(this._container.freeFlowChat != null)
                        {
                           if(this._container.freeFlowChat.preferedChatStyle != _loc27_.styleId && _loc27_.styleId != -1)
                           {
                              this._container.freeFlowChat.preferedChatStyle = _loc27_.styleId;
                           }
                           _loc21_ = this._container.freeFlowChat.preferedChatStyle;
                        }
                        switch(_loc27_.chatType)
                        {
                           case 0:
                              _container.roomSession.sendChatMessage(_loc7_,_loc21_);
                              break;
                           case 1:
                              _container.roomSession.sendWhisperMessage(_loc27_.recipientName,_loc7_,_loc21_);
                              break;
                           case 2:
                              _container.roomSession.sendShoutMessage(_loc7_,_loc21_);
                        }
                        HabboTracking.getInstance().trackEventLogOncePerSession("Tutorial","interaction","avatar.chat");
                     }
                  }
               }
               break;
            case "RWCSAM_MESSAGE_SELECT_AVATAR":
               _loc9_ = param1 as RoomWidgetChatSelectAvatarMessage;
               if(_loc9_ != null)
               {
                  _container.roomEngine.selectAvatar(_loc9_.roomId,_loc9_.objectId);
                  _loc10_ = _container.roomSession.userDataManager.getUserDataByIndex(_loc9_.objectId);
                  if(_loc10_ != null)
                  {
                     _container.moderation.userSelected(_loc10_.webID,_loc9_.userName);
                  }
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSCE_FLOOD_EVENT","hrwe_hide_room_widget","FBE_BAR_RESIZE_EVENT","SDTWE_PURCHASABLE_STYLES_UPDATED"];
      }
      
      public function update() : void
      {
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:RoomSessionChatEvent = null;
         var _loc2_:int = 0;
         var _loc4_:FriendBarResizeEvent = null;
         var _loc5_:Event = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSCE_FLOOD_EVENT":
               _loc3_ = param1 as RoomSessionChatEvent;
               _loc2_ = parseInt(_loc3_.text);
               _loc5_ = new RoomWidgetFloodControlEvent(_loc2_);
               break;
            case "FBE_BAR_RESIZE_EVENT":
               _loc4_ = param1 as FriendBarResizeEvent;
               UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1.checkChatInputPosition();
               break;
            case "SDTWE_PURCHASABLE_STYLES_UPDATED":
               UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1.refreshChatStyles();
               break;
            default:
               break;
            case "hrwe_hide_room_widget":
               handleHideWidgetEvent(param1 as HideRoomWidgetEvent);
               return;
         }
         if(_container != null && _container.events != null && _loc5_ != null)
         {
            _container.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onRollbackConfirmed(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            _container.connection.send(new WiredUpdateRoomComposer(true));
         }
         param1.dispose();
      }
      
      private function onReloadConfirmed(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            _container.connection.send(new WiredUpdateRoomComposer(false));
         }
         param1.dispose();
      }
      
      private function handleHideWidgetEvent(param1:HideRoomWidgetEvent) : void
      {
         if(param1 && param1.widgetType == this.type)
         {
            UnknownVarFromChatInputWidgetHandler_RoomChatInputWidget_1.hide();
         }
      }
   }
}

