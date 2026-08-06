package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateActionMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateActionMessageComposer_Array_1:Array = [];
      
      public function UpdateActionMessageComposer(param1:int, param2:Array, param3:Array, param4:String, param5:Array, param6:Array, param7:int, param8:Array, param9:Array)
      {
         super();
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param1);
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param2.length);
         for each(var _loc12_ in param2)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc12_);
         }
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param4);
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param5.length);
         for each(var _loc14_ in param5)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc14_);
         }
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param7);
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param8.length);
         for each(var _loc10_ in param8)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc10_);
         }
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param9.length);
         for each(var _loc15_ in param9)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc15_);
         }
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param3.length);
         for each(var _loc11_ in param3)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc11_);
         }
         UnknownVarFromUpdateActionMessageComposer_Array_1.push(param6.length);
         for each(var _loc13_ in param6)
         {
            UnknownVarFromUpdateActionMessageComposer_Array_1.push(_loc13_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateActionMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateActionMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

