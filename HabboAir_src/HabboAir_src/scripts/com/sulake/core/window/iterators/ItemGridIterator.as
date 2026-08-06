package com.sulake.core.window.iterators
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ItemGridController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class ItemGridIterator extends Proxy implements IIterator
   {
      private var UnknownVarFromItemGridIterator_ItemGridController_1:ItemGridController;
      
      public function ItemGridIterator(param1:ItemGridController)
      {
         super();
         UnknownVarFromItemGridIterator_ItemGridController_1 = param1;
      }
      
      public function get length() : uint
      {
         return UnknownVarFromItemGridIterator_ItemGridController_1.numGridItems;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromItemGridIterator_ItemGridController_1.getGridItemIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return UnknownVarFromItemGridIterator_ItemGridController_1.getGridItemAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:IWindowModel = null;
         _loc3_ = param2 as IWindowModel;
         var _loc4_:int = UnknownVarFromItemGridIterator_ItemGridController_1.getGridItemIndex(_loc3_);
         if(_loc4_ == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            UnknownVarFromItemGridIterator_ItemGridController_1.removeGridItem(_loc3_);
         }
         UnknownVarFromItemGridIterator_ItemGridController_1.addGridItemAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < UnknownVarFromItemGridIterator_ItemGridController_1.numGridItems ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromItemGridIterator_ItemGridController_1.getGridItemAt(uint(param1) - 1);
      }
   }
}

