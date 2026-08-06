package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class TypingBubble implements IGameClickTarget
   {
      private var _id:int = -1;
      
      private var UnknownVarFromTypingBubble_BitmapDataAsset_1:BitmapDataAsset;
      
      private var UnknownVarFromTypingBubble_AvatarVisualization_1:AvatarVisualization;
      
      private var _relativeDepth:Number = 0;
      
      public function TypingBubble(param1:int, param2:AvatarVisualization)
      {
         super();
         _id = param1;
         UnknownVarFromTypingBubble_AvatarVisualization_1 = param2;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         _relativeDepth = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromTypingBubble_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromTypingBubble_AvatarVisualization_1 = null;
         UnknownVarFromTypingBubble_BitmapDataAsset_1 = null;
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(UnknownVarFromTypingBubble_BitmapDataAsset_1 && param1)
         {
            param1.asset = UnknownVarFromTypingBubble_BitmapDataAsset_1.content as BitmapData;
         }
         return false;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         param1.visible = true;
         param1.relativeDepth = _relativeDepth;
         param1.alpha = 255;
         var _loc5_:int = 64;
         if(param2 < 48)
         {
            UnknownVarFromTypingBubble_BitmapDataAsset_1 = UnknownVarFromTypingBubble_AvatarVisualization_1.getAvatarRendererAsset("user_typing_small_png") as BitmapDataAsset;
            _loc3_ = 3;
            _loc4_ = -42;
            _loc5_ = 32;
         }
         else
         {
            UnknownVarFromTypingBubble_BitmapDataAsset_1 = UnknownVarFromTypingBubble_AvatarVisualization_1.getAvatarRendererAsset("user_typing_png") as BitmapDataAsset;
            _loc3_ = 14;
            _loc4_ = -83;
         }
         if(UnknownVarFromTypingBubble_AvatarVisualization_1.posture == "sit")
         {
            _loc4_ += _loc5_ / 2;
         }
         else if(UnknownVarFromTypingBubble_AvatarVisualization_1.posture == "lay")
         {
            _loc4_ += _loc5_;
         }
         if(UnknownVarFromTypingBubble_BitmapDataAsset_1 != null)
         {
            param1.asset = UnknownVarFromTypingBubble_BitmapDataAsset_1.content as BitmapData;
            param1.offsetX = _loc3_;
            param1.offsetY = _loc4_;
            param1.relativeDepth = -0.02;
         }
      }
   }
}

