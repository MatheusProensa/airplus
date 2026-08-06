package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredSetUserPermanentVariableComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1:Array = [];
      
      public function WiredSetUserPermanentVariableComposer(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         super();
         UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1.push(param1);
         UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1.push(param2);
         UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1.push(param3);
         UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1.push(param4);
         UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredSetUserPermanentVariableComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

