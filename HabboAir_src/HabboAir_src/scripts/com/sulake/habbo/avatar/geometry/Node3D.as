package com.sulake.habbo.avatar.geometry
{
   public class Node3D
   {
      private var _location:Vector3D;
      
      private var _transformedLocation:Vector3D = new Vector3D();
      
      private var UnknownVarFromNode3D_Boolean_1:Boolean = false;
      
      public function Node3D(param1:Number, param2:Number, param3:Number)
      {
         super();
         _location = new Vector3D(param1,param2,param3);
         if(param1 != 0 || param2 != 0 || param3 != 0)
         {
            UnknownVarFromNode3D_Boolean_1 = true;
         }
      }
      
      public function get location() : Vector3D
      {
         return _location;
      }
      
      public function get transformedLocation() : Vector3D
      {
         return _transformedLocation;
      }
      
      public function applyTransform(param1:Matrix4x4) : void
      {
         if(UnknownVarFromNode3D_Boolean_1)
         {
            _transformedLocation = param1.vectorMultiplication(_location);
         }
      }
   }
}

