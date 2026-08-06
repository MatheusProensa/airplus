package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredGetUserPermanentVariablesComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredGetUserPermanentVariablesComposer_Array_1:Array = [];
      
      public function WiredGetUserPermanentVariablesComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromWiredGetUserPermanentVariablesComposer_Array_1.push(param1);
         UnknownVarFromWiredGetUserPermanentVariablesComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredGetUserPermanentVariablesComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredGetUserPermanentVariablesComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

