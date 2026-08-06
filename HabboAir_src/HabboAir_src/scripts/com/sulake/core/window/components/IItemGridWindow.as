package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IItemGridWindow extends IWindowModel, IScrollableWindow, IIterable
   {
      function get spacing() : int;
      
      function set spacing(param1:int) : void;
      
      function set verticalSpacing(param1:int) : void;
      
      function get scaleToFitItems() : Boolean;
      
      function set scaleToFitItems(param1:Boolean) : void;
      
      function get autoArrangeItems() : Boolean;
      
      function set autoArrangeItems(param1:Boolean) : void;
      
      function get resizeOnItemUpdate() : Boolean;
      
      function set resizeOnItemUpdate(param1:Boolean) : void;
      
      function get numColumns() : uint;
      
      function get numRows() : uint;
      
      function get numGridItems() : uint;
      
      function addGridItem(param1:IWindowModel) : IWindowModel;
      
      function addGridItemAt(param1:IWindowModel, param2:uint) : IWindowModel;
      
      function getGridItemAt(param1:uint) : IWindowModel;
      
      function getGridItemByID(param1:uint) : IWindowModel;
      
      function getGridItemByName(param1:String) : IWindowModel;
      
      function getGridItemByTag(param1:String) : IWindowModel;
      
      function getGridItemIndex(param1:IWindowModel) : int;
      
      function removeGridItem(param1:IWindowModel) : IWindowModel;
      
      function removeGridItemAt(param1:int) : IWindowModel;
      
      function setGridItemIndex(param1:IWindowModel, param2:int) : void;
      
      function swapGridItems(param1:IWindowModel, param2:IWindowModel) : void;
      
      function swapGridItemsAt(param1:int, param2:int) : void;
      
      function removeGridItems() : void;
      
      function destroyGridItems() : void;
      
      function set shouldRebuildGridOnResize(param1:Boolean) : void;
      
      function get shouldRebuildGridOnResize() : Boolean;
      
      function rebuildGridStructure() : void;
      
      function set containerResizeToColumns(param1:Boolean) : void;
      
      function get containerResizeToColumns() : Boolean;
      
      function populate(param1:Array) : void;
   }
}

