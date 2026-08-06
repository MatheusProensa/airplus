package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CallForHelpMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCallForHelpMessageComposer_Array_1:Array = [];
      
      public function CallForHelpMessageComposer(param1:String, param2:int, param3:int, param4:int, param5:Array, param6:String, param7:String)
      {
         super();
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param1);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param2);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param3);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param4);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param5.length / 2);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1 = this.UnknownVarFromCallForHelpMessageComposer_Array_1.concat(param5);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param6);
         this.UnknownVarFromCallForHelpMessageComposer_Array_1.push(param7);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCallForHelpMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCallForHelpMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

