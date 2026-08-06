package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationWithLimitedWideRect extends ChatBubbleSimulationEntity
   {
      public static const WIDERECT_WIDTH:int = 240;
      
      private var _wideRectOffset:Number;
      
      public function ChatBubbleSimulationWithLimitedWideRect(param1:PooledChatBubble)
      {
         super(param1,false);
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1 = new Rectangle();
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.width = 240;
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.height = _visualRect.height / 2;
         _wideRectOffset = -(240 - _visualRect.width) / 2;
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x + _wideRectOffset;
         UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.y = _visualRect.y;
      }
      
      override public function set x(param1:Number) : void
      {
         _x += (param1 - _x) * (1 - 0.1);
         _visualRect.x = _x;
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x + _wideRectOffset;
         }
      }
      
      override public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         _x = param1 + (!!_loc3_ ? _loc3_.x : 0);
         _y = param2 + (!!_loc3_ ? _loc3_.y : 0);
         _visualRect.x = _x;
         _visualRect.y = _y;
         if(UnknownVarFromChatBubbleSimulationEntity_Rectangle_1)
         {
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.x = _visualRect.x + _wideRectOffset;
            UnknownVarFromChatBubbleSimulationEntity_Rectangle_1.y = _visualRect.y;
         }
      }
      
      public function get wideRectOffset() : Number
      {
         return _wideRectOffset;
      }
      
      public function set wideRectOffset(param1:Number) : void
      {
         _wideRectOffset = param1;
      }
   }
}

