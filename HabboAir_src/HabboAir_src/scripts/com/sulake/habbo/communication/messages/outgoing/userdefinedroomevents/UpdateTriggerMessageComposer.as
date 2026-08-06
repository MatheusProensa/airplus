package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateTriggerMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateTriggerMessageComposer_Array_1:Array = [];
      
      public function UpdateTriggerMessageComposer(param1:int, param2:Array, param3:Array, param4:String, param5:Array, param6:Array, param7:Array, param8:Array)
      {
         super();
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param1);
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param2.length);
         for each(var _loc11_ in param2)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc11_);
         }
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param4);
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param5.length);
         for each(var _loc13_ in param5)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc13_);
         }
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param7.length);
         for each(var _loc9_ in param7)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc9_);
         }
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param8.length);
         for each(var _loc14_ in param8)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc14_);
         }
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param3.length);
         for each(var _loc10_ in param3)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc10_);
         }
         UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(param6.length);
         for each(var _loc12_ in param6)
         {
            UnknownVarFromUpdateTriggerMessageComposer_Array_1.push(_loc12_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateTriggerMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateTriggerMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

