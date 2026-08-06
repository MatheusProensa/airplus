package com.sulake.habbo.catalog.viewer
{
   public interface IItemGrid
   {
      function select(param1:IProductGridItem, param2:Boolean) : void;
      
      function startDragAndDrop(param1:IProductGridItem) : Boolean;
      
      function dispose() : void;
   }
}

