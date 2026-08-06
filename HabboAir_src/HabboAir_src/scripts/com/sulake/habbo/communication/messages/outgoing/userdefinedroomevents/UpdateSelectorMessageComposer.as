package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public class UpdateSelectorMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateSelectorMessageComposer_Array_1:Array = [];
      
      public function UpdateSelectorMessageComposer(param1:int, param2:Array, param3:Array, param4:String, param5:Array, param6:Array, param7:Boolean, param8:Boolean, param9:Array, param10:Array)
      {
         super();
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param1);
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param2.length);
         for each(var _loc13_ in param2)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc13_);
         }
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param4);
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param5.length);
         for each(var _loc15_ in param5)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc15_);
         }
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param7);
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param8);
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param9.length);
         for each(var _loc11_ in param9)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc11_);
         }
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param10.length);
         for each(var _loc16_ in param10)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc16_);
         }
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param3.length);
         for each(var _loc12_ in param3)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc12_);
         }
         UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(param6.length);
         for each(var _loc14_ in param6)
         {
            UnknownVarFromUpdateSelectorMessageComposer_Array_1.push(_loc14_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateSelectorMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateSelectorMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

