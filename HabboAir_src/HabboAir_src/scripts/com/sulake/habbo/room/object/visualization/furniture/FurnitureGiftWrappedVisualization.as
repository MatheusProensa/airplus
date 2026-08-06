package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureGiftWrappedVisualization extends FurnitureVisualization
   {
      private var UnknownVarFromFurnitureGiftWrappedVisualization_Int_1:int = 0;
      
      private var UnknownVarFromFurnitureGiftWrappedVisualization_Int_2:int = 0;
      
      public function FurnitureGiftWrappedVisualization()
      {
         super();
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         updateTypes();
         super.update(param1,param2,param3,param4);
      }
      
      private function updateTypes() : void
      {
         var _loc5_:IRoomObjectModel = null;
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ != null)
         {
            _loc5_ = _loc2_.getModel();
            if(_loc5_ != null)
            {
               _loc1_ = 1000;
               _loc3_ = _loc5_.getString("furniture_extras");
               _loc4_ = parseInt(_loc3_);
               UnknownVarFromFurnitureGiftWrappedVisualization_Int_1 = Math.floor(_loc4_ / _loc1_);
               UnknownVarFromFurnitureGiftWrappedVisualization_Int_2 = _loc4_ % _loc1_;
            }
         }
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         if(param2 <= 1)
         {
            return UnknownVarFromFurnitureGiftWrappedVisualization_Int_1;
         }
         return UnknownVarFromFurnitureGiftWrappedVisualization_Int_2;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc3_:int = getSize(param1);
         var _loc4_:String = type;
         var _loc5_:String = "";
         if(param2 < spriteCount - 1)
         {
            _loc5_ = String.fromCharCode("a".charCodeAt() + param2);
         }
         else
         {
            _loc5_ = "sd";
         }
         var _loc6_:int = getFrameNumber(param1,param2);
         _loc4_ += "_" + _loc3_ + "_" + _loc5_ + "_" + direction;
         return _loc4_ + ("_" + _loc6_);
      }
   }
}

