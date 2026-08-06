package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization
   {
      private static const ANIMATION_ID_OFFSET_SLOW1:int = 10;
      
      private static const ANIMATION_ID_OFFSET_SLOW2:int = 20;
      
      private static const UnknownConstFromFurnitureHabboWheelVisualization_Int_1:int = 31;
      
      private static const UnknownConstFromFurnitureHabboWheelVisualization_Int_2:int = 32;
      
      private var UnknownVarFromFurnitureHabboWheelVisualization_Array_1:Array = [];
      
      private var UnknownVarFromFurnitureHabboWheelVisualization_Boolean_1:Boolean = false;
      
      public function FurnitureHabboWheelVisualization()
      {
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!UnknownVarFromFurnitureHabboWheelVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureHabboWheelVisualization_Boolean_1 = true;
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1 = [];
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1.push(31);
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1.push(32);
               return;
            }
         }
         if(param1 > 0 && param1 <= 10)
         {
            if(UnknownVarFromFurnitureHabboWheelVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureHabboWheelVisualization_Boolean_1 = false;
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1 = [];
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1.push(10 + param1);
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1.push(20 + param1);
               UnknownVarFromFurnitureHabboWheelVisualization_Array_1.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(1) && super.getLastFramePlayed(2) && super.getLastFramePlayed(3))
         {
            if(UnknownVarFromFurnitureHabboWheelVisualization_Array_1.length > 0)
            {
               super.setAnimation(UnknownVarFromFurnitureHabboWheelVisualization_Array_1.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}

