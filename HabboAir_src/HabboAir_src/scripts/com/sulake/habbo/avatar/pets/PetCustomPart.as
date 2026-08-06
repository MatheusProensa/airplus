package com.sulake.habbo.avatar.pets
{
   public class PetCustomPart
   {
      private var _layerId:int;
      
      private var _partId:int;
      
      private var _paletteId:int;
      
      public function PetCustomPart(param1:int, param2:int, param3:int)
      {
         super();
         _layerId = param1;
         _partId = param2;
         _paletteId = param3;
      }
      
      public function get paletteId() : int
      {
         return _paletteId;
      }
      
      public function set paletteId(param1:int) : void
      {
         _paletteId = param1;
      }
      
      public function get partId() : int
      {
         return _partId;
      }
      
      public function set partId(param1:int) : void
      {
         _partId = param1;
      }
      
      public function get layerId() : int
      {
         return _layerId;
      }
      
      public function set layerId(param1:int) : void
      {
         _layerId = param1;
      }
   }
}

