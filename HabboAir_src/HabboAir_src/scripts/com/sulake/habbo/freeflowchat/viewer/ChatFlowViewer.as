package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ChatFlowViewer implements IComponentInterfaceQueue, IProfiler_1
   {
      private const VIEW_BOTTOM_DEFAULT:int = 230;
      
      private var UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromChatFlowViewer_ChatFlowStage_1:ChatFlowStage;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var UnknownVarFromChatFlowViewer_Int_1:int;
      
      private var UnknownVarFromChatFlowViewer_Int_2:int = 0;
      
      private var _runTime:uint = 0;
      
      private var UnknownVarFromChatFlowViewer_Number_1:Number = 0.25;
      
      private var _bubbles:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      private var _toRemove:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      public function ChatFlowViewer(param1:HabboFreeFlowChat, param2:ChatFlowStage)
      {
         super();
         _rootDisplayObject = new Sprite();
         UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1 = param1;
         UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1.registerUpdateReceiver(this,1);
         UnknownVarFromChatFlowViewer_ChatFlowStage_1 = param2;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1)
         {
            UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1.removeUpdateReceiver(this);
            UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1 = null;
         }
         UnknownVarFromChatFlowViewer_ChatFlowStage_1 = null;
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null && UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble, param2:Point) : void
      {
         var _loc3_:Point = UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1.roomEngine.getRoomCanvasScreenOffset(param1.roomId);
         param1.roomPanOffsetX = _loc3_ != null ? _loc3_.x : 0;
         UnknownVarFromChatFlowViewer_Int_2 = param1.roomPanOffsetX;
         _bubbles.push(param1);
         _rootDisplayObject.addChild(param1);
         param1.warpTo(param2.x,param2.y);
         param1.repositionPointer();
         UnknownVarFromChatFlowViewer_Int_1 = param1.roomId;
      }
      
      public function update(param1:uint) : void
      {
         var _loc6_:int = 0;
         _runTime += param1;
         var _loc3_:Point = UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1.roomEngine.getRoomCanvasScreenOffset(UnknownVarFromChatFlowViewer_Int_1);
         if(_loc3_ != null)
         {
            if(_loc3_.x != UnknownVarFromChatFlowViewer_Int_2 && _bubbles.length > 0)
            {
               for each(var _loc2_ in _bubbles)
               {
                  _loc2_.roomPanOffsetX = _loc3_.x;
               }
            }
            UnknownVarFromChatFlowViewer_Int_2 = _loc3_.x;
         }
         for each(var _loc4_ in _bubbles)
         {
            _loc4_.update(param1);
            if(_loc4_.readyToRecycle)
            {
               _toRemove.push(_loc4_);
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc5_ in _toRemove)
            {
               _rootDisplayObject.removeChild(_loc5_);
               _loc6_ = int(_bubbles.indexOf(_loc5_));
               _bubbles.splice(_loc6_,1);
               _loc5_.unregister();
               UnknownVarFromChatFlowViewer_HabboFreeFlowChat_1.chatBubbleFactory.recycle(_loc5_);
            }
            _toRemove = new Vector.<PooledChatBubble>(0);
         }
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function get viewBottom() : int
      {
         if(!_rootDisplayObject.stage)
         {
            return 230;
         }
         return _rootDisplayObject.stage.stageHeight * UnknownVarFromChatFlowViewer_Number_1;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(UnknownVarFromChatFlowViewer_ChatFlowStage_1)
         {
            UnknownVarFromChatFlowViewer_ChatFlowStage_1.resize(param1,param2);
         }
      }
   }
}

