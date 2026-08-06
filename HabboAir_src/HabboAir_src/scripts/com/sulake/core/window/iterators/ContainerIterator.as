package com.sulake.core.window.iterators
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.IIterator;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class ContainerIterator extends Proxy implements IIterator
   {
      private var UnknownVarFromContainerIterator_WindowController_1:WindowController;
      
      public function ContainerIterator(param1:WindowController)
      {
         super();
         UnknownVarFromContainerIterator_WindowController_1 = param1;
      }
      
      public function get length() : uint
      {
         return UnknownVarFromContainerIterator_WindowController_1.numChildren;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromContainerIterator_WindowController_1.getChildIndex(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return UnknownVarFromContainerIterator_WindowController_1.getChildAt(param1);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:IWindowModel = null;
         _loc3_ = param2 as IWindowModel;
         var _loc4_:int = UnknownVarFromContainerIterator_WindowController_1.getChildIndex(_loc3_);
         if(_loc4_ == param1)
         {
            return;
         }
         if(_loc4_ > -1)
         {
            UnknownVarFromContainerIterator_WindowController_1.removeChild(_loc3_);
         }
         UnknownVarFromContainerIterator_WindowController_1.addChildAt(_loc3_,param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < UnknownVarFromContainerIterator_WindowController_1.numChildren ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromContainerIterator_WindowController_1.getChildAt(uint(param1) - 1);
      }
   }
}

