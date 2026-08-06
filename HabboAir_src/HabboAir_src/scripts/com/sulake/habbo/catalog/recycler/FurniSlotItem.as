package com.sulake.habbo.catalog.recycler
{
   public class FurniSlotItem
   {
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _typeId:int = 0;
      
      private var _xxxExtra:String = null;
      
      public function FurniSlotItem(param1:int, param2:int, param3:int = 0, param4:String = null)
      {
         super();
         _id = param1;
         _category = param2;
         _typeId = param3;
         _xxxExtra = param4;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get xxxExtra() : String
      {
         return _xxxExtra;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}

