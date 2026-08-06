package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.utils.Vector3d;
   
   public class FurniturePlanetSystemVisualizationPlanetObject
   {
      private static const SYSTEM_TEMPO:Number = 30;
      
      private var _index:int;
      
      private var _name:String;
      
      private var _radius:Number;
      
      private var UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_1:Number;
      
      private var UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_2:Number;
      
      private var UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_3:Number;
      
      private var UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_4:Number;
      
      private var UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1:Vector3d = new Vector3d(0,0,0);
      
      private var _children:Array = [];
      
      public function FurniturePlanetSystemVisualizationPlanetObject(param1:String, param2:int, param3:Number, param4:Number, param5:Number, param6:Number)
      {
         super();
         _name = param1;
         _index = param2;
         _radius = param3;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_1 = param4 * 3.141592653589793 * 2 / 360;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_2 = param5 * 3.141592653589793 * 2 / 360;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_3 = param6;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_4 = 0;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function dispose() : void
      {
         var _loc1_:FurniturePlanetSystemVisualizationPlanetObject = null;
         while(_children.length > 0)
         {
            _loc1_ = _children.shift();
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function update(param1:Array, param2:Vector3d, param3:Number) : void
      {
         var _loc4_:FurniturePlanetSystemVisualizationPlanetObject = null;
         var _loc5_:int = 0;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_4 += UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_1 / 30;
         param1[_index] = getPositionVector(param2,param3);
         _loc5_ = 0;
         while(_loc5_ < _children.length)
         {
            _loc4_ = _children[_loc5_];
            _loc4_.update(param1,UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1,param3);
            _loc5_++;
         }
      }
      
      public function getPositionVector(param1:Vector3d, param2:Number) : Vector3d
      {
         var _loc3_:Number = _radius * Math.cos(UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_4 + UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_2);
         var _loc4_:Number = _radius * Math.sin(UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_4 + UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_2);
         var _loc5_:Number = UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_3;
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1.x = (_loc3_ - _loc4_) * (param2 / 2);
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1.y = (_loc4_ + _loc3_) * (param2 / 2) * 0.5 - UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Number_3 * (param2 / 2);
         UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1.z = -(int(4 * (_loc3_ + _loc4_) - 0.7));
         if(param1 != null)
         {
            UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1.add(param1);
         }
         return UnknownVarFromFurniturePlanetSystemVisualizationPlanetObject_Vector3d_1;
      }
      
      public function addChild(param1:FurniturePlanetSystemVisualizationPlanetObject) : void
      {
         if(_children.indexOf(param1) < 0)
         {
            _children.push(param1);
         }
      }
      
      public function hasChild(param1:String) : Boolean
      {
         var _loc2_:FurniturePlanetSystemVisualizationPlanetObject = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _children.length)
         {
            _loc2_ = _children[_loc3_];
            if(_loc2_.name == param1)
            {
               return true;
            }
            if(_loc2_.hasChild(param1))
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getChild(param1:String) : FurniturePlanetSystemVisualizationPlanetObject
      {
         var _loc2_:FurniturePlanetSystemVisualizationPlanetObject = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _children.length)
         {
            _loc2_ = _children[_loc3_];
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

