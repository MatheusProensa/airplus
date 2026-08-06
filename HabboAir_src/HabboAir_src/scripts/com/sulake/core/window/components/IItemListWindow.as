package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IItemListWindow extends IWindowModel, IScrollableWindow, IIterable
   {
      function get spacing() : int;
      
      function set spacing(param1:int) : void;
      
      function get scaleToFitItems() : Boolean;
      
      function set scaleToFitItems(param1:Boolean) : void;
      
      function get autoArrangeItems() : Boolean;
      
      function set autoArrangeItems(param1:Boolean) : void;
      
      function get resizeOnItemUpdate() : Boolean;
      
      function set resizeOnItemUpdate(param1:Boolean) : void;
      
      function get inverseResizeOnItemUpdate() : Boolean;
      
      function set inverseResizeOnItemUpdate(param1:Boolean) : void;
      
      function get numListItems() : int;
      
      function addListItem(param1:IWindowModel) : IWindowModel;
      
      function addListItemAt(param1:IWindowModel, param2:uint) : IWindowModel;
      
      function getListItemAt(param1:uint) : IWindowModel;
      
      function getListItemByID(param1:uint) : IWindowModel;
      
      function getListItemByName(param1:String) : IWindowModel;
      
      function getListItemByTag(param1:String) : IWindowModel;
      
      function getListItemIndex(param1:IWindowModel) : int;
      
      function removeListItem(param1:IWindowModel) : IWindowModel;
      
      function removeListItemAt(param1:int) : IWindowModel;
      
      function setListItemIndex(param1:IWindowModel, param2:int) : void;
      
      function swapListItems(param1:IWindowModel, param2:IWindowModel) : void;
      
      function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint;
      
      function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function swapListItemsAt(param1:int, param2:int) : void;
      
      function removeListItems() : void;
      
      function destroyListItems() : void;
      
      function arrangeListItems() : void;
      
      function populate(param1:Array) : void;
      
      function get isPartOfGridWindow() : Boolean;
      
      function set isPartOfGridWindow(param1:Boolean) : void;
      
      function get scrollableWindow() : IWindowModel;
      
      function scrollWithWheel(param1:Number, param2:Boolean) : Boolean;
   }
}

