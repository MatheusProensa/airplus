package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class NumberBubble implements IGameClickTarget
   {
      private var _id:int = -1;
      
      private var UnknownVarFromNumberBubble_AvatarVisualization_1:AvatarVisualization;
      
      private var UnknownVarFromNumberBubble_BitmapDataAsset_1:BitmapDataAsset;
      
      private var UnknownVarFromNumberBubble_Number_1:Number;
      
      private var UnknownVarFromNumberBubble_Int_1:int = 0;
      
      private var UnknownVarFromNumberBubble_Int_2:int = 0;
      
      private var UnknownVarFromNumberBubble_Boolean_1:Boolean = false;
      
      private var UnknownVarFromNumberBubble_Int_3:int = 0;
      
      public function NumberBubble(param1:int, param2:int, param3:AvatarVisualization)
      {
         super();
         _id = param1;
         UnknownVarFromNumberBubble_Int_1 = param2;
         UnknownVarFromNumberBubble_AvatarVisualization_1 = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromNumberBubble_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromNumberBubble_AvatarVisualization_1 = null;
         UnknownVarFromNumberBubble_BitmapDataAsset_1 = null;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return;
         }
         UnknownVarFromNumberBubble_Number_1 = param2;
         if(UnknownVarFromNumberBubble_Int_1 > 0)
         {
            _loc5_ = 64;
            if(param2 < 48)
            {
               UnknownVarFromNumberBubble_BitmapDataAsset_1 = UnknownVarFromNumberBubble_AvatarVisualization_1.getAvatarRendererAsset("number_" + UnknownVarFromNumberBubble_Int_1 + "_small_png") as BitmapDataAsset;
               _loc3_ = -6;
               _loc4_ = -52;
               _loc5_ = 32;
            }
            else
            {
               UnknownVarFromNumberBubble_BitmapDataAsset_1 = UnknownVarFromNumberBubble_AvatarVisualization_1.getAvatarRendererAsset("number_" + UnknownVarFromNumberBubble_Int_1 + "_png") as BitmapDataAsset;
               _loc3_ = -8;
               _loc4_ = -105;
            }
            if(UnknownVarFromNumberBubble_AvatarVisualization_1.posture == "sit")
            {
               _loc4_ += _loc5_ / 2;
            }
            else if(UnknownVarFromNumberBubble_AvatarVisualization_1.posture == "lay")
            {
               _loc4_ += _loc5_;
            }
            if(UnknownVarFromNumberBubble_BitmapDataAsset_1 != null)
            {
               param1.visible = true;
               param1.asset = UnknownVarFromNumberBubble_BitmapDataAsset_1.content as BitmapData;
               param1.offsetX = _loc3_;
               param1.offsetY = _loc4_;
               param1.relativeDepth = -0.01;
               UnknownVarFromNumberBubble_Int_2 = 1;
               UnknownVarFromNumberBubble_Boolean_1 = true;
               UnknownVarFromNumberBubble_Int_3 = 0;
               param1.alpha = 0;
            }
            else
            {
               param1.visible = false;
            }
         }
         else if(param1.visible)
         {
            UnknownVarFromNumberBubble_Int_2 = -1;
         }
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return false;
         }
         if(UnknownVarFromNumberBubble_BitmapDataAsset_1)
         {
            param1.asset = UnknownVarFromNumberBubble_BitmapDataAsset_1.content as BitmapData;
         }
         var _loc3_:int = param1.alpha;
         var _loc4_:Boolean = false;
         if(UnknownVarFromNumberBubble_Boolean_1)
         {
            UnknownVarFromNumberBubble_Int_3++;
            if(UnknownVarFromNumberBubble_Int_3 < 10)
            {
               return false;
            }
            if(UnknownVarFromNumberBubble_Int_2 < 0)
            {
               if(UnknownVarFromNumberBubble_Number_1 < 48)
               {
                  param1.offsetY -= 2;
               }
               else
               {
                  param1.offsetY -= 4;
               }
            }
            else
            {
               _loc2_ = 4;
               if(UnknownVarFromNumberBubble_Number_1 < 48)
               {
                  _loc2_ = 8;
               }
               if(UnknownVarFromNumberBubble_Int_3 % _loc2_ == 0)
               {
                  param1.offsetY -= 1;
                  _loc4_ = true;
               }
            }
         }
         if(UnknownVarFromNumberBubble_Int_2 > 0)
         {
            if(_loc3_ < 255)
            {
               _loc3_ += 32;
            }
            if(_loc3_ >= 255)
            {
               _loc3_ = 255;
               UnknownVarFromNumberBubble_Int_2 = 0;
            }
            param1.alpha = _loc3_;
            return true;
         }
         if(UnknownVarFromNumberBubble_Int_2 < 0)
         {
            if(_loc3_ >= 0)
            {
               _loc3_ -= 32;
            }
            if(_loc3_ <= 0)
            {
               UnknownVarFromNumberBubble_Int_2 = 0;
               UnknownVarFromNumberBubble_Boolean_1 = false;
               _loc3_ = 0;
               param1.visible = false;
            }
            param1.alpha = _loc3_;
            return true;
         }
         return _loc4_;
      }
   }
}

