package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.avatar.IAvatarImage_1;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData;
   
   public class AvatarFurnitureVisualizationData extends FurnitureVisualizationData
   {
      private var UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1:AvatarVisualizationData;
      
      public function AvatarFurnitureVisualizationData()
      {
         super();
         UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1 = new AvatarVisualizationData();
      }
      
      public function set avatarRenderer(param1:IAvatarRenderManager) : void
      {
         UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1.avatarRenderer = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1.dispose();
         UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1 = null;
      }
      
      public function getAvatar(param1:String, param2:Number, param3:String = null, param4:UnknownIHabboAvatar1 = null, param5:IAvatarImage_1 = null) : IAvatarImage_2
      {
         return UnknownVarFromAvatarFurnitureVisualizationData_AvatarVisualizationData_1.getAvatar(param1,param2,param3,param4,param5);
      }
   }
}

