package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   
   public class FurniturePlanetSystemVisualization extends AnimatedFurnitureVisualization
   {
      private var UnknownVarFromFurniturePlanetSystemVisualization_Array_1:Array;
      
      private var UnknownVarFromFurniturePlanetSystemVisualization_Array_2:Array;
      
      private var _offsetArray:Array = [];
      
      private var UnknownVarFromFurniturePlanetSystemVisualization_Vector3d_1:Vector3d = new Vector3d(0,0,0);
      
      public function FurniturePlanetSystemVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc1_:FurniturePlanetSystemVisualizationPlanetObject = null;
         if(UnknownVarFromFurniturePlanetSystemVisualization_Array_1 != null)
         {
            while(UnknownVarFromFurniturePlanetSystemVisualization_Array_1.length > 0)
            {
               _loc1_ = UnknownVarFromFurniturePlanetSystemVisualization_Array_1.shift();
               _loc1_.dispose();
            }
         }
         UnknownVarFromFurniturePlanetSystemVisualization_Array_1 = null;
         UnknownVarFromFurniturePlanetSystemVisualization_Array_2 = null;
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         var _loc2_:FurniturePlanetSystemVisualizationPlanetObject = null;
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(UnknownVarFromFurniturePlanetSystemVisualization_Array_1 == null && spriteCount > 0)
         {
            if(!readDefinition())
            {
               return 0;
            }
         }
         if(UnknownVarFromFurniturePlanetSystemVisualization_Array_1 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < UnknownVarFromFurniturePlanetSystemVisualization_Array_1.length)
            {
               _loc2_ = UnknownVarFromFurniturePlanetSystemVisualization_Array_1[_loc4_];
               _loc2_.update(_offsetArray,UnknownVarFromFurniturePlanetSystemVisualization_Vector3d_1,param1);
               _loc4_++;
            }
            _loc3_ = super.updateAnimation(param1);
            _loc6_ = int(_offsetArray.length < 31 ? _offsetArray.length : 31);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_ |= 1 << _loc5_;
               _loc5_++;
            }
            return _loc3_;
         }
         return 0;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(param3 < _offsetArray.length)
         {
            return _offsetArray[param3].x;
         }
         return super.getSpriteXOffset(param1,param2,param3);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(param3 < _offsetArray.length)
         {
            return _offsetArray[param3].y;
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(param3 < _offsetArray.length)
         {
            return _offsetArray[param3].z;
         }
         return super.getSpriteZOffset(param1,param2,param3);
      }
      
      private function readDefinition() : Boolean
      {
         var _loc4_:int = 0;
         var _loc8_:XML = null;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc5_:IRoomObjectModel = _loc2_.getModel();
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc7_:String = _loc5_.getString("furniture_planetsystem_data");
         var _loc6_:XMLList = XMLList(_loc7_);
         var _loc3_:XMLList = _loc6_.children();
         var _loc1_:int = int(_loc3_.length());
         UnknownVarFromFurniturePlanetSystemVisualization_Array_1 = [];
         UnknownVarFromFurniturePlanetSystemVisualization_Array_2 = [];
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc8_ = _loc3_[_loc4_];
            addPlanet(_loc8_.@name,_loc4_,_loc8_.@parent,Number(_loc8_.@radius),Number(_loc8_.@arcspeed),Number(_loc8_.@arcoffset),Number(_loc8_.@height));
            _loc4_++;
         }
         return true;
      }
      
      private function addPlanet(param1:String, param2:int, param3:String, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         var _loc8_:FurniturePlanetSystemVisualizationPlanetObject = null;
         if(UnknownVarFromFurniturePlanetSystemVisualization_Array_1 == null)
         {
            return;
         }
         var _loc9_:FurniturePlanetSystemVisualizationPlanetObject = new FurniturePlanetSystemVisualizationPlanetObject(param1,param2,param4,param5,param6,param7);
         _loc8_ = getPlanet(param3);
         if(_loc8_ != null)
         {
            _loc8_.addChild(_loc9_);
         }
         else
         {
            UnknownVarFromFurniturePlanetSystemVisualization_Array_1.push(_loc9_);
            UnknownVarFromFurniturePlanetSystemVisualization_Array_2.push(param1);
         }
      }
      
      private function getPlanet(param1:String) : FurniturePlanetSystemVisualizationPlanetObject
      {
         var _loc2_:FurniturePlanetSystemVisualizationPlanetObject = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromFurniturePlanetSystemVisualization_Array_1.length)
         {
            _loc2_ = UnknownVarFromFurniturePlanetSystemVisualization_Array_1[_loc3_];
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
            if(_loc2_.hasChild(param1))
            {
               return _loc2_.getChild(param1);
            }
            _loc3_++;
         }
         return null;
      }
   }
}

