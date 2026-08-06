package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
      
      private static const ANIMATION_ID_OFFSET_SLOW2:int = 10;
      
      private static const UnknownConstFromFurnitureValRandomizerVisualization_Int_1:int = 31;
      
      private static const UnknownConstFromFurnitureValRandomizerVisualization_Int_2:int = 32;
      
      private static const UnknownConstFromFurnitureValRandomizerVisualization_Int_3:int = 30;
      
      private var UnknownVarFromFurnitureValRandomizerVisualization_Array_1:Array = [];
      
      private var UnknownVarFromFurnitureValRandomizerVisualization_Boolean_1:Boolean = false;
      
      public function FurnitureValRandomizerVisualization()
      {
         super();
         super.setAnimation(30);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
         {
            if(!UnknownVarFromFurnitureValRandomizerVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureValRandomizerVisualization_Boolean_1 = true;
               UnknownVarFromFurnitureValRandomizerVisualization_Array_1 = [];
               UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(31);
               UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(32);
               return;
            }
         }
         if(param1 > 0 && param1 <= 10)
         {
            if(UnknownVarFromFurnitureValRandomizerVisualization_Boolean_1)
            {
               UnknownVarFromFurnitureValRandomizerVisualization_Boolean_1 = false;
               UnknownVarFromFurnitureValRandomizerVisualization_Array_1 = [];
               if(direction == 2)
               {
                  UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(20 + 5 - param1);
                  UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(10 + 5 - param1);
               }
               else
               {
                  UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(20 + param1);
                  UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(10 + param1);
               }
               UnknownVarFromFurnitureValRandomizerVisualization_Array_1.push(30);
               return;
            }
            super.setAnimation(30);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(11))
         {
            if(UnknownVarFromFurnitureValRandomizerVisualization_Array_1.length > 0)
            {
               super.setAnimation(UnknownVarFromFurnitureValRandomizerVisualization_Array_1.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}

