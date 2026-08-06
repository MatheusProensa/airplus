package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class GuideStatusBubble implements IGameClickTarget
   {
      private var _id:int = -1;
      
      private var UnknownVarFromGuideStatusBubble_BitmapDataAsset_1:BitmapDataAsset;
      
      private var UnknownVarFromGuideStatusBubble_AvatarVisualization_1:AvatarVisualization;
      
      private var _relativeDepth:Number = 0;
      
      private var _status:int;
      
      public function GuideStatusBubble(param1:int, param2:AvatarVisualization, param3:int)
      {
         super();
         _id = param1;
         UnknownVarFromGuideStatusBubble_AvatarVisualization_1 = param2;
         _status = param3;
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
         return UnknownVarFromGuideStatusBubble_AvatarVisualization_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromGuideStatusBubble_AvatarVisualization_1 = null;
         UnknownVarFromGuideStatusBubble_BitmapDataAsset_1 = null;
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(UnknownVarFromGuideStatusBubble_BitmapDataAsset_1 && param1)
         {
            param1.asset = UnknownVarFromGuideStatusBubble_BitmapDataAsset_1.content as BitmapData;
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
         var _loc6_:String = _status == 1 ? "user_guide_bubble_png" : "user_guide_requester_bubble_png";
         if(param2 < 48)
         {
            UnknownVarFromGuideStatusBubble_BitmapDataAsset_1 = UnknownVarFromGuideStatusBubble_AvatarVisualization_1.getAvatarRendererAsset(_loc6_) as BitmapDataAsset;
            _loc3_ = -19;
            _loc4_ = -80;
            _loc5_ = 32;
         }
         else
         {
            UnknownVarFromGuideStatusBubble_BitmapDataAsset_1 = UnknownVarFromGuideStatusBubble_AvatarVisualization_1.getAvatarRendererAsset(_loc6_) as BitmapDataAsset;
            _loc3_ = -19;
            _loc4_ = -120;
         }
         if(UnknownVarFromGuideStatusBubble_AvatarVisualization_1.posture == "sit")
         {
            _loc4_ += _loc5_ / 2;
         }
         else if(UnknownVarFromGuideStatusBubble_AvatarVisualization_1.posture == "lay")
         {
            _loc4_ += _loc5_;
         }
         if(UnknownVarFromGuideStatusBubble_BitmapDataAsset_1 != null)
         {
            param1.asset = UnknownVarFromGuideStatusBubble_BitmapDataAsset_1.content as BitmapData;
            param1.offsetX = _loc3_;
            param1.offsetY = _loc4_;
            param1.relativeDepth = -0.02;
         }
      }
   }
}

