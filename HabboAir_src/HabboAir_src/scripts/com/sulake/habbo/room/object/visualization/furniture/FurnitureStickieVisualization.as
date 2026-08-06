package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class FurnitureStickieVisualization extends FurnitureVisualization
   {
      private var UnknownVarFromFurnitureStickieVisualization_FurnitureVisualizationData_1:FurnitureVisualizationData = null;
      
      public function FurnitureStickieVisualization()
      {
         super();
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         UnknownVarFromFurnitureStickieVisualization_FurnitureVisualizationData_1 = param1 as FurnitureVisualizationData;
         return super.initialize(param1);
      }
      
      override protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(UnknownVarFromFurnitureStickieVisualization_FurnitureVisualizationData_1 == null)
         {
            return 16777215;
         }
         return UnknownVarFromFurnitureStickieVisualization_FurnitureVisualizationData_1.getColor(param1,param2,param3);
      }
   }
}

