package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class MutedBubble implements IGameClickTarget
   {
      private var _id:int = -1;
      
      private var UnknownVarFromMutedBubble_BitmapDataAsset_1:BitmapDataAsset;
      
      private var UnknownVarFromMutedBubble_AvatarVisualization_1:AvatarVisualization;
      
      private var _relativeDepth:Number = 0;
      
      public function MutedBubble(param1:int, param2:AvatarVisualization)
      {
         super();
         _id = param1;
         UnknownVarFromMutedBubble_AvatarVisualization_1 = param2;
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
         return UnknownVarFromMutedBubble_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromMutedBubble_AvatarVisualization_1 = null;
         UnknownVarFromMutedBubble_BitmapDataAsset_1 = null;
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(UnknownVarFromMutedBubble_BitmapDataAsset_1 && param1)
         {
            param1.asset = UnknownVarFromMutedBubble_BitmapDataAsset_1.content as BitmapData;
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
            UnknownVarFromMutedBubble_BitmapDataAsset_1 = UnknownVarFromMutedBubble_AvatarVisualization_1.getAvatarRendererAsset("user_muted_small_png") as BitmapDataAsset;
            _loc3_ = -12;
            _loc4_ = -66;
            _loc5_ = 32;
         }
         else
         {
            UnknownVarFromMutedBubble_BitmapDataAsset_1 = UnknownVarFromMutedBubble_AvatarVisualization_1.getAvatarRendererAsset("user_muted_png") as BitmapDataAsset;
            _loc3_ = -15;
            _loc4_ = -110;
         }
         if(UnknownVarFromMutedBubble_AvatarVisualization_1.posture == "sit")
         {
            _loc4_ += _loc5_ / 2;
         }
         else if(UnknownVarFromMutedBubble_AvatarVisualization_1.posture == "lay")
         {
            _loc4_ += _loc5_;
         }
         if(UnknownVarFromMutedBubble_BitmapDataAsset_1 != null)
         {
            param1.asset = UnknownVarFromMutedBubble_BitmapDataAsset_1.content as BitmapData;
            param1.offsetX = _loc3_;
            param1.offsetY = _loc4_;
            param1.relativeDepth = -0.02;
         }
      }
   }
}

