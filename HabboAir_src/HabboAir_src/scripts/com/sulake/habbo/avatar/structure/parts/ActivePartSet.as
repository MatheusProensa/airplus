package com.sulake.habbo.avatar.structure.parts
{
   public class ActivePartSet
   {
      private var UnknownVarFromActivePartSet_String_1:String;
      
      private var _parts:Array;
      
      public function ActivePartSet(param1:XML)
      {
         super();
         UnknownVarFromActivePartSet_String_1 = String(param1.@id);
         _parts = [];
         for each(var _loc2_ in param1.activePart)
         {
            _parts.push(String(_loc2_["set-type"]));
         }
      }
      
      public function get parts() : Array
      {
         return _parts;
      }
   }
}

