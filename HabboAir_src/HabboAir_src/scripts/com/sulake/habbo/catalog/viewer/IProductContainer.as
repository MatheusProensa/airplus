package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   
   public interface IProductContainer extends IComponentInterfaceQueue
   {
      function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void;
      
      function activate() : void;
      
      function get products() : Vector.<IProduct>;
      
      function get firstProduct() : IProduct;
      
      function set view(param1:IWindowController_1) : void;
      
      function get view() : IWindowController_1;
      
      function set grid(param1:IItemGrid) : void;
      
      function setClubIconLevel(param1:int) : void;
      
      function get offer() : UnknownIHabboCatalog1;
   }
}

