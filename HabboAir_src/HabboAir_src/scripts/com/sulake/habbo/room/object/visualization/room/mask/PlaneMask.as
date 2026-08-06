package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   
   public class PlaneMask
   {
      private var UnknownVarFromPlaneMask_Map_1:Map;
      
      private var _sizes:Array = [];
      
      private var _assetNames:Map;
      
      private var UnknownVarFromPlaneMask_PlaneMaskVisualization_1:PlaneMaskVisualization = null;
      
      private var UnknownVarFromPlaneMask_Int_1:int = -1;
      
      public function PlaneMask()
      {
         super();
         UnknownVarFromPlaneMask_Map_1 = new Map();
         _assetNames = new Map();
      }
      
      public function dispose() : void
      {
         var _loc2_:PlaneMaskVisualization = null;
         var _loc1_:int = 0;
         if(UnknownVarFromPlaneMask_Map_1 != null)
         {
            _loc2_ = null;
            _loc1_ = 0;
            while(_loc1_ < UnknownVarFromPlaneMask_Map_1.length)
            {
               _loc2_ = UnknownVarFromPlaneMask_Map_1.getWithIndex(_loc1_) as PlaneMaskVisualization;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            UnknownVarFromPlaneMask_Map_1.dispose();
            UnknownVarFromPlaneMask_Map_1 = null;
         }
         UnknownVarFromPlaneMask_PlaneMaskVisualization_1 = null;
         _sizes = null;
      }
      
      public function createMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(UnknownVarFromPlaneMask_Map_1.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc2_:PlaneMaskVisualization = new PlaneMaskVisualization();
         UnknownVarFromPlaneMask_Map_1.add(String(param1),_loc2_);
         _sizes.push(param1);
         _sizes.sort();
         return _loc2_;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         _loc3_ = 1;
         while(_loc3_ < _sizes.length)
         {
            if(_sizes[_loc3_] > param1)
            {
               if(_sizes[_loc3_] - param1 < param1 - _sizes[_loc3_ - 1])
               {
                  _loc2_ = _loc3_;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function getMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(param1 == UnknownVarFromPlaneMask_Int_1)
         {
            return UnknownVarFromPlaneMask_PlaneMaskVisualization_1;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < _sizes.length)
         {
            UnknownVarFromPlaneMask_PlaneMaskVisualization_1 = UnknownVarFromPlaneMask_Map_1.getValue(String(_sizes[_loc2_])) as PlaneMaskVisualization;
         }
         else
         {
            UnknownVarFromPlaneMask_PlaneMaskVisualization_1 = null;
         }
         UnknownVarFromPlaneMask_Int_1 = param1;
         return UnknownVarFromPlaneMask_PlaneMaskVisualization_1;
      }
      
      public function getGraphicAsset(param1:Number, param2:IVector3d) : IGraphicAsset
      {
         var _loc3_:PlaneMaskVisualization = getMaskVisualization(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getAsset(param2);
      }
      
      public function getAssetName(param1:int) : String
      {
         return _assetNames.getValue(param1);
      }
      
      public function setAssetName(param1:int, param2:String) : void
      {
         _assetNames.add(param1,param2);
      }
   }
}

