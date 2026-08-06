package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromSelfieMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCallForHelpFromSelfieMessageComposer_Array_1:Array = [];
      
      public function CallForHelpFromSelfieMessageComposer(param1:String, param2:int, param3:int, param4:String, param5:int)
      {
         super();
         this.UnknownVarFromCallForHelpFromSelfieMessageComposer_Array_1 = [param1,param2,param3,param4,param5];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCallForHelpFromSelfieMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCallForHelpFromSelfieMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

