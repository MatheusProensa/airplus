package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateAddonMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateAddonMessageComposer_Array_1:Array = [];
      
      public function UpdateAddonMessageComposer(param1:int, param2:Array, param3:Array, param4:String, param5:Array, param6:Array, param7:Array, param8:Array)
      {
         super();
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param1);
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param2.length);
         for each(var _loc11_ in param2)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc11_);
         }
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param4);
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param5.length);
         for each(var _loc13_ in param5)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc13_);
         }
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param7.length);
         for each(var _loc9_ in param7)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc9_);
         }
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param8.length);
         for each(var _loc14_ in param8)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc14_);
         }
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param3.length);
         for each(var _loc10_ in param3)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc10_);
         }
         UnknownVarFromUpdateAddonMessageComposer_Array_1.push(param6.length);
         for each(var _loc12_ in param6)
         {
            UnknownVarFromUpdateAddonMessageComposer_Array_1.push(_loc12_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateAddonMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateAddonMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

