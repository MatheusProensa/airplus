package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryTray implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const ANIMATION_DURATION_MS:int = 140;
      
      private static const ROOM_MOUSE_BLOCK_HANDLE_ID:String = "freeflow_chat_history_handle";
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1:ChatHistoryScrollView;
      
      private var _tab:Sprite;
      
      private var UnknownVarFromChatHistoryTray_Bitmap_1:Bitmap;
      
      private var UnknownVarFromChatHistoryTray_Bitmap_2:Bitmap;
      
      private var _tabHandleHitArea:Sprite;
      
      private var _bg:Bitmap;
      
      private var _openedWidth:int;
      
      private var _currentWidth:Number = 0;
      
      private var _isOpen:Boolean = false;
      
      private var UnknownVarFromChatHistoryTray_Boolean_1:Boolean = false;
      
      private var _isRegisteredForUpdates:Boolean = false;
      
      private var _hasOpenedInRoom:Boolean = false;
      
      private var UnknownVarFromChatHistoryTray_Boolean_2:Boolean = false;
      
      private var _animationStartWidth:Number = 0;
      
      private var _animationTargetWidth:int = 0;
      
      private var UnknownVarFromChatHistoryTray_Int_1:int = 0;
      
      public function ChatHistoryTray(param1:HabboFreeFlowChat, param2:ChatHistoryScrollView)
      {
         super();
         UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1 = param1;
         UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1 = param2;
         _rootDisplayObject = new Sprite();
         UnknownVarFromChatHistoryTray_Bitmap_1 = new Bitmap();
         UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData = BitmapData(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.assets.getAssetByName("tray_bar").content);
         UnknownVarFromChatHistoryTray_Bitmap_1.width = UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData.width;
         UnknownVarFromChatHistoryTray_Bitmap_1.height = 0;
         UnknownVarFromChatHistoryTray_Bitmap_1.scaleX = 1;
         UnknownVarFromChatHistoryTray_Bitmap_1.x = -UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData.width;
         UnknownVarFromChatHistoryTray_Bitmap_2 = new Bitmap();
         UnknownVarFromChatHistoryTray_Bitmap_2.bitmapData = BitmapData(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.assets.getAssetByName("tray_handle_open").content);
         UnknownVarFromChatHistoryTray_Bitmap_2.scaleX = 1;
         UnknownVarFromChatHistoryTray_Bitmap_2.scaleY = 1;
         UnknownVarFromChatHistoryTray_Bitmap_2.x = -0;
         UnknownVarFromChatHistoryTray_Bitmap_2.y = 350;
         UnknownVarFromChatHistoryTray_Bitmap_2.visible = false;
         _tabHandleHitArea = new Sprite();
         _tabHandleHitArea.visible = false;
         _tabHandleHitArea.addEventListener("click",tabHandleClickedEventHandler);
         refreshTabHandleHitArea();
         _tab = new Sprite();
         _tab.scaleX = 1;
         _tab.scaleY = 1;
         _tab.visible = true;
         _tab.addChild(UnknownVarFromChatHistoryTray_Bitmap_1);
         _tab.addChild(UnknownVarFromChatHistoryTray_Bitmap_2);
         _tab.addChild(_tabHandleHitArea);
         _rootDisplayObject.addChild(_tab);
         _bg = new Bitmap();
         _bg.bitmapData = new BitmapData(1,1,true,2720277278);
         _bg.width = 0;
         _bg.height = 0;
         _rootDisplayObject.addChild(_bg);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _openedWidth = 350 + 62 + 1;
         applyTrayWidth(0);
      }
      
      public function dispose() : void
      {
         UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.disableRoomMouseEventsLeftOfX(0);
         removeRoomMouseBlockRect();
         if(_rootDisplayObject)
         {
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.deactivateScrolling();
            _tabHandleHitArea.removeEventListener("click",tabHandleClickedEventHandler);
         }
         if(_isRegisteredForUpdates && UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1)
         {
            UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.removeUpdateReceiver(this);
         }
         UnknownVarFromChatHistoryTray_Boolean_1 = false;
         _isRegisteredForUpdates = false;
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         _tab.height = param2 - 50;
         UnknownVarFromChatHistoryTray_Bitmap_1.height = param2 - 50;
         _bg.height = param2 - 50;
         _tab.scaleY = 1;
         UnknownVarFromChatHistoryTray_Bitmap_2.scaleY = 1;
         UnknownVarFromChatHistoryTray_Bitmap_2.y = param2 - 215;
         applyTrayWidth(int(Math.round(_currentWidth)));
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         resize(_rootDisplayObject.stage.stageWidth,_rootDisplayObject.stage.stageHeight);
      }
      
      public function toggleHistoryVisibility() : void
      {
         if(_rootDisplayObject == null || UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1 == null)
         {
            return;
         }
         if(_isOpen)
         {
            startClosing();
         }
         else
         {
            startOpening();
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_isOpen != param1)
         {
            toggleHistoryVisibility();
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         if(_isOpen || UnknownVarFromChatHistoryTray_Boolean_1)
         {
            UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.update(param1);
         }
         if(UnknownVarFromChatHistoryTray_Boolean_1)
         {
            UnknownVarFromChatHistoryTray_Int_1 += param1;
            _loc3_ = Math.min(1,UnknownVarFromChatHistoryTray_Int_1 / 140);
            _loc2_ = 1 - Math.pow(1 - _loc3_,3);
            _loc4_ = _animationStartWidth + (_animationTargetWidth - _animationStartWidth) * _loc2_;
            applyTrayWidth(int(Math.round(_loc4_)));
            if(_loc3_ >= 1)
            {
               UnknownVarFromChatHistoryTray_Boolean_1 = false;
               applyTrayWidth(_animationTargetWidth);
               if(_animationTargetWidth == 0)
               {
                  finishClosing();
               }
            }
         }
         refreshUpdateRegistration();
      }
      
      private function tabHandleClickedEventHandler(param1:MouseEvent) : void
      {
         if(_tabHandleHitArea.visible)
         {
            toggleHistoryVisibility();
         }
      }
      
      private function startOpening() : void
      {
         _isOpen = true;
         if(UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.rootDisplayObject.parent != _rootDisplayObject)
         {
            _rootDisplayObject.addChild(UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.rootDisplayObject);
         }
         if(!UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.isActive)
         {
            if(!_hasOpenedInRoom || UnknownVarFromChatHistoryTray_Boolean_2)
            {
               UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.scrollToBottom();
            }
            UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.activateView();
            _hasOpenedInRoom = true;
         }
         UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.activateScrolling();
         UnknownVarFromChatHistoryTray_Bitmap_2.bitmapData = BitmapData(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.assets.getAssetByName("tray_handle_close").content);
         if(shouldAnimate())
         {
            beginWidthAnimation(_openedWidth);
         }
         else
         {
            UnknownVarFromChatHistoryTray_Boolean_1 = false;
            applyTrayWidth(_openedWidth);
            refreshUpdateRegistration();
         }
      }
      
      private function startClosing() : void
      {
         _isOpen = false;
         UnknownVarFromChatHistoryTray_Boolean_2 = UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.isMostRecentHistoryMode;
         UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.deactivateScrolling();
         if(shouldAnimate())
         {
            beginWidthAnimation(0);
         }
         else
         {
            UnknownVarFromChatHistoryTray_Boolean_1 = false;
            applyTrayWidth(0);
            finishClosing();
            refreshUpdateRegistration();
         }
      }
      
      private function finishClosing() : void
      {
         if(UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.rootDisplayObject.parent == _rootDisplayObject)
         {
            _rootDisplayObject.removeChild(UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.rootDisplayObject);
         }
         UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.deactivateView();
         UnknownVarFromChatHistoryTray_Bitmap_2.bitmapData = BitmapData(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.assets.getAssetByName("tray_handle_open").content);
         UnknownVarFromChatHistoryTray_Bitmap_2.visible = false;
         _tabHandleHitArea.visible = false;
         refreshTabHandleHitArea();
      }
      
      private function beginWidthAnimation(param1:int) : void
      {
         _animationStartWidth = _currentWidth;
         _animationTargetWidth = param1;
         UnknownVarFromChatHistoryTray_Int_1 = 0;
         if(_animationStartWidth == _animationTargetWidth)
         {
            UnknownVarFromChatHistoryTray_Boolean_1 = false;
            applyTrayWidth(param1);
            if(param1 == 0)
            {
               finishClosing();
            }
            refreshUpdateRegistration();
            return;
         }
         UnknownVarFromChatHistoryTray_Boolean_1 = true;
         refreshUpdateRegistration();
      }
      
      private function applyTrayWidth(param1:int) : void
      {
         var _loc2_:int = Math.max(0,Math.min(_openedWidth,param1));
         _currentWidth = _loc2_;
         _bg.width = _loc2_;
         UnknownVarFromChatHistoryTray_Bitmap_1.x = _loc2_ > 0 ? _loc2_ : -UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData.width;
         UnknownVarFromChatHistoryTray_Bitmap_2.x = _loc2_ > 0 ? _loc2_ - 0 + UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData.width : -0;
         UnknownVarFromChatHistoryTray_Bitmap_2.visible = _loc2_ > 0;
         _tabHandleHitArea.visible = _loc2_ > 0;
         UnknownVarFromChatHistoryTray_ChatHistoryScrollView_1.viewWidth = _loc2_;
         refreshTabHandleHitArea();
         UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.disableRoomMouseEventsLeftOfX(_loc2_ > 0 ? _loc2_ + UnknownVarFromChatHistoryTray_Bitmap_1.bitmapData.width : 0);
         updateRoomMouseBlockRect();
      }
      
      private function refreshUpdateRegistration() : void
      {
         var _loc1_:Boolean = UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1 != null && (_isOpen || UnknownVarFromChatHistoryTray_Boolean_1);
         if(_loc1_ == _isRegisteredForUpdates)
         {
            return;
         }
         if(_loc1_)
         {
            UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.registerUpdateReceiver(this,1);
         }
         else
         {
            UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.removeUpdateReceiver(this);
         }
         _isRegisteredForUpdates = _loc1_;
      }
      
      private function shouldAnimate() : Boolean
      {
         return _rootDisplayObject != null && _rootDisplayObject.stage != null;
      }
      
      private function refreshTabHandleHitArea() : void
      {
         if(_tabHandleHitArea == null || UnknownVarFromChatHistoryTray_Bitmap_2 == null || UnknownVarFromChatHistoryTray_Bitmap_2.bitmapData == null)
         {
            return;
         }
         _tabHandleHitArea.x = UnknownVarFromChatHistoryTray_Bitmap_2.x;
         _tabHandleHitArea.y = UnknownVarFromChatHistoryTray_Bitmap_2.y;
         _tabHandleHitArea.graphics.clear();
         _tabHandleHitArea.graphics.beginFill(0,0);
         _tabHandleHitArea.graphics.drawRect(0,0,UnknownVarFromChatHistoryTray_Bitmap_2.width,UnknownVarFromChatHistoryTray_Bitmap_2.height);
         _tabHandleHitArea.graphics.endFill();
      }
      
      private function updateRoomMouseBlockRect() : void
      {
         if(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1 == null || UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.roomEngine == null || _tabHandleHitArea == null || !_tabHandleHitArea.visible || _rootDisplayObject == null || _rootDisplayObject.stage == null)
         {
            removeRoomMouseBlockRect();
            return;
         }
         var _loc1_:Rectangle = _tabHandleHitArea.getBounds(_rootDisplayObject.stage);
         if(_loc1_ == null || _loc1_.isEmpty())
         {
            removeRoomMouseBlockRect();
            return;
         }
         UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.roomEngine.setMouseEventsDisabledRect("freeflow_chat_history_handle",_loc1_);
      }
      
      private function removeRoomMouseBlockRect() : void
      {
         if(UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1 != null && UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.roomEngine != null)
         {
            UnknownVarFromChatHistoryTray_HabboFreeFlowChat_1.roomEngine.removeMouseEventsDisabledRect("freeflow_chat_history_handle");
         }
      }
   }
}

