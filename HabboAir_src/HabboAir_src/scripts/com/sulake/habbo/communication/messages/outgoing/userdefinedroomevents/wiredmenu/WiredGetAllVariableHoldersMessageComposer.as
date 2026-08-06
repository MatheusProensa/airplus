package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredGetAllVariableHoldersMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredGetAllVariableHoldersMessageComposer_Array_1:Array = [];
      
      public function WiredGetAllVariableHoldersMessageComposer(param1:String)
      {
         super();
         UnknownVarFromWiredGetAllVariableHoldersMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredGetAllVariableHoldersMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredGetAllVariableHoldersMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

