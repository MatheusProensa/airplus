package com.sulake.core.window.iterators
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class ItemListIterator extends Proxy implements IIterator
   {
      private var UnknownVarFromItemListIterator_ItemListController_1:ItemListController;
      
      public function ItemListIterator(param1:ItemListController)
      {
         super();
         UnknownVarFromItemListIterator_ItemListController_1 = param1;
      }
      
      public function get length() : uint
      {
         return UnknownVarFromItemListIterator_ItemListController_1.numListItems;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromItemListIterator_ItemListController_1.getListItemIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return UnknownVarFromItemListIterator_ItemListController_1.getListItemAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:IWindowModel = null;
         _loc3_ = param2 as IWindowModel;
         var _loc4_:int = UnknownVarFromItemListIterator_ItemListController_1.getListItemIndex(_loc3_);
         if(_loc4_ == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            UnknownVarFromItemListIterator_ItemListController_1.removeListItem(_loc3_);
         }
         UnknownVarFromItemListIterator_ItemListController_1.addListItemAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < UnknownVarFromItemListIterator_ItemListController_1.numListItems ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromItemListIterator_ItemListController_1.getListItemAt(uint(param1) - 1);
      }
   }
}

