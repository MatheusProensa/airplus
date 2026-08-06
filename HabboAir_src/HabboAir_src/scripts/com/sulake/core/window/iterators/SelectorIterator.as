package com.sulake.core.window.iterators
{
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.SelectorController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class SelectorIterator extends Proxy implements IIterator
   {
      private var UnknownVarFromSelectorIterator_SelectorController_1:SelectorController;
      
      public function SelectorIterator(param1:SelectorController)
      {
         super();
         UnknownVarFromSelectorIterator_SelectorController_1 = param1;
      }
      
      public function get length() : uint
      {
         return UnknownVarFromSelectorIterator_SelectorController_1.numSelectables;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromSelectorIterator_SelectorController_1.getSelectableIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return UnknownVarFromSelectorIterator_SelectorController_1.getChildAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ISelectableWindow = param2 as ISelectableWindow;
         if(_loc3_)
         {
            _loc4_ = UnknownVarFromSelectorIterator_SelectorController_1.getSelectableIndex(_loc3_);
            if(_loc4_ == param1)
            {
               return;
            }
            if(_loc4_ > -1)
            {
               UnknownVarFromSelectorIterator_SelectorController_1.removeSelectable(_loc3_);
            }
            UnknownVarFromSelectorIterator_SelectorController_1.addSelectableAt(_loc3_,param1);
         }
         else
         {
            _loc4_ = UnknownVarFromSelectorIterator_SelectorController_1.getChildIndex(param2);
            if(_loc4_ == param1)
            {
               return;
            }
            if(_loc4_ > -1)
            {
               UnknownVarFromSelectorIterator_SelectorController_1.removeChild(_loc3_);
            }
            UnknownVarFromSelectorIterator_SelectorController_1.addChildAt(param2,param1);
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < UnknownVarFromSelectorIterator_SelectorController_1.numSelectables ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromSelectorIterator_SelectorController_1.getSelectableAt(uint(param1) - 1);
      }
   }
}

