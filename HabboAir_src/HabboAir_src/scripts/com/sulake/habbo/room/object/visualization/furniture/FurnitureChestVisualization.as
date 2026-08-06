package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureChestVisualization extends AnimatedFurnitureVisualization
   {
      private static const WIRED_EMBLEM_SPRITE_TAG:String = "wired_emblem";
      
      private var UnknownVarFromFurnitureChestVisualization_Boolean_1:Boolean = false;
      
      public function FurnitureChestVisualization()
      {
         super();
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:Boolean = super.updateModel(param1);
         var _loc3_:* = object.getModel().getNumber("furniture_chest_is_wired_enabled") == 1;
         if(_loc3_ != UnknownVarFromFurnitureChestVisualization_Boolean_1)
         {
            UnknownVarFromFurnitureChestVisualization_Boolean_1 = _loc3_;
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      override protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String = getSpriteTag(param1,param2,param3);
         if(!UnknownVarFromFurnitureChestVisualization_Boolean_1 && _loc4_ == "wired_emblem")
         {
            return 0;
         }
         return super.getSpriteAlpha(param1,param2,param3);
      }
   }
}

