package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.habbo.avatar.IAvatarImage_1;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class AvatarVisualizationData implements IRoomObjectVisualizationData
   {
      private var _avatarRenderer:IAvatarRenderManager = null;
      
      public function AvatarVisualizationData()
      {
         super();
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return _avatarRenderer;
      }
      
      public function set avatarRenderer(param1:IAvatarRenderManager) : void
      {
         _avatarRenderer = param1;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         _avatarRenderer = null;
      }
      
      public function getAvatar(param1:String, param2:Number, param3:String = null, param4:UnknownIHabboAvatar1 = null, param5:IAvatarImage_1 = null, param6:Boolean = false) : IAvatarImage_2
      {
         var _loc8_:IAvatarImage_2 = null;
         var _loc7_:String = null;
         if(_avatarRenderer != null)
         {
            _loc7_ = param2 > 48 ? "h" : "h_50";
            if(param6)
            {
               _loc8_ = _avatarRenderer.createBlockedAvatarImage(param1,_loc7_);
            }
            else
            {
               _loc8_ = _avatarRenderer.createAvatarImage(param1,_loc7_,param3,param4,param5);
            }
            return _loc8_;
         }
         return null;
      }
      
      public function getLayerCount(param1:String) : Number
      {
         return 0;
      }
      
      public function getAvatarRendererAsset(param1:String) : ISoundAsset
      {
         if(_avatarRenderer == null)
         {
            return null;
         }
         return _avatarRenderer.assets.getAssetByName(param1);
      }
   }
}

