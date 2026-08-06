package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.SmoothScroller;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.history.ChatHistoryBuffer;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.BitmapSpriteWithUserId;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.IChatHistoryEntryBitmapBubble;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryScrollView implements IComponentInterfaceQueue
   {
      private static const SPRINGBACK_DURATION_MS:int = 180;
      
      private static const AUTO_SCROLL_TO_LATEST_DURATION_MS:int = 140;
      
      private static const UnknownConstFromChatHistoryScrollView_Int_1:int = 200;
      
      private static const UnknownConstFromChatHistoryScrollView_Int_2:int = 200;
      
      private static const MOST_RECENT_HISTORY_BOTTOM_PADDING_THRESHOLD:int = 100;
      
      private var UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var _historyBuffer:ChatHistoryBuffer;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var UnknownVarFromChatHistoryScrollView_Stage_1:Stage;
      
      private var UnknownVarFromChatHistoryScrollView_Vector_1:Vector.<BitmapSpriteWithUserId>;
      
      private var _topY:int = 0;
      
      private var _viewPort:Rectangle;
      
      private var _visibleWidth:int = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Int_1:int;
      
      private var UnknownVarFromChatHistoryScrollView_Int_2:int;
      
      private var UnknownVarFromChatHistoryScrollView_Sprite_1:Sprite;
      
      private var UnknownVarFromChatHistoryScrollView_Sprite_2:Sprite;
      
      private var _isActive:Boolean = false;
      
      private var _scrollBar:ChatHistoryScrollBar;
      
      private var _ignore:Bitmap;
      
      private var UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1:BitmapSpriteWithUserId;
      
      private var UnknownVarFromChatHistoryScrollView_Number_1:Number = 200;
      
      private var UnknownVarFromChatHistoryScrollView_SmoothScroller_1:SmoothScroller;
      
      private var UnknownVarFromChatHistoryScrollView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromChatHistoryScrollView_Boolean_2:Boolean = false;
      
      private var UnknownVarFromChatHistoryScrollView_Number_2:Number = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Int_3:int = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Int_4:int = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Boolean_3:Boolean = false;
      
      private var UnknownVarFromChatHistoryScrollView_Number_3:Number = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Int_5:int = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Int_6:int = 0;
      
      private var UnknownVarFromChatHistoryScrollView_Boolean_4:Boolean = false;
      
      private var UnknownVarFromChatHistoryScrollView_Int_7:int = 300;
      
      public function ChatHistoryScrollView(param1:HabboFreeFlowChat, param2:ChatHistoryBuffer)
      {
         super();
         UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1 = param1;
         _historyBuffer = param2;
         _rootDisplayObject = new Sprite();
         _rootDisplayObject.x = 0;
         _rootDisplayObject.y = 0;
         UnknownVarFromChatHistoryScrollView_Sprite_2 = new Sprite();
         _rootDisplayObject.addChild(UnknownVarFromChatHistoryScrollView_Sprite_2);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
         _scrollBar = new ChatHistoryScrollBar(this,param1);
         _ignore = new Bitmap();
         _ignore.bitmapData = BitmapData(UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.assets.getAssetByName("close_x").content);
         UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = null;
         UnknownVarFromChatHistoryScrollView_SmoothScroller_1 = new SmoothScroller(getScrollTopY,setSmoothScrollTopY,getWheelScrollAxisSize,UnknownVarFromChatHistoryScrollView_Number_1,60,false,onWheelScrollCompleted,NaN,false);
      }
      
      public function dispose() : void
      {
         deactivateScrolling();
         deactivateView();
         stopScrollWheel();
         UnknownVarFromChatHistoryScrollView_Sprite_1 = null;
         _ignore = null;
         UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = null;
         if(UnknownVarFromChatHistoryScrollView_SmoothScroller_1)
         {
            UnknownVarFromChatHistoryScrollView_SmoothScroller_1.dispose();
            UnknownVarFromChatHistoryScrollView_SmoothScroller_1 = null;
         }
         if(_rootDisplayObject)
         {
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            _rootDisplayObject = null;
         }
         UnknownVarFromChatHistoryScrollView_Sprite_2 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatHistoryScrollView_Sprite_1 == null && _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function activateView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:BitmapSpriteWithUserId = null;
         var _loc1_:IChatHistoryEntryBitmapBubble = null;
         if(!_historyBuffer)
         {
            return;
         }
         deactivateView();
         UnknownVarFromChatHistoryScrollView_Vector_1 = new Vector.<BitmapSpriteWithUserId>(_historyBuffer.entries.length);
         _loc4_ = 0;
         _loc3_ = -_topY;
         while(_loc4_ < _historyBuffer.entries.length)
         {
            _loc2_ = new BitmapSpriteWithUserId();
            _loc1_ = _historyBuffer.entries[_loc4_];
            _loc2_.roomId = _loc1_.roomId;
            _loc2_.userIndex = _loc1_.userIndex;
            _loc2_.webId = _loc1_.webId;
            _loc2_.bitmapData = _loc1_.bitmap;
            _loc2_.canIgnore = _loc1_.canIgnore;
            _loc2_.userName = _loc1_.userName;
            _loc3_ -= _loc1_.overlap.y;
            _loc2_.y = _loc3_;
            _loc2_.x = 3;
            _loc3_ += _loc2_.bitmapData.height;
            _loc3_ -= 8;
            UnknownVarFromChatHistoryScrollView_Vector_1[_loc4_] = _loc2_;
            _rootDisplayObject.addChild(UnknownVarFromChatHistoryScrollView_Vector_1[_loc4_]);
            _loc4_++;
         }
         _rootDisplayObject.addChild(_scrollBar.displayObject);
         _isActive = true;
         _scrollBar.updateThumbTrack();
      }
      
      public function deactivateView() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromChatHistoryScrollView_Vector_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromChatHistoryScrollView_Vector_1)
            {
               _rootDisplayObject.removeChild(_loc1_);
               _loc1_.bitmapData = null;
            }
         }
         if(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = null;
         }
         UnknownVarFromChatHistoryScrollView_Vector_1 = new Vector.<BitmapSpriteWithUserId>(0);
         if(_scrollBar.displayObject != null && _scrollBar.displayObject.parent == _rootDisplayObject)
         {
            _rootDisplayObject.removeChild(_scrollBar.displayObject);
         }
         _isActive = false;
      }
      
      public function activateScrolling() : void
      {
         deactivateScrolling();
         _rootDisplayObject.addEventListener("mouseDown",mouseDragEventHandler);
         _rootDisplayObject.addEventListener("mouseWheel",mouseWheelEventHandler);
         UnknownVarFromChatHistoryScrollView_Stage_1 = _rootDisplayObject.stage;
         if(UnknownVarFromChatHistoryScrollView_Stage_1 != null)
         {
            UnknownVarFromChatHistoryScrollView_Stage_1.addEventListener("resize",onStageResized);
         }
      }
      
      public function deactivateScrolling() : void
      {
         if(_rootDisplayObject)
         {
            _rootDisplayObject.removeEventListener("mouseDown",mouseDragEventHandler);
            _rootDisplayObject.removeEventListener("mouseWheel",mouseWheelEventHandler);
         }
         if(UnknownVarFromChatHistoryScrollView_Stage_1)
         {
            UnknownVarFromChatHistoryScrollView_Stage_1.removeEventListener("mouseMove",mouseDragEventHandler,true);
            UnknownVarFromChatHistoryScrollView_Stage_1.removeEventListener("mouseUp",mouseDragEventHandler);
            UnknownVarFromChatHistoryScrollView_Stage_1.removeEventListener("resize",onStageResized);
         }
         UnknownVarFromChatHistoryScrollView_Boolean_1 = false;
         stopScrollWheel();
      }
      
      public function get topY() : int
      {
         return _topY;
      }
      
      public function get bufferHeight() : int
      {
         return _historyBuffer.totalHeight;
      }
      
      public function set topY(param1:int) : void
      {
         setTopY(param1,false);
      }
      
      private function setTopY(param1:int, param2:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IChatHistoryEntryBitmapBubble = null;
         var _loc4_:Number = param1 - _topY;
         _topY = param1;
         if(UnknownVarFromChatHistoryScrollView_Vector_1)
         {
            _loc6_ = 0;
            _loc5_ = -_topY;
            while(_loc6_ < _historyBuffer.entries.length)
            {
               if(UnknownVarFromChatHistoryScrollView_Vector_1.length <= _loc6_)
               {
                  break;
               }
               _loc3_ = _historyBuffer.entries[_loc6_];
               _loc5_ -= _loc3_.overlap.y;
               UnknownVarFromChatHistoryScrollView_Vector_1[_loc6_].y = _loc5_;
               _loc5_ += _loc3_.bitmap.height - 8;
               _loc6_++;
            }
         }
         if(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 != null)
         {
            _ignore.y = UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1.y + (UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1.height - _ignore.height) / 2;
         }
         _scrollBar.updateThumbTrack();
         if(!param2 && UnknownVarFromChatHistoryScrollView_SmoothScroller_1 != null && UnknownVarFromChatHistoryScrollView_SmoothScroller_1.isScrolling)
         {
            UnknownVarFromChatHistoryScrollView_SmoothScroller_1.adjustStartPosition(_loc4_);
         }
      }
      
      public function addHistoryEntry(param1:IChatHistoryEntryBitmapBubble) : void
      {
         var _loc3_:Boolean = UnknownVarFromChatHistoryScrollView_Boolean_4;
         var _loc2_:BitmapSpriteWithUserId = new BitmapSpriteWithUserId();
         _loc2_.bitmapData = param1.bitmap;
         _loc2_.y = -_topY + _historyBuffer.totalHeight - param1.bitmap.height + 8;
         _loc2_.x = 3;
         _loc2_.userIndex = param1.userIndex;
         _loc2_.webId = param1.webId;
         _loc2_.roomId = param1.roomId;
         _loc2_.canIgnore = param1.canIgnore;
         _loc2_.userName = param1.userName;
         UnknownVarFromChatHistoryScrollView_Vector_1.push(_loc2_);
         _rootDisplayObject.addChild(UnknownVarFromChatHistoryScrollView_Vector_1[UnknownVarFromChatHistoryScrollView_Vector_1.length - 1]);
         if(_loc3_)
         {
            startAutoScrollToLatest();
         }
         _scrollBar.updateThumbTrack();
      }
      
      public function scrollUpAndSpliceTopItem(param1:int) : void
      {
         if(UnknownVarFromChatHistoryScrollView_Vector_1 && UnknownVarFromChatHistoryScrollView_Vector_1.length > 0)
         {
            _rootDisplayObject.removeChild(UnknownVarFromChatHistoryScrollView_Vector_1[0]);
            UnknownVarFromChatHistoryScrollView_Vector_1.splice(0,1);
            for each(var _loc2_ in UnknownVarFromChatHistoryScrollView_Vector_1)
            {
               _loc2_.y -= param1;
            }
            _scrollBar.updateThumbTrack();
         }
      }
      
      public function get viewPort() : Rectangle
      {
         return _viewPort;
      }
      
      public function set viewPort(param1:Rectangle) : void
      {
         _viewPort = param1;
         _rootDisplayObject.width = param1.width;
         _rootDisplayObject.height = param1.height;
         _rootDisplayObject.scaleX = 1;
         _rootDisplayObject.scaleY = 1;
         if(!UnknownVarFromChatHistoryScrollView_Sprite_1)
         {
            UnknownVarFromChatHistoryScrollView_Sprite_1 = new Sprite();
            _rootDisplayObject.addChild(UnknownVarFromChatHistoryScrollView_Sprite_1);
         }
         updateClipMask();
         updateInputSurface();
         updateScrollBarPosition();
         viewBottom = param1.height;
         if(UnknownVarFromChatHistoryScrollView_Boolean_4)
         {
            UnknownVarFromChatHistoryScrollView_Int_7 = getCurrentBottomPadding();
         }
      }
      
      public function set viewBottom(param1:int) : void
      {
         _rootDisplayObject.y = param1 - _viewPort.height;
         _scrollBar.height = param1;
         _scrollBar.displayObject.y = _viewPort.height - param1;
      }
      
      public function set viewWidth(param1:int) : void
      {
         _visibleWidth = param1;
         updateClipMask();
         updateInputSurface();
         updateScrollBarPosition();
      }
      
      public function scrollToBottom() : void
      {
         topY = _historyBuffer.totalHeight - viewPort.height + 300;
         UnknownVarFromChatHistoryScrollView_Boolean_4 = true;
         UnknownVarFromChatHistoryScrollView_Int_7 = 300;
         cancelAutoScrollToLatest();
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get isMostRecentHistoryMode() : Boolean
      {
         return UnknownVarFromChatHistoryScrollView_Boolean_4 || isViewingMostRecentChatsWithBuffer();
      }
      
      public function beginUserScrollInteraction(param1:Boolean = true) : void
      {
         UnknownVarFromChatHistoryScrollView_Boolean_4 = false;
         cancelSpringback();
         cancelAutoScrollToLatest();
         if(param1)
         {
            endScrollWheel(false);
         }
      }
      
      public function stopScrollWheel() : void
      {
         endScrollWheel(false);
         cancelSpringback();
         cancelAutoScrollToLatest();
      }
      
      public function update(param1:uint) : void
      {
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(UnknownVarFromChatHistoryScrollView_Boolean_3)
         {
            UnknownVarFromChatHistoryScrollView_Int_6 += param1;
            _loc7_ = Math.min(1,UnknownVarFromChatHistoryScrollView_Int_6 / 140);
            _loc3_ = 1 - Math.pow(1 - _loc7_,3);
            _loc4_ = UnknownVarFromChatHistoryScrollView_Number_3 + (UnknownVarFromChatHistoryScrollView_Int_5 - UnknownVarFromChatHistoryScrollView_Number_3) * _loc3_;
            topY = Math.round(_loc4_);
            if(_loc7_ >= 1)
            {
               topY = UnknownVarFromChatHistoryScrollView_Int_5;
               cancelAutoScrollToLatest();
            }
         }
         if(!UnknownVarFromChatHistoryScrollView_Boolean_2)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_Int_4 += param1;
         var _loc5_:Number = Math.min(1,UnknownVarFromChatHistoryScrollView_Int_4 / 180);
         var _loc2_:Number = 1 - Math.pow(1 - _loc5_,3);
         var _loc6_:Number = UnknownVarFromChatHistoryScrollView_Number_2 + (UnknownVarFromChatHistoryScrollView_Int_3 - UnknownVarFromChatHistoryScrollView_Number_2) * _loc2_;
         topY = Math.round(_loc6_);
         if(_loc5_ >= 1)
         {
            topY = UnknownVarFromChatHistoryScrollView_Int_3;
            cancelSpringback();
         }
      }
      
      public function startSpringbackIfNeeded() : void
      {
         syncMostRecentHistoryMode();
         cancelAutoScrollToLatest();
         if(_viewPort == null)
         {
            cancelSpringback();
            return;
         }
         var _loc1_:Number = getSpringbackTargetTopY();
         if(isNaN(_loc1_) || int(Math.round(_loc1_)) == _topY)
         {
            cancelSpringback();
            return;
         }
         UnknownVarFromChatHistoryScrollView_Boolean_2 = true;
         UnknownVarFromChatHistoryScrollView_Number_2 = _topY;
         UnknownVarFromChatHistoryScrollView_Int_3 = Math.round(_loc1_);
         UnknownVarFromChatHistoryScrollView_Int_4 = 0;
      }
      
      private function updateClipMask() : void
      {
         if(UnknownVarFromChatHistoryScrollView_Sprite_1 == null || _viewPort == null)
         {
            return;
         }
         var _loc1_:int = Math.max(0,Math.min(_viewPort.width,_visibleWidth));
         UnknownVarFromChatHistoryScrollView_Sprite_1.graphics.clear();
         if(_loc1_ <= 0)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_Sprite_1.graphics.beginFill(16777215);
         UnknownVarFromChatHistoryScrollView_Sprite_1.graphics.drawRect(0,0,_loc1_,_viewPort.height);
         UnknownVarFromChatHistoryScrollView_Sprite_1.graphics.endFill();
         _rootDisplayObject.mask = UnknownVarFromChatHistoryScrollView_Sprite_1;
      }
      
      private function updateInputSurface() : void
      {
         if(UnknownVarFromChatHistoryScrollView_Sprite_2 == null)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_Sprite_2.graphics.clear();
         if(_viewPort == null || _visibleWidth <= 0)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_Sprite_2.graphics.beginFill(0,0);
         UnknownVarFromChatHistoryScrollView_Sprite_2.graphics.drawRect(0,0,_visibleWidth,_viewPort.height);
         UnknownVarFromChatHistoryScrollView_Sprite_2.graphics.endFill();
      }
      
      private function updateScrollBarPosition() : void
      {
         if(_scrollBar == null || _viewPort == null)
         {
            return;
         }
         var _loc1_:int = int(_visibleWidth > 0 ? _visibleWidth : _viewPort.width);
         _scrollBar.displayObject.x = Math.max(0,_loc1_ - _scrollBar.displayObject.width - 0);
      }
      
      private function findSpriteAtY(param1:int) : BitmapSpriteWithUserId
      {
         for each(var _loc2_ in UnknownVarFromChatHistoryScrollView_Vector_1)
         {
            if(param1 >= _loc2_.y && param1 <= _loc2_.y + _loc2_.height)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function mouseDragEventHandler(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:BitmapSpriteWithUserId = null;
         if(!_rootDisplayObject || !_rootDisplayObject.stage)
         {
            return;
         }
         var _loc2_:MouseEvent = MouseEvent(param1);
         switch(_loc2_.type)
         {
            case "mouseDown":
               if(_loc2_.stageY < _rootDisplayObject.y + _viewPort.height && _loc2_.stageX < _scrollBar.displayObject.x)
               {
                  beginUserScrollInteraction();
                  _scrollBar.cancelScroll();
                  UnknownVarFromChatHistoryScrollView_Int_1 = _loc2_.stageY;
                  UnknownVarFromChatHistoryScrollView_Int_2 = topY;
                  UnknownVarFromChatHistoryScrollView_Boolean_1 = true;
                  UnknownVarFromChatHistoryScrollView_Stage_1.addEventListener("mouseMove",mouseDragEventHandler,true);
                  UnknownVarFromChatHistoryScrollView_Stage_1.addEventListener("mouseUp",mouseDragEventHandler);
               }
               break;
            case "mouseMove":
               _loc5_ = _loc2_.stageY - UnknownVarFromChatHistoryScrollView_Int_1;
               topY = UnknownVarFromChatHistoryScrollView_Int_2 - _loc5_;
               param1.stopImmediatePropagation();
               break;
            case "mouseUp":
               UnknownVarFromChatHistoryScrollView_Stage_1.removeEventListener("mouseMove",mouseDragEventHandler,true);
               UnknownVarFromChatHistoryScrollView_Stage_1.removeEventListener("mouseUp",mouseDragEventHandler);
               UnknownVarFromChatHistoryScrollView_Boolean_1 = false;
               _loc4_ = _loc2_.stageY - UnknownVarFromChatHistoryScrollView_Int_1;
               if(_loc4_ < 1 && _loc4_ > -1)
               {
                  if(hitIgnore(_loc2_.stageX,_loc2_.stageY))
                  {
                     startSpringbackIfNeeded();
                     break;
                  }
                  _loc3_ = findSpriteAtY(_loc2_.stageY);
                  if(_loc3_)
                  {
                     onEntrySpriteClicked(_loc3_);
                     moveIgnore(_loc3_);
                  }
               }
               startSpringbackIfNeeded();
         }
      }
      
      private function mouseWheelEventHandler(param1:MouseEvent) : void
      {
         beginUserScrollInteraction(false);
         scrollWithWheel(param1.delta);
         param1.stopImmediatePropagation();
      }
      
      private function endScrollWheel(param1:Boolean = true) : void
      {
         if(!isScrollingWithWheel)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_SmoothScroller_1.stop();
         if(param1 && !UnknownVarFromChatHistoryScrollView_Boolean_1)
         {
            startSpringbackIfNeeded();
         }
      }
      
      private function get isScrollingWithWheel() : Boolean
      {
         return UnknownVarFromChatHistoryScrollView_SmoothScroller_1 != null && UnknownVarFromChatHistoryScrollView_SmoothScroller_1.isScrolling;
      }
      
      public function scrollWithWheel(param1:int) : void
      {
         cancelSpringback();
         UnknownVarFromChatHistoryScrollView_SmoothScroller_1.scrollWithWheel(param1);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Stage = _rootDisplayObject.stage;
         viewPort = new Rectangle(0,0,_loc2_.stageWidth,_loc2_.stageHeight - 50);
      }
      
      private function onStageResized(param1:Event) : void
      {
         if(UnknownVarFromChatHistoryScrollView_Stage_1)
         {
            viewPort = new Rectangle(0,0,UnknownVarFromChatHistoryScrollView_Stage_1.stageWidth,UnknownVarFromChatHistoryScrollView_Stage_1.stageHeight - 50);
         }
      }
      
      private function getScrollTopY() : Number
      {
         return _topY;
      }
      
      private function setSmoothScrollTopY(param1:Number) : void
      {
         setTopY(int(Math.round(param1)),true);
      }
      
      private function getWheelScrollAxisSize() : Number
      {
         return 1;
      }
      
      private function onWheelScrollCompleted() : void
      {
         if(!UnknownVarFromChatHistoryScrollView_Boolean_1)
         {
            startSpringbackIfNeeded();
         }
      }
      
      private function onEntrySpriteClicked(param1:BitmapSpriteWithUserId) : void
      {
         if(!UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1)
         {
            return;
         }
         UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.selectAvatar(param1.roomId,param1.userIndex);
      }
      
      private function moveIgnore(param1:BitmapSpriteWithUserId) : void
      {
         if(!UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1 || param1 == UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1)
         {
            return;
         }
         if(!param1.canIgnore || param1.webId < 0 || UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.sessionDataManager.isIgnored(param1.webId))
         {
            if(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 != null)
            {
               _rootDisplayObject.removeChild(_ignore);
               UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = null;
            }
            return;
         }
         _ignore.x = param1.x + param1.width + 5;
         _ignore.y = param1.y + (param1.height - _ignore.height) / 2;
         _rootDisplayObject.addChild(_ignore);
         UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = param1;
      }
      
      private function hitIgnore(param1:int, param2:int) : Boolean
      {
         if(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 == null || param1 < _ignore.x || param1 > _ignore.x + _ignore.width || param2 < _ignore.y || param2 > _ignore.y + _ignore.height)
         {
            return false;
         }
         UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.localizations.registerParameter("chat.ignore_user.confirm.info","username",UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1.userName);
         var _loc4_:String = UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.localizations.getLocalization("chat.ignore_user.confirm.title");
         var _loc3_:String = UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.localizations.getLocalization("chat.ignore_user.confirm.info");
         UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.windowManager.confirmWithModal(_loc4_,_loc3_,0,ignoreConfirmDialogEventProcessor);
         return true;
      }
      
      private function ignoreConfirmDialogEventProcessor(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            UnknownVarFromChatHistoryScrollView_HabboFreeFlowChat_1.sessionDataManager.ignoreUser(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1.webId);
         }
         if(UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 != null)
         {
            _rootDisplayObject.removeChild(_ignore);
            UnknownVarFromChatHistoryScrollView_BitmapSpriteWithUserId_1 = null;
         }
      }
      
      private function cancelSpringback() : void
      {
         UnknownVarFromChatHistoryScrollView_Boolean_2 = false;
         UnknownVarFromChatHistoryScrollView_Int_4 = 0;
         UnknownVarFromChatHistoryScrollView_Number_2 = _topY;
         UnknownVarFromChatHistoryScrollView_Int_3 = _topY;
      }
      
      private function cancelAutoScrollToLatest() : void
      {
         UnknownVarFromChatHistoryScrollView_Boolean_3 = false;
         UnknownVarFromChatHistoryScrollView_Int_6 = 0;
         UnknownVarFromChatHistoryScrollView_Number_3 = _topY;
         UnknownVarFromChatHistoryScrollView_Int_5 = _topY;
      }
      
      private function startAutoScrollToLatest() : void
      {
         if(_viewPort == null)
         {
            return;
         }
         cancelSpringback();
         var _loc1_:int = bufferHeight - _viewPort.height + UnknownVarFromChatHistoryScrollView_Int_7;
         if(_loc1_ == _topY)
         {
            cancelAutoScrollToLatest();
            return;
         }
         UnknownVarFromChatHistoryScrollView_Boolean_3 = true;
         UnknownVarFromChatHistoryScrollView_Number_3 = _topY;
         UnknownVarFromChatHistoryScrollView_Int_5 = _loc1_;
         UnknownVarFromChatHistoryScrollView_Int_6 = 0;
      }
      
      private function syncMostRecentHistoryMode() : void
      {
         if(isViewingMostRecentChatsWithBuffer())
         {
            UnknownVarFromChatHistoryScrollView_Boolean_4 = true;
            UnknownVarFromChatHistoryScrollView_Int_7 = getCurrentBottomPadding();
         }
         else
         {
            UnknownVarFromChatHistoryScrollView_Boolean_4 = false;
         }
      }
      
      private function getCurrentBottomPadding() : int
      {
         if(_viewPort == null)
         {
            return 0;
         }
         return _topY - bufferHeight + _viewPort.height;
      }
      
      private function isViewingMostRecentChatsWithBuffer() : Boolean
      {
         return _viewPort != null && getCurrentBottomPadding() >= 100;
      }
      
      private function getSpringbackTargetTopY() : Number
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_viewPort == null || bufferHeight <= 0)
         {
            return NaN;
         }
         var _loc3_:int = Math.min(200,bufferHeight);
         var _loc1_:int = Math.min(200,bufferHeight);
         if(_loc3_ <= 0 && _loc1_ <= 0)
         {
            return NaN;
         }
         if(_loc3_ > 0)
         {
            _loc2_ = _loc3_ - _viewPort.height;
            if(_topY < _loc2_)
            {
               return _loc2_;
            }
         }
         if(_loc1_ > 0)
         {
            _loc4_ = bufferHeight - _loc1_;
            if(_topY > _loc4_)
            {
               return _loc4_;
            }
         }
         return NaN;
      }
   }
}

