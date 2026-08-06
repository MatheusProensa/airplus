package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetZoomToggleMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   
   public class RoomToolsToolbarCtrl extends RoomToolsCtrlBase implements IProfiler_1
   {
      private static const TOOLBAR_EXPAND_TARGET_X:int = 1;
      
      private static const ANIMATION_DURATION_MS:int = 140;
      
      private static const ROOM_MOUSE_BLOCK_HANDLE_ID:String = "room_tools_toolbar";
      
      private var UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1:RoomToolsHistory;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Boolean_1:Boolean = false;
      
      private var _isRegisteredForUpdates:Boolean = false;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Number_1:Number = 0;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Number_2:Number = 0;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Int_1:int = 0;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Int_2:int = 0;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Boolean_2:Boolean = false;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_String_1:String = "";
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Boolean_3:Boolean = false;
      
      private var UnknownVarFromRoomToolsToolbarCtrl_Boolean_4:Boolean = false;
      
      public function RoomToolsToolbarCtrl(param1:RoomToolsWidget, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super(param1,param2,param3);
         _window = param2.buildFromXML(param3.getAssetByName("room_tools_toolbar_xml").content as XML) as IWindowController_1;
         _window.procedure = onWindowEvent;
         _window.addEventListener("WME_OVER",onWindowEvent);
         _window.addEventListener("WME_OUT",onWindowEvent);
         UnknownVarFromRoomToolsToolbarCtrl_Number_1 = getCollapsedExpandedOffsetX();
         updateVisuals();
         ensureUpdateRegistration();
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         removeUpdateRegistration();
         removeRoomMouseBlockRect();
         if(UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1)
         {
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.dispose();
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1 = null;
         }
         var _loc1_:IWindowController_1 = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.windowManager.getWindowByName("share_room_link") as IWindowController_1;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
         super.dispose();
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function updateRoomHistoryButtons() : void
      {
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.roomHistory.canGoForward())
         {
            _window.findChildByName("button_history_forward").enable();
         }
         else
         {
            _window.findChildByName("button_history_forward").disable();
         }
         if(!UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.roomHistory.canGoBack())
         {
            _window.findChildByName("button_history_back").disable();
         }
         else
         {
            _window.findChildByName("button_history_back").enable();
         }
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.roomHistory.length <= 1)
         {
            _window.findChildByName("button_history").disable();
         }
         else
         {
            _window.findChildByName("button_history").enable();
         }
         if(UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1)
         {
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.populate(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.roomHistory.getHistoryView());
            updatePosition();
         }
      }
      
      public function disableRoomHistoryButtons() : void
      {
         _window.findChildByName("button_history_forward").disable();
         _window.findChildByName("button_history_back").disable();
      }
      
      private function toggleHistory() : void
      {
         if(UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1)
         {
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.dispose();
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1 = null;
         }
         else
         {
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1 = new RoomToolsHistory(_windowManager,_assets,handler);
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.populate(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.roomHistory.getHistoryView());
            updatePosition();
         }
      }
      
      public function release() : void
      {
         if(UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1)
         {
            toggleHistory();
         }
      }
      
      public function setChatHistoryButton(param1:Boolean) : void
      {
         setElementVisible("button_chat_history",param1);
      }
      
      public function setAchievementsButton(param1:Boolean) : void
      {
         setElementVisible("button_achievements",param1);
      }
      
      public function setCameraButton(param1:Boolean) : void
      {
         setElementVisible("button_camera",param1);
      }
      
      public function setLikeButton(param1:Boolean) : void
      {
         setElementVisible("button_like",param1);
      }
      
      override public function setElementVisible(param1:String, param2:Boolean) : void
      {
         if(!_window)
         {
            return;
         }
         _window.visible = true;
         super.setElementVisible(param1,param2);
         updatePosition();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = param1;
         if(param1)
         {
            updatePosition();
         }
         else
         {
            removeRoomMouseBlockRect();
         }
      }
      
      public function updatePosition() : void
      {
         var _loc1_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:IWindowModel = null;
         if(!_window)
         {
            return;
         }
         var _loc9_:IItemListWindow = _window.findChildByName("itemlist_buttons") as IItemListWindow;
         var _loc2_:IWindowModel = _window.findChildByName("window_bg");
         var _loc7_:IWindowModel = _window.findChildByName("side_bar_collapse");
         var _loc4_:IWindowModel = _window.findChildByName("side_bar_expand");
         var _loc5_:IWindowModel = _window.findChildByName("button_collapse");
         var _loc11_:IWindowModel = _window.findChildByName("button_expand");
         var _loc6_:IWindowModel = _window.findChildByName("arrow_collapse");
         var _loc10_:IWindowModel = _window.findChildByName("arrow_expand");
         if(_loc9_ != null && _loc2_ != null && _loc7_ != null && _loc4_ != null)
         {
            _loc1_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc9_.numListItems)
            {
               _loc3_ = _loc9_.getListItemAt(_loc8_);
               if(_loc3_.visible)
               {
                  _loc1_ += _loc3_.height;
               }
               _loc8_++;
            }
            _loc7_.height = _loc1_;
            _loc7_.x = 0;
            _loc4_.height = _loc1_;
            _loc4_.x = 0;
            _loc4_.y = 0;
            _window.height = _loc9_.height = _loc2_.height = _loc1_;
            if(_loc5_ != null)
            {
               _loc5_.height = _loc1_;
            }
            if(_loc11_ != null)
            {
               _loc11_.height = _loc1_;
            }
            if(_loc6_ != null)
            {
               _loc6_.y = _loc1_ * 0.5 - _loc6_.height * 0.5;
            }
            if(_loc10_ != null)
            {
               _loc10_.y = _loc1_ * 0.5 - _loc10_.height * 0.5;
            }
         }
         _window.position = new Point(-5,_window.desktop.height - 55 - _window.height);
         if(UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1)
         {
            UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.window.position = new Point(right - UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.window.width,_window.position.y - UnknownVarFromRoomToolsToolbarCtrl_RoomToolsHistory_1.window.height);
         }
         updateRoomMouseBlockRect();
      }
      
      override public function setCollapsed(param1:Boolean) : void
      {
         if(_isCollapsed == param1 || !_window)
         {
            return;
         }
         _isCollapsed = param1;
         beginAnimation(_isCollapsed ? getCollapsedExpandedOffsetX() : 0);
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         if(UnknownVarFromRoomToolsToolbarCtrl_Boolean_1)
         {
            UnknownVarFromRoomToolsToolbarCtrl_Int_2 += param1;
            _loc3_ = Math.min(1,UnknownVarFromRoomToolsToolbarCtrl_Int_2 / 140);
            _loc2_ = 1 - Math.pow(1 - _loc3_,3);
            applyExpandedBranchOffset(UnknownVarFromRoomToolsToolbarCtrl_Number_2 + (UnknownVarFromRoomToolsToolbarCtrl_Int_1 - UnknownVarFromRoomToolsToolbarCtrl_Number_2) * _loc2_);
            updatePosition();
            if(_loc3_ >= 1)
            {
               UnknownVarFromRoomToolsToolbarCtrl_Boolean_1 = false;
               applyExpandedBranchOffset(UnknownVarFromRoomToolsToolbarCtrl_Int_1);
               updateVisuals();
            }
         }
         updateZoomControls();
      }
      
      private function updateVisuals() : void
      {
         if(!_window || !_window.findChildByName("window_bg"))
         {
            return;
         }
         _window.findChildByName("window_bg").visible = !_isCollapsed || UnknownVarFromRoomToolsToolbarCtrl_Boolean_1;
         _window.findChildByName("side_bar_collapse").visible = !_isCollapsed;
         _window.findChildByName("side_bar_expand").visible = _isCollapsed;
         applyExpandedBranchOffset(UnknownVarFromRoomToolsToolbarCtrl_Number_1);
         updatePosition();
         updateZoomControls();
      }
      
      private function beginAnimation(param1:int) : void
      {
         UnknownVarFromRoomToolsToolbarCtrl_Number_2 = UnknownVarFromRoomToolsToolbarCtrl_Number_1;
         UnknownVarFromRoomToolsToolbarCtrl_Int_1 = param1;
         UnknownVarFromRoomToolsToolbarCtrl_Int_2 = 0;
         UnknownVarFromRoomToolsToolbarCtrl_Boolean_1 = UnknownVarFromRoomToolsToolbarCtrl_Number_2 != UnknownVarFromRoomToolsToolbarCtrl_Int_1;
         updateVisuals();
         if(!UnknownVarFromRoomToolsToolbarCtrl_Boolean_1)
         {
            return;
         }
         ensureUpdateRegistration();
         if(!_isRegisteredForUpdates)
         {
            UnknownVarFromRoomToolsToolbarCtrl_Boolean_1 = false;
            applyExpandedBranchOffset(param1);
            updateVisuals();
         }
      }
      
      private function ensureUpdateRegistration() : void
      {
         var _loc1_:Component = getUpdateComponent();
         if(!_isRegisteredForUpdates && _loc1_ != null)
         {
            _loc1_.registerUpdateReceiver(this,1);
            _isRegisteredForUpdates = true;
         }
      }
      
      private function removeUpdateRegistration() : void
      {
         var _loc1_:Component = getUpdateComponent();
         if(_isRegisteredForUpdates && _loc1_ != null)
         {
            _loc1_.removeUpdateReceiver(this);
         }
         _isRegisteredForUpdates = false;
      }
      
      private function updateZoomControls() : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("zoom_text") as ITextWindow;
         var _loc1_:Boolean = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.canZoomRoom(1);
         var _loc3_:Boolean = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.canZoomRoom(-1);
         var _loc6_:String = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.getCurrentRoomZoomText();
         if(UnknownVarFromRoomToolsToolbarCtrl_Boolean_2 && _loc6_ == UnknownVarFromRoomToolsToolbarCtrl_String_1 && _loc1_ == UnknownVarFromRoomToolsToolbarCtrl_Boolean_3 && _loc3_ == UnknownVarFromRoomToolsToolbarCtrl_Boolean_4)
         {
            return;
         }
         if(_loc2_ != null)
         {
            _loc2_.caption = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.registerParameter("room.zoom.text","zoom_level",_loc6_);
         }
         var _loc5_:IWindowModel = _window.findChildByName("zoom_in_btn");
         if(_loc5_ != null)
         {
            WindowUtils.disableSection(_loc5_,!_loc1_);
         }
         var _loc4_:IWindowModel = _window.findChildByName("zoom_out_btn");
         if(_loc4_ != null)
         {
            WindowUtils.disableSection(_loc4_,!_loc3_);
         }
         UnknownVarFromRoomToolsToolbarCtrl_Boolean_2 = true;
         UnknownVarFromRoomToolsToolbarCtrl_String_1 = _loc6_;
         UnknownVarFromRoomToolsToolbarCtrl_Boolean_3 = _loc1_;
         UnknownVarFromRoomToolsToolbarCtrl_Boolean_4 = _loc3_;
      }
      
      private function applyExpandedBranchOffset(param1:Number) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IWindowModel = _window.findChildByName("window_bg");
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromRoomToolsToolbarCtrl_Number_1 = param1;
         _loc2_.x = 1 + param1;
      }
      
      private function getCollapsedExpandedOffsetX() : int
      {
         if(!_window)
         {
            return 0;
         }
         var _loc1_:IWindowModel = _window.findChildByName("window_bg");
         var _loc2_:IWindowModel = _window.findChildByName("side_bar_expand");
         if(_loc1_ == null || _loc2_ == null)
         {
            return 0;
         }
         return _loc2_.width - _loc1_.width - 1;
      }
      
      private function getUpdateComponent() : Component
      {
         return handler && handler.container ? handler.container.roomEngine as Component : null;
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var message:RoomWidgetZoomToggleMessage;
         var link:String;
         var window:IWindowController_1;
         var asset:XML;
         var openCameraEvent:HabboToolbarEvent;
         var event:WindowEvent = param1;
         var target:IWindowModel = param2;
         if(event.type == "WE_PARENT_RESIZED" && _window && _window.parent && event.target == _window.parent)
         {
            return updatePosition();
         }
         var _loc6_:* = event.type;
         if("WME_CLICK" === _loc6_)
         {
            clearCollapseTimer();
            switch(target.name)
            {
               case "button_settings":
                  handler.toggleRoomInfoWindow();
                  break;
               case "zoom_in_btn":
                  UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.zoomRoom(1);
                  updateZoomControls();
                  break;
               case "zoom_out_btn":
                  UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.zoomRoom(-1);
                  updateZoomControls();
                  break;
               case "button_zoom":
                  if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.messageListener)
                  {
                     message = new RoomWidgetZoomToggleMessage();
                     UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.messageListener.processWidgetMessage(message);
                  }
                  break;
               case "button_collapse":
               case "button_expand":
                  UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.setCollapsed(!_isCollapsed);
                  handler.sessionDataManager.setRoomToolsState(!_isCollapsed);
                  break;
               case "button_history_back":
                  UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.goToPreviousRoom();
                  break;
               case "button_history_forward":
                  UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.goToNextRoom();
                  break;
               case "button_history":
                  toggleHistory();
                  break;
               case "button_chat_history":
                  if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.freeFlowChat)
                  {
                     UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.freeFlowChat.toggleVisibility();
                  }
                  break;
               case "button_achievements":
                  (UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.roomEngine as Component).context.createLinkEvent("questengine/achievements/wired_games");
                  break;
               case "button_like":
                  handler.rateRoom();
                  _window.findChildByName("button_like").disable();
                  break;
               case "button_share":
                  link = getEmbedData();
                  window = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.windowManager.getWindowByName("share_room_link") as IWindowController_1;
                  if(window)
                  {
                     window.dispose();
                     break;
                  }
                  if(window == null)
                  {
                     asset = _assets.getAssetByName("share_room_xml").content as XML;
                     if(asset)
                     {
                        window = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.windowManager.buildFromXML(asset) as IWindowController_1;
                     }
                  }
                  if(window)
                  {
                     HabboTracking.getInstance().trackEventLog("RoomLink","click","client.room_link.clicked");
                     window.name = "share_room_link";
                     window.center();
                     window.findChildByTag("close").addEventListener("WME_CLICK",function(param1:WindowMouseEvent, param2:IWindowModel = null):void
                     {
                        window.dispose();
                     });
                     window.findChildByName("embed_src_txt").caption = getEmbedData();
                     window.findChildByName("embed_src_direct_txt").caption = getEmbedData("embed_src_direct_txt","${url.prefix}/room/%roomId%");
                     IStaticBitmapWrapperWindow(window.findChildByName("thumbnail_image")).assetUri = getThumbnailUrl();
                  }
                  try
                  {
                     System.setClipboard(getEmbedData());
                  }
                  catch(error:Error)
                  {
                  }
                  break;
               case "button_camera":
                  openCameraEvent = new HabboToolbarEvent("HTE_ICON_CAMERA");
                  openCameraEvent.iconName = "roomToolsMenu";
                  handler.container.toolbar.events.dispatchEvent(openCameraEvent);
            }
         }
      }
      
      private function getEmbedData(param1:String = "navigator.embed.src", param2:String = "") : String
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData != null)
         {
            _loc4_ = "private";
            _loc5_ = "" + UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData.flatId;
         }
         var _loc3_:String = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getProperty("user.hash");
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.hasLocalization(param1))
         {
            UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.registerParameter(param1,"roomType",_loc4_);
            UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.registerParameter(param1,"embedCode",_loc3_);
            UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.registerParameter(param1,"roomId",_loc5_);
         }
         else if(param2 != "")
         {
            param2 = param2.replace("${url.prefix}",UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getProperty("url.prefix"));
            return param2.replace("%roomId%",_loc5_);
         }
         return UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.localizations.getLocalization(param1,param2);
      }
      
      private function getThumbnailUrl() : String
      {
         var _loc1_:String = null;
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData == null)
         {
            return null;
         }
         var _loc2_:String = "";
         if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData.officialRoomPicRef != null)
         {
            if(UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
            {
               _loc1_ = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getProperty("navigator.thumbnail.url_base");
               _loc2_ = _loc1_ + UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData.flatId + ".png";
            }
            else
            {
               _loc2_ = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getProperty("image.library.url") + UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData.officialRoomPicRef;
            }
         }
         else
         {
            _loc1_ = UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.container.config.getProperty("navigator.thumbnail.url_base");
            _loc2_ = _loc1_ + UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler.navigator.enteredGuestRoomData.flatId + ".png";
         }
         return _loc2_;
      }
      
      public function get right() : int
      {
         var _loc2_:IWindowModel = null;
         _loc2_ = null;
         if(!_window)
         {
            return 0;
         }
         if(_isCollapsed && !UnknownVarFromRoomToolsToolbarCtrl_Boolean_1)
         {
            _loc2_ = _window.findChildByName("side_bar_expand");
            return !!_loc2_ ? _loc2_.width + -5 : 0;
         }
         var _loc4_:int = 0;
         var _loc1_:IWindowModel = _window.findChildByName("window_bg");
         _loc2_ = _window.findChildByName("side_bar_expand");
         var _loc3_:IWindowModel = _window.findChildByName("side_bar_collapse");
         if(_loc1_ != null && _loc1_.visible)
         {
            _loc4_ = Math.max(_loc4_,Math.round(_loc1_.x + _loc1_.width));
         }
         if(_loc2_ != null && _loc2_.visible)
         {
            _loc4_ = Math.max(_loc4_,Math.round(_loc2_.x + _loc2_.width));
         }
         if(_loc3_ != null && _loc3_.visible)
         {
            _loc4_ = Math.max(_loc4_,Math.round(_loc3_.x + _loc3_.width));
         }
         return _loc4_ + -5;
      }
      
      private function updateRoomMouseBlockRect() : void
      {
         if(_window == null || !_window.visible || handler == null || handler.container == null || handler.container.roomEngine == null)
         {
            removeRoomMouseBlockRect();
            return;
         }
         var _loc1_:IWindowModel = _window.findChildByName("window_bg");
         if(_loc1_ == null || !_loc1_.visible || _loc1_.width <= 0 || _loc1_.height <= 0)
         {
            removeRoomMouseBlockRect();
            return;
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc1_.getGlobalRectangle(_loc2_);
         if(_loc2_.isEmpty())
         {
            removeRoomMouseBlockRect();
            return;
         }
         handler.container.roomEngine.setMouseEventsDisabledRect("room_tools_toolbar",_loc2_);
      }
      
      private function removeRoomMouseBlockRect() : void
      {
         if(handler != null && handler.container != null && handler.container.roomEngine != null)
         {
            handler.container.roomEngine.removeMouseEventsDisabledRect("room_tools_toolbar");
         }
      }
   }
}

