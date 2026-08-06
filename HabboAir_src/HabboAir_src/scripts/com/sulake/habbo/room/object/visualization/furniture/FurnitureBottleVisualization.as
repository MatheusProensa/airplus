package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization
   {
      private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
      
      private static const ANIMATION_ID_OFFSET_SLOW2:int = 9;
      
      private static const UnknownConstFromFurnitureBottleVisualization_Int_1:int = -1;
      
      private var UnknownVarFromFurnitureBottleVisualization_Array_1:Array = [];
      
      private var UnknownVarFromFurnitureBottleVisualization_Boolean_1:Boolean = false;
      
      public function FurnitureBottleVisualization()
      {
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!UnknownVarFromFurnitureBottleVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureBottleVisualization_Boolean_1 = true;
               UnknownVarFromFurnitureBottleVisualization_Array_1 = [];
               UnknownVarFromFurnitureBottleVisualization_Array_1.push(-1);
               return;
            }
         }
         if(param1 >= 0 && param1 <= 7)
         {
            if(UnknownVarFromFurnitureBottleVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureBottleVisualization_Boolean_1 = false;
               UnknownVarFromFurnitureBottleVisualization_Array_1 = [];
               UnknownVarFromFurnitureBottleVisualization_Array_1.push(20);
               UnknownVarFromFurnitureBottleVisualization_Array_1.push(9 + param1);
               UnknownVarFromFurnitureBottleVisualization_Array_1.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(0))
         {
            if(UnknownVarFromFurnitureBottleVisualization_Array_1.length > 0)
            {
               super.setAnimation(UnknownVarFromFurnitureBottleVisualization_Array_1.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}

