package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationEntity
   {
      public static const VISUALIZATION_OVERLAP_VERTICAL:int = 10;
      
      protected const MOVE_NEGATIVE_FEEDBACK:Number = 0.1;
      
      protected var _visualization:PooledChatBubble;
      
      protected var _x:Number;
      
      protected var _y:Number;
      
      protected var _visualRect:Rectangle = new Rectangle();
      
      protected var UnknownVarFromChatBubbleSimulationEntity_Rectangle_1:Rectangle = null;
      
      protected var UnknownVarFromChatBubbleSimulationEntity_Number_1:Number;
      
      protected var UnknownVarFromChatBubbleSimulationEntity_Number_2:Number;
      
      protected var UnknownVarFromChatBubbleSimulationEntity_Number_3:Number;
      
      protected var UnknownVarFromChatBubbleSimulationEntity_Boolean_1:Boolean = false;
      
      private const UnknownConstFromChatBubbleSimulationEntity_Int_1:int = 2500;
      
      private var UnknownVarFromChatBubbleSimulationEntity_Vector_1:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var _isSpacer:Boolean = false;
      
      public function ChatBubbleSimulationEntity(param1:PooledChatBubble, param2:Boolean = false)
      {
         super();
         _visualization = param1;
         var _loc3_:Rectangle = param1.overlap;
         _x = param1.x + (!!_loc3_ ? _loc3_.x : 0);
         _y = param1.y + (!!_loc3_ ? _loc3_.y : 0);
         _visualRect.x = _x;
         _visualRect.y = _y;
         _visualRect.width = _visualization.width - (!!_loc3_ ? _loc3_.x + _loc3_.width : 0);
         _visualRect.height = _visualization.displayedHeight - 10 - (!!_loc3_ ? _loc3_.y + _loc3_.height : 0);
         if(_visualization.minHeight != -1)
         {
            _visualRect.height = _visualization.minHeight;
         }
         if(param2)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 = new Rectangle();
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.width = _visualRect.width + 2 * 2500;
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.height = _visualization.minHeight != -1 ? _visualization.minHeight : _visualRect.height / 2;
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x - 2500;
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.y = _visualRect.y;
         }
         UnknownVarFromChatBubbleSimulationEntity_Number_3 = _visualization.scrolledUserPositionX;
      }
      
      public function dispose() : void
      {
         if(_visualization)
         {
            _visualization.readyToRecycle = true;
         }
         _visualization = null;
         _visualRect = null;
         UnknownVarFromChatBubbleSimulationEntity_Vector_1 = null;
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 = null;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         _y = param1;
         _visualRect.y = _y;
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.y = _visualRect.y;
         }
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         _x += (param1 - _x) * (1 - 0.1);
         _visualRect.x = _x;
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x - 2500;
         }
      }
      
      public function get visualRect() : Rectangle
      {
         return _visualRect;
      }
      
      public function get wideRect() : Rectangle
      {
         return !!UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 ? UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 : _visualRect;
      }
      
      public function get hasWideRect() : Boolean
      {
         return UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 != null;
      }
      
      public function get centerX() : Number
      {
         return _x + _visualRect.width / 2;
      }
      
      public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         _x = param1 + (!!_loc3_ ? _loc3_.x : 0);
         _y = param2 + (!!_loc3_ ? _loc3_.y : 0);
         _visualRect.x = _x;
         _visualRect.y = _y;
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x - 2500;
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.y = _visualRect.y;
         }
      }
      
      public function addHorizontalImpulse(param1:Number) : void
      {
         UnknownVarFromChatBubbleSimulationEntity_Number_1 += param1;
      }
      
      public function addCollisionHandled(param1:ChatBubbleSimulationEntity) : void
      {
         UnknownVarFromChatBubbleSimulationEntity_Vector_1.push(param1);
      }
      
      public function hasCollidedWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return UnknownVarFromChatBubbleSimulationEntity_Vector_1.indexOf(param1) != -1;
      }
      
      public function addVerticalImpulse(param1:Number) : void
      {
         UnknownVarFromChatBubbleSimulationEntity_Number_2 += param1;
      }
      
      public function applyImpulseForces(param1:int) : void
      {
         x += UnknownVarFromChatBubbleSimulationEntity_Number_1;
         y += Math.max(UnknownVarFromChatBubbleSimulationEntity_Number_2,-param1);
      }
      
      public function resetSimulationStep() : void
      {
         UnknownVarFromChatBubbleSimulationEntity_Number_1 = 0;
         UnknownVarFromChatBubbleSimulationEntity_Number_2 = 0;
         UnknownVarFromChatBubbleSimulationEntity_Vector_1 = new Vector.<ChatBubbleSimulationEntity>(0);
      }
      
      public function syncToVisualization(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = _visualization.overlap;
         param1 ||= UnknownVarFromChatBubbleSimulationEntity_Boolean_1;
         UnknownVarFromChatBubbleSimulationEntity_Boolean_1 = false;
         if(!param1)
         {
            _visualization.moveTo(int(_x - (!!_loc2_ ? _loc2_.x : 0)),int(_y - (!!_loc2_ ? _loc2_.y : 0)));
         }
         else
         {
            _visualization.warpTo(int(_x - (!!_loc2_ ? _loc2_.x : 0)),int(_y - (!!_loc2_ ? _loc2_.y : 0)));
         }
      }
      
      public function syncToUserScreenPosition() : void
      {
         var _loc2_:Number = _visualization.scrolledUserPositionX;
         var _loc1_:Number = _loc2_ - UnknownVarFromChatBubbleSimulationEntity_Number_3;
         if(_loc1_ != 0)
         {
            _x += _loc1_;
            _visualRect.x += _loc1_;
            if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
            {
               UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x += _loc1_;
            }
            UnknownVarFromChatBubbleSimulationEntity_Number_3 = _loc2_;
            UnknownVarFromChatBubbleSimulationEntity_Boolean_1 = true;
         }
      }
      
      public function set fullHeightCollision(param1:Boolean) : void
      {
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.height = param1 ? _visualRect.height : _visualRect.height / 2;
         }
      }
      
      public function get visualizationHasHitMargin() : Boolean
      {
         return _visualization.hasHitDesktopMargin;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         _visualization.readyToRecycle = param1;
      }
      
      public function get readyToRecycle() : Boolean
      {
         return _visualization.readyToRecycle;
      }
      
      public function get timeStamp() : uint
      {
         return _visualization.timeStamp;
      }
      
      public function get isSpacer() : Boolean
      {
         return _isSpacer;
      }
      
      public function set isSpacer(param1:Boolean) : void
      {
         _isSpacer = param1;
      }
      
      public function intersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            return _visualRect.intersects(param1._visualRect) || UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.intersects(param1.wideRect);
         }
         if(param1.UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            return _visualRect.intersects(param1._visualRect) || _visualRect.intersects(param1.UnknownVarFromChatBubbleSimulationEntity_Rectangle_1);
         }
         return _visualRect.intersects(param1._visualRect);
      }
      
      public function visualIntertersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return _visualRect.intersects(param1._visualRect);
      }
   }
}

