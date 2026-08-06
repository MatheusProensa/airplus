package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class Plane
   {
      private var UnknownVarFromPlane_Map_1:Map;
      
      private var _sizes:Array = [];
      
      private var UnknownVarFromPlane_PlaneVisualization_1:PlaneVisualization = null;
      
      private var UnknownVarFromPlane_Int_1:int = -1;
      
      public function Plane()
      {
         super();
         UnknownVarFromPlane_Map_1 = new Map();
      }
      
      public function isStatic(param1:int) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         var _loc1_:PlaneVisualization = null;
         var _loc2_:int = 0;
         if(UnknownVarFromPlane_Map_1 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromPlane_Map_1.length)
            {
               _loc1_ = UnknownVarFromPlane_Map_1.getWithIndex(_loc2_) as PlaneVisualization;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            UnknownVarFromPlane_Map_1.dispose();
            UnknownVarFromPlane_Map_1 = null;
         }
         UnknownVarFromPlane_PlaneVisualization_1 = null;
         _sizes = null;
      }
      
      public function clearCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneVisualization = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromPlane_Map_1.length)
         {
            _loc1_ = UnknownVarFromPlane_Map_1.getWithIndex(_loc2_) as PlaneVisualization;
            if(_loc1_ != null)
            {
               _loc1_.clearCache();
            }
            _loc2_++;
         }
      }
      
      public function createPlaneVisualization(param1:int, param2:int, param3:IRoomGeometry) : PlaneVisualization
      {
         if(UnknownVarFromPlane_Map_1.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc4_:PlaneVisualization = new PlaneVisualization(param1,param2,param3);
         UnknownVarFromPlane_Map_1.add(String(param1),_loc4_);
         _sizes.push(param1);
         _sizes.sort();
         return _loc4_;
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
      
      protected function getPlaneVisualization(param1:int) : PlaneVisualization
      {
         if(param1 == UnknownVarFromPlane_Int_1)
         {
            return UnknownVarFromPlane_PlaneVisualization_1;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < _sizes.length)
         {
            UnknownVarFromPlane_PlaneVisualization_1 = UnknownVarFromPlane_Map_1.getValue(String(_sizes[_loc2_])) as PlaneVisualization;
         }
         else
         {
            UnknownVarFromPlane_PlaneVisualization_1 = null;
         }
         UnknownVarFromPlane_Int_1 = param1;
         return UnknownVarFromPlane_PlaneVisualization_1;
      }
      
      public function getLayers() : Array
      {
         return getPlaneVisualization(UnknownVarFromPlane_Int_1).getLayers();
      }
   }
}

