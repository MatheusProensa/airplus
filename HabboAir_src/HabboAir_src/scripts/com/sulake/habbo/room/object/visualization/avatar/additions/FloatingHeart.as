package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class FloatingHeart extends ExpressionAddition
   {
      private static const DELAY_BEFORE_ANIMATION:int = 300;
      
      private static const STATE_DELAY:int = 0;
      
      private static const STATE_FADE_IN:int = 1;
      
      private static const STATE_FLOAT:int = 2;
      
      private static const STATE_COMPLETE:int = 3;
      
      private var UnknownVarFromFloatingHeart_BitmapDataAsset_1:BitmapDataAsset;
      
      private var _startTime:int;
      
      private var UnknownVarFromFloatingHeart_Number_1:Number = 0;
      
      private var _offsetY:int;
      
      private var UnknownVarFromFloatingHeart_Number_2:Number;
      
      private var UnknownVarFromFloatingHeart_Int_1:int = -1;
      
      public function FloatingHeart(param1:int, param2:int, param3:AvatarVisualization)
      {
         super(param1,param2,param3);
         _startTime = getTimer();
         UnknownVarFromFloatingHeart_Int_1 = 0;
      }
      
      override public function animate(param1:IRoomObjectSprite) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         if(UnknownVarFromFloatingHeart_BitmapDataAsset_1)
         {
            param1.asset = UnknownVarFromFloatingHeart_BitmapDataAsset_1.content as BitmapData;
         }
         if(UnknownVarFromFloatingHeart_Int_1 == 0)
         {
            if(getTimer() - _startTime < 300)
            {
               return false;
            }
            UnknownVarFromFloatingHeart_Int_1 = 1;
            param1.alpha = 0;
            param1.visible = true;
            UnknownVarFromFloatingHeart_Number_1 = 0;
            return true;
         }
         if(UnknownVarFromFloatingHeart_Int_1 == 1)
         {
            UnknownVarFromFloatingHeart_Number_1 += 0.1;
            param1.offsetY = _offsetY;
            param1.alpha = Math.pow(UnknownVarFromFloatingHeart_Number_1,0.9) * 255;
            if(UnknownVarFromFloatingHeart_Number_1 >= 1)
            {
               UnknownVarFromFloatingHeart_Number_1 = 0;
               param1.alpha = 255;
               UnknownVarFromFloatingHeart_Int_1 = 2;
            }
            return true;
         }
         if(UnknownVarFromFloatingHeart_Int_1 == 2)
         {
            _loc3_ = Math.pow(UnknownVarFromFloatingHeart_Number_1,0.9);
            UnknownVarFromFloatingHeart_Number_1 += 0.05;
            _loc2_ = UnknownVarFromFloatingHeart_Number_2 < 48 ? -30 : -40;
            param1.offsetY = _offsetY + (UnknownVarFromFloatingHeart_Number_1 < 1 ? _loc3_ : 1) * _loc2_;
            param1.alpha = (1 - _loc3_) * 255;
            if(param1.alpha <= 0)
            {
               param1.visible = false;
               UnknownVarFromFloatingHeart_Int_1 = 3;
            }
            return true;
         }
         return false;
      }
      
      override public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc5_:Number = NaN;
         if(!param1)
         {
            return;
         }
         UnknownVarFromFloatingHeart_Number_2 = param2;
         var _loc4_:int = 64;
         if(param2 < 48)
         {
            UnknownVarFromFloatingHeart_BitmapDataAsset_1 = UnknownVarFromExpressionAddition_AvatarVisualization_1.getAvatarRendererAsset("user_blowkiss_small_png") as BitmapDataAsset;
            if(UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 90 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 270)
            {
               _loc3_ = 0;
            }
            else if(UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 135 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 180 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 225)
            {
               _loc3_ = 6;
            }
            else
            {
               _loc3_ = -6;
            }
            _offsetY = -38;
            _loc4_ = 32;
         }
         else
         {
            UnknownVarFromFloatingHeart_BitmapDataAsset_1 = UnknownVarFromExpressionAddition_AvatarVisualization_1.getAvatarRendererAsset("user_blowkiss_png") as BitmapDataAsset;
            if(UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 90 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 270)
            {
               _loc3_ = -3;
            }
            else if(UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 135 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 180 || UnknownVarFromExpressionAddition_AvatarVisualization_1.angle == 225)
            {
               _loc3_ = 22;
            }
            else
            {
               _loc3_ = -30;
            }
            _offsetY = -70;
         }
         if(UnknownVarFromExpressionAddition_AvatarVisualization_1.posture == "sit")
         {
            _offsetY += _loc4_ / 2;
         }
         else if(UnknownVarFromExpressionAddition_AvatarVisualization_1.posture == "lay")
         {
            _offsetY += _loc4_;
         }
         if(UnknownVarFromFloatingHeart_BitmapDataAsset_1 != null)
         {
            param1.asset = UnknownVarFromFloatingHeart_BitmapDataAsset_1.content as BitmapData;
            param1.offsetX = _loc3_;
            param1.offsetY = _offsetY;
            param1.relativeDepth = -0.02;
            param1.alpha = 0;
            _loc5_ = UnknownVarFromFloatingHeart_Number_1;
            animate(param1);
            UnknownVarFromFloatingHeart_Number_1 = _loc5_;
         }
      }
   }
}

