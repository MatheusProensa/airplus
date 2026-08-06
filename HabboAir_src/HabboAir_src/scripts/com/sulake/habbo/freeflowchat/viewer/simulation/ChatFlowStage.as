package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Point;
   
   public class ChatFlowStage implements IComponentInterfaceQueue, IProfiler_1
   {
      public static const MOVE_UP_AMOUNT_PIXELS:int = 19;
      
      private static const CLEANUP_TIMER_DELAY:int = 5000;
      
      private static const MOVE_UP_TIMER_DEFAULT:int = 10000;
      
      private static const MAX_ITERATIONS:int = 20;
      
      private static const MAX_COLLISION_SIDEWAYS_IMPULSE:int = 15;
      
      private static const MOVE_UP_IMPULSE_LIMIT:Number = 8;
      
      private const MINIMUM_COLLIDER_WIDTH:int = 240;
      
      private var UnknownVarFromChatFlowStage_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var _simulationTime:uint = 0;
      
      private var UnknownVarFromChatFlowStage_Uint_1:uint = 0;
      
      private var UnknownVarFromChatFlowStage_Uint_2:uint = 0;
      
      private var UnknownVarFromChatFlowStage_ChatFlowGravity_1:ChatFlowGravity = new ChatFlowGravity();
      
      private var _bubbles:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var _toRemove:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var _lineByLineMode:Boolean = false;
      
      private var UnknownVarFromChatFlowStage_Int_1:int = 10000;
      
      private var UnknownVarFromChatFlowStage_Boolean_1:Boolean = true;
      
      private var UnknownVarFromChatFlowStage_Boolean_2:Boolean = false;
      
      private var UnknownVarFromChatFlowStage_Int_2:int = 0;
      
      public function ChatFlowStage(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromChatFlowStage_HabboFreeFlowChat_1 = param1;
         UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.registerUpdateReceiver(this,2);
         refreshSettings();
      }
      
      public function refreshSettings() : void
      {
         if(UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.roomChatSettings)
         {
            _lineByLineMode = UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.roomChatSettings.mode == 1;
            UnknownVarFromChatFlowStage_Boolean_1 = !_lineByLineMode;
            switch(UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.roomChatSettings.scrollSpeed)
            {
               case 0:
                  UnknownVarFromChatFlowStage_Int_1 = 3000;
                  break;
               case 1:
                  UnknownVarFromChatFlowStage_Int_1 = 6000;
                  break;
               case 2:
                  UnknownVarFromChatFlowStage_Int_1 = 12000;
            }
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromChatFlowStage_HabboFreeFlowChat_1)
            {
               UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.removeUpdateReceiver(this);
               UnknownVarFromChatFlowStage_HabboFreeFlowChat_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatFlowStage_HabboFreeFlowChat_1 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble) : Point
      {
         var _loc11_:ChatBubbleSimulationEntity = null;
         var _loc6_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:ChatBubbleSimulationWithLimitedWideRect = null;
         var _loc10_:int = 0;
         if(UnknownVarFromChatFlowStage_Int_2 == 0)
         {
            UnknownVarFromChatFlowStage_Int_2 = UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer.viewBottom;
         }
         var _loc4_:Point = UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.roomEngine.getRoomCanvasScreenOffset(param1.roomId);
         param1.roomPanOffsetX = _loc4_ != null ? _loc4_.x : 0;
         if(!_lineByLineMode && param1.width < 240)
         {
            _loc11_ = new ChatBubbleSimulationWithLimitedWideRect(param1);
         }
         else
         {
            _loc11_ = new ChatBubbleSimulationEntity(param1,_lineByLineMode);
         }
         var _loc9_:Point = new Point(param1.userScreenPos.x - _loc11_.visualRect.width / 2,UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer.viewBottom);
         if(_loc4_ != null)
         {
            _loc9_.x -= _loc4_.x;
         }
         _loc9_.y -= !!param1.overlap ? param1.overlap.y : 0;
         _loc9_.x -= !!param1.overlap ? param1.overlap.x : 0;
         _loc11_.initializePosition(_loc9_.x,_loc9_.y);
         if(UnknownVarFromChatFlowStage_Boolean_1 && !_lineByLineMode)
         {
            _loc6_ = 0;
            while(_loc6_ < 20 / 2)
            {
               _loc3_ = 0;
               for each(var _loc7_ in _bubbles)
               {
                  _loc3_ += UnknownVarFromChatFlowStage_ChatFlowGravity_1.getAttraction(_loc11_,_loc7_,60,40);
               }
               _loc11_.x += _loc3_;
               _loc6_++;
            }
            _loc5_ = _loc11_.x;
            _loc10_ = param1.userScreenPos.x - (_loc4_ != null ? _loc4_.x : 0);
            if(_loc11_.x > _loc10_ - 15)
            {
               _loc5_ = _loc10_ - 15;
               if(_loc11_.hasWideRect)
               {
                  _loc2_ = ChatBubbleSimulationWithLimitedWideRect(_loc11_);
                  _loc8_ = _loc11_.x - _loc5_;
                  _loc2_.wideRectOffset += _loc8_;
                  _loc2_.wideRectOffset = Math.min(0,_loc2_.wideRectOffset);
               }
            }
            else if(_loc11_.x + _loc11_.visualRect.width < _loc10_ + 15)
            {
               _loc5_ = _loc10_ - _loc11_.visualRect.width + 15;
               if(_loc11_.hasWideRect)
               {
                  _loc2_ = ChatBubbleSimulationWithLimitedWideRect(_loc11_);
                  _loc8_ = _loc11_.x - _loc5_;
                  _loc2_.wideRectOffset += _loc8_;
                  _loc2_.wideRectOffset = Math.max(-(_loc2_.wideRect.width - _loc2_.visualRect.width),_loc2_.wideRectOffset);
               }
            }
            _loc11_.x = _loc9_.x = _loc5_;
         }
         _bubbles.push(_loc11_);
         _loc9_.x -= !!param1.overlap ? param1.overlap.x : 0;
         if(_lineByLineMode)
         {
            UnknownVarFromChatFlowStage_Uint_1 = _simulationTime;
         }
         return _loc9_;
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ChatBubbleSimulationEntity = null;
         _simulationTime += param1;
         for each(var _loc2_ in _bubbles)
         {
            if(!_loc2_.isSpacer)
            {
               _loc2_.syncToUserScreenPosition();
            }
         }
         simulate();
         if(UnknownVarFromChatFlowStage_Uint_1 + UnknownVarFromChatFlowStage_Int_1 < _simulationTime)
         {
            scrollUp();
            UnknownVarFromChatFlowStage_Uint_1 = _simulationTime;
         }
         _loc4_ = 0;
         while(_loc4_ < _bubbles.length)
         {
            _loc3_ = _bubbles[_loc4_];
            _loc3_.syncToVisualization();
            if(!_loc3_.isSpacer)
            {
               _loc3_.fullHeightCollision = false;
               if(_loc4_ > 0 && _loc3_.visualizationHasHitMargin)
               {
                  _loc3_.fullHeightCollision = true;
                  _bubbles[_loc4_ - 1].fullHeightCollision = true;
               }
            }
            _loc4_++;
         }
         if(UnknownVarFromChatFlowStage_Uint_2 + 5000 < _simulationTime)
         {
            cleanup();
            UnknownVarFromChatFlowStage_Uint_2 = _simulationTime;
         }
      }
      
      public function clear() : void
      {
         for each(var _loc1_ in _bubbles)
         {
            _loc1_.readyToRecycle = true;
         }
         update(0);
         UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer.update(0);
      }
      
      private function simulate() : void
      {
         var _loc7_:* = undefined;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc9_ = 0;
         while(_loc9_ < 20)
         {
            _loc7_ = new Vector.<ChatBubbleCollisionEvent>(0);
            for each(_loc11_ in _bubbles)
            {
               _loc11_.resetSimulationStep();
               for each(_loc4_ in _bubbles)
               {
                  if(_loc11_ != _loc4_ && _loc11_.intersectsWith(_loc4_))
                  {
                     _loc7_.push(new ChatBubbleCollisionEvent(_loc11_,_loc4_));
                  }
               }
            }
            if(_loc7_.length == 0)
            {
               break;
            }
            if(_lineByLineMode)
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.wideRect.height);
                     }
                     else
                     {
                        _loc6_ = _loc2_.first.visualIntertersectsWith(_loc2_.second) ? _loc2_.top.visualRect.bottom : _loc2_.top.wideRect.bottom;
                        _loc2_.top.addVerticalImpulse(-(_loc6_ - _loc2_.bottom.y + 1));
                     }
                  }
                  _loc2_.first.addCollisionHandled(_loc2_.second);
                  _loc2_.second.addCollisionHandled(_loc2_.first);
               }
            }
            else
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     _loc1_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.left).wideRectOffset + _loc2_.left.x : _loc2_.left.x;
                     _loc10_ = _loc2_.right is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.right).wideRectOffset + _loc2_.right.x : _loc2_.right.x;
                     _loc3_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? _loc2_.left.wideRect.width : _loc2_.left.visualRect.width;
                     _loc8_ = Math.abs(_loc1_ + _loc3_ - _loc10_) / 2;
                     if(_loc8_ <= 15)
                     {
                        _loc2_.left.addHorizontalImpulse(-_loc8_);
                        _loc2_.right.addHorizontalImpulse(_loc8_ + 1);
                     }
                     else if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.visualRect.height);
                     }
                     else
                     {
                        _loc2_.top.addVerticalImpulse(-(_loc2_.top.visualRect.bottom - _loc2_.bottom.y + 1));
                     }
                     _loc2_.first.addCollisionHandled(_loc2_.second);
                     _loc2_.second.addCollisionHandled(_loc2_.first);
                  }
               }
            }
            for each(_loc5_ in _bubbles)
            {
               _loc5_.applyImpulseForces(8);
            }
            _loc9_++;
         }
      }
      
      private function scrollUp() : void
      {
         if(UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer == null)
         {
            return;
         }
         for each(var _loc1_ in _bubbles)
         {
            if(UnknownVarFromChatFlowStage_Boolean_1)
            {
               for each(var _loc2_ in _bubbles)
               {
                  if(_loc1_ != _loc2_)
                  {
                     _loc1_.x += UnknownVarFromChatFlowStage_ChatFlowGravity_1.getAttraction(_loc1_,_loc2_);
                  }
               }
            }
            _loc1_.y -= 19;
         }
         if(_lineByLineMode)
         {
            insertBubble(UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatBubbleFactory.getNewEmptySpace(19));
            _bubbles[_bubbles.length - 1].fullHeightCollision = true;
            _bubbles[_bubbles.length - 1].isSpacer = true;
         }
         simulate();
      }
      
      private function cleanup() : void
      {
         var _loc3_:int = 0;
         for each(var _loc1_ in _bubbles)
         {
            if(_loc1_.visualRect.bottom < -10 || _loc1_.readyToRecycle)
            {
               _loc1_.readyToRecycle = true;
               if(_toRemove.indexOf(_loc1_) == -1)
               {
                  _toRemove.push(_loc1_);
               }
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc2_ in _toRemove)
            {
               _loc3_ = int(_bubbles.indexOf(_loc2_));
               _loc2_.dispose();
               _bubbles.splice(_loc3_,1);
            }
            _toRemove = new Vector.<ChatBubbleSimulationEntity>(0);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(!UnknownVarFromChatFlowStage_HabboFreeFlowChat_1)
         {
            return;
         }
         if(!UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer)
         {
            return;
         }
         var _loc5_:int = UnknownVarFromChatFlowStage_HabboFreeFlowChat_1.chatFlowViewer.viewBottom;
         if(UnknownVarFromChatFlowStage_Int_2 != _loc5_)
         {
            if(UnknownVarFromChatFlowStage_Int_2 < _loc5_)
            {
               _loc4_ = _loc5_ - UnknownVarFromChatFlowStage_Int_2;
               for each(_loc3_ in _bubbles)
               {
                  _loc3_.y += _loc4_;
                  _loc3_.syncToVisualization(true);
               }
            }
            else
            {
               _loc6_ = UnknownVarFromChatFlowStage_Int_2 - _loc5_;
               for each(_loc3_ in _bubbles)
               {
                  _loc3_.y -= _loc6_;
                  _loc3_.syncToVisualization(true);
               }
            }
         }
         UnknownVarFromChatFlowStage_Int_2 = _loc5_;
      }
   }
}

