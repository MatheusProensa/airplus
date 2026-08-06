package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class FloatingIdleZ implements IGameClickTarget
   {
      private static const DELAY_BEFORE_ANIMATION:int = 2000;
      
      private static const DELAY_PER_FRAME:int = 2000;
      
      private static const STATE_DELAY:int = 0;
      
      private static const STATE_FRAME_A:int = 1;
      
      private static const STATE_FRAME_B:int = 2;
      
      protected var _id:int;
      
      protected var UnknownVarFromFloatingIdleZ_AvatarVisualization_1:AvatarVisualization;
      
      private var UnknownVarFromFloatingIdleZ_BitmapDataAsset_1:BitmapDataAsset;
      
      private var _startTime:int;
      
      private var _offsetY:int;
      
      private var UnknownVarFromFloatingIdleZ_Number_1:Number;
      
      private var UnknownVarFromFloatingIdleZ_Int_1:int = -1;
      
      public function FloatingIdleZ(param1:int, param2:AvatarVisualization)
      {
         super();
         _id = param1;
         UnknownVarFromFloatingIdleZ_AvatarVisualization_1 = param2;
         _startTime = getTimer();
         UnknownVarFromFloatingIdleZ_Int_1 = 0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromFloatingIdleZ_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromFloatingIdleZ_AvatarVisualization_1 = null;
         UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 = null;
      }
      
      protected function getAssetNameForFrame(param1:int) : String
      {
         var _loc2_:String = "left";
         if(UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 135 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 180 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 225 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 270)
         {
            _loc2_ = "right";
         }
         return "user_idle_" + _loc2_ + "_" + param1 + (UnknownVarFromFloatingIdleZ_Number_1 < 48 ? "_small" : "") + "_png";
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(UnknownVarFromFloatingIdleZ_Int_1 == 0)
         {
            if(getTimer() - _startTime >= 2000)
            {
               UnknownVarFromFloatingIdleZ_Int_1 = 1;
               _startTime = getTimer();
               UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 = UnknownVarFromFloatingIdleZ_AvatarVisualization_1.getAvatarRendererAsset(getAssetNameForFrame(1)) as BitmapDataAsset;
            }
         }
         if(UnknownVarFromFloatingIdleZ_Int_1 == 1)
         {
            if(getTimer() - _startTime >= 2000)
            {
               UnknownVarFromFloatingIdleZ_Int_1 = 2;
               _startTime = getTimer();
               UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 = UnknownVarFromFloatingIdleZ_AvatarVisualization_1.getAvatarRendererAsset(getAssetNameForFrame(2)) as BitmapDataAsset;
            }
         }
         if(UnknownVarFromFloatingIdleZ_Int_1 == 2)
         {
            if(getTimer() - _startTime >= 2000)
            {
               UnknownVarFromFloatingIdleZ_Int_1 = 1;
               _startTime = getTimer();
               UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 = UnknownVarFromFloatingIdleZ_AvatarVisualization_1.getAvatarRendererAsset(getAssetNameForFrame(1)) as BitmapDataAsset;
            }
         }
         if(UnknownVarFromFloatingIdleZ_BitmapDataAsset_1)
         {
            param1.asset = UnknownVarFromFloatingIdleZ_BitmapDataAsset_1.content as BitmapData;
            param1.alpha = 255;
            param1.visible = true;
         }
         else
         {
            param1.visible = false;
         }
         return false;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         UnknownVarFromFloatingIdleZ_Number_1 = param2;
         UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 = UnknownVarFromFloatingIdleZ_AvatarVisualization_1.getAvatarRendererAsset(getAssetNameForFrame(UnknownVarFromFloatingIdleZ_Int_1 == 1 ? 1 : 2)) as BitmapDataAsset;
         var _loc4_:int = 64;
         if(param2 < 48)
         {
            if(UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 135 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 180 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 225 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 270)
            {
               _loc3_ = 10;
            }
            else
            {
               _loc3_ = -16;
            }
            _offsetY = -38;
            _loc4_ = 32;
         }
         else
         {
            if(UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 135 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 180 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 225 || UnknownVarFromFloatingIdleZ_AvatarVisualization_1.angle == 270)
            {
               _loc3_ = 22;
            }
            else
            {
               _loc3_ = -30;
            }
            _offsetY = -70;
         }
         if(UnknownVarFromFloatingIdleZ_AvatarVisualization_1.posture == "sit")
         {
            _offsetY += _loc4_ / 2;
         }
         else if(UnknownVarFromFloatingIdleZ_AvatarVisualization_1.posture == "lay")
         {
            _offsetY += _loc4_ - 0.3 * _loc4_;
         }
         if(UnknownVarFromFloatingIdleZ_BitmapDataAsset_1 != null)
         {
            param1.asset = UnknownVarFromFloatingIdleZ_BitmapDataAsset_1.content as BitmapData;
            param1.offsetX = _loc3_;
            param1.offsetY = _offsetY;
            param1.relativeDepth = -0.02;
            param1.alpha = 0;
         }
      }
   }
}

