package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
   {
      private static const UnknownConstFromFurnitureQueueTileVisualization_Int_1:int = 3;
      
      private static const UnknownConstFromFurnitureQueueTileVisualization_Int_2:int = 2;
      
      private static const ANIMATION_ID_NORMAL:int = 1;
      
      private static const UnknownConstFromFurnitureQueueTileVisualization_Int_3:int = 15;
      
      private var UnknownVarFromFurnitureQueueTileVisualization_Array_1:Array = [];
      
      private var UnknownVarFromFurnitureQueueTileVisualization_Int_1:int;
      
      public function FurnitureQueueTileVisualization()
      {
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 2)
         {
            UnknownVarFromFurnitureQueueTileVisualization_Array_1 = [];
            UnknownVarFromFurnitureQueueTileVisualization_Array_1.push(1);
            UnknownVarFromFurnitureQueueTileVisualization_Int_1 = 15;
         }
         super.setAnimation(param1);
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(UnknownVarFromFurnitureQueueTileVisualization_Int_1 > 0)
         {
            UnknownVarFromFurnitureQueueTileVisualization_Int_1--;
         }
         if(UnknownVarFromFurnitureQueueTileVisualization_Int_1 == 0)
         {
            if(UnknownVarFromFurnitureQueueTileVisualization_Array_1.length > 0)
            {
               super.setAnimation(UnknownVarFromFurnitureQueueTileVisualization_Array_1.shift());
            }
         }
         return super.updateAnimation(param1);
      }
      
      override protected function usesAnimationResetting() : Boolean
      {
         return true;
      }
   }
}

