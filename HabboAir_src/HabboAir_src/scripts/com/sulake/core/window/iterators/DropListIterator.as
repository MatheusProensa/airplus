package com.sulake.core.window.iterators
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.DropListController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class DropListIterator extends Proxy implements IIterator
   {
      private var UnknownVarFromDropListIterator_DropListController_1:DropListController;
      
      public function DropListIterator(param1:DropListController)
      {
         super();
         UnknownVarFromDropListIterator_DropListController_1 = param1;
      }
      
      public function get length() : uint
      {
         return UnknownVarFromDropListIterator_DropListController_1.numMenuItems;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromDropListIterator_DropListController_1.getMenuItemIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return UnknownVarFromDropListIterator_DropListController_1.getMenuItemAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:IWindowModel = null;
         _loc3_ = param2 as IWindowModel;
         var _loc4_:int = UnknownVarFromDropListIterator_DropListController_1.getMenuItemIndex(_loc3_);
         if(_loc4_ == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            UnknownVarFromDropListIterator_DropListController_1.removeMenuItem(_loc3_);
         }
         UnknownVarFromDropListIterator_DropListController_1.addMenuItemAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < UnknownVarFromDropListIterator_DropListController_1.numMenuItems ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromDropListIterator_DropListController_1.getMenuItemAt(uint(param1) - 1);
      }
   }
}

