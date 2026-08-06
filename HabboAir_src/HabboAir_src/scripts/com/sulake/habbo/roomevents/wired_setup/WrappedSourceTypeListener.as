package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   
   public class WrappedSourceTypeListener implements IWiredInputSourcePicker
   {
      private var UnknownVarFromWrappedSourceTypeListener_DefaultElement_1:DefaultElement;
      
      private var UnknownVarFromWrappedSourceTypeListener_Int_1:int;
      
      public function WrappedSourceTypeListener(param1:DefaultElement, param2:int)
      {
         super();
         UnknownVarFromWrappedSourceTypeListener_DefaultElement_1 = param1;
         UnknownVarFromWrappedSourceTypeListener_Int_1 = param2;
      }
      
      public function set sourceType(param1:int) : void
      {
         UnknownVarFromWrappedSourceTypeListener_DefaultElement_1.roomEvents.wiredCtrl.setMergedSourceType(UnknownVarFromWrappedSourceTypeListener_Int_1,param1);
      }
   }
}

