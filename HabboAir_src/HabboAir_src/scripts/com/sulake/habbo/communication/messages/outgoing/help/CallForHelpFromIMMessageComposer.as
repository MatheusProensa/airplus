package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromIMMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCallForHelpFromIMMessageComposer_Array_1:Array = [];
      
      public function CallForHelpFromIMMessageComposer(param1:String, param2:int, param3:int, param4:Array, param5:String, param6:String)
      {
         super();
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param1);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param2);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param3);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param4.length / 2);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1 = this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.concat(param4);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param5);
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1.push(param6);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCallForHelpFromIMMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

