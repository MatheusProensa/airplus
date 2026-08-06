package com.sulake.core.window.theme
{
   import com.sulake.core.window.utils.*;
   import flash.utils.Dictionary;
   
   public class PropertyMap implements IPropertyMap
   {
      private var UnknownVarFromPropertyMap_Dictionary_1:Dictionary = new Dictionary();
      
      public function PropertyMap()
      {
         super();
      }
      
      private function add(param1:String, param2:Object, param3:String, param4:Array = null) : void
      {
         UnknownVarFromPropertyMap_Dictionary_1[param1] = new PropertyStruct(param1,param2,param3,false,param4);
      }
      
      public function addBoolean(param1:String, param2:Boolean) : void
      {
         add(param1,param2,"Boolean");
      }
      
      public function addInt(param1:String, param2:int) : void
      {
         add(param1,param2,"int");
      }
      
      public function addUint(param1:String, param2:uint) : void
      {
         add(param1,param2,"uint");
      }
      
      public function addHex(param1:String, param2:uint) : void
      {
         add(param1,param2,"hex");
      }
      
      public function addNumber(param1:String, param2:Number) : void
      {
         add(param1,param2,"Number");
      }
      
      public function addString(param1:String, param2:String) : void
      {
         add(param1,param2,"String");
      }
      
      public function addEnumeration(param1:String, param2:String, param3:Array) : void
      {
         add(param1,param2,"String",param3);
      }
      
      public function addArray(param1:String, param2:Array) : void
      {
         add(param1,param2,"Array");
      }
      
      public function get(param1:String) : PropertyStruct
      {
         return UnknownVarFromPropertyMap_Dictionary_1[param1];
      }
      
      public function clone() : PropertyMap
      {
         var _loc1_:PropertyMap = new PropertyMap();
         for(var _loc2_ in UnknownVarFromPropertyMap_Dictionary_1)
         {
            _loc1_.UnknownVarFromPropertyMap_Dictionary_1[_loc2_] = UnknownVarFromPropertyMap_Dictionary_1[_loc2_];
         }
         return _loc1_;
      }
   }
}

