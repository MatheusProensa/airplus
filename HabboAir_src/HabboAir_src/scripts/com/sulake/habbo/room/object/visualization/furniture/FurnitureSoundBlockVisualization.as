package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureSoundBlockVisualization extends AnimatedFurnitureVisualization
   {
      private var _frameIncrease:int = 1;
      
      private var UnknownVarFromFurnitureSoundBlockVisualization_Number_1:Number = 0;
      
      public function FurnitureSoundBlockVisualization()
      {
         super();
      }
      
      override protected function get frameIncrease() : int
      {
         return _frameIncrease;
      }
      
      override protected function updateAnimations(param1:Number) : int
      {
         UnknownVarFromFurnitureSoundBlockVisualization_Number_1 += object.getModel().getNumber("furniture_soundblock_relative_animation_speed");
         _frameIncrease = UnknownVarFromFurnitureSoundBlockVisualization_Number_1;
         UnknownVarFromFurnitureSoundBlockVisualization_Number_1 -= _frameIncrease;
         return super.updateAnimations(param1);
      }
   }
}

