package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ToggleStaffPickMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromToggleStaffPickMessageComposer_Array_1:Array = [];
      
      public function ToggleStaffPickMessageComposer(param1:int, param2:Boolean)
      {
         super();
         this.UnknownVarFromToggleStaffPickMessageComposer_Array_1.push(param1);
         this.UnknownVarFromToggleStaffPickMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromToggleStaffPickMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromToggleStaffPickMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

