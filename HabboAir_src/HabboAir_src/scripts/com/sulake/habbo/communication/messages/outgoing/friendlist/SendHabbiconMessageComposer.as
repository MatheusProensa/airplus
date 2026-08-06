package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SendHabbiconMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSendHabbiconMessageComposer_Array_1:Array = [];
      
      public function SendHabbiconMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.UnknownVarFromSendHabbiconMessageComposer_Array_1.push(param1);
         this.UnknownVarFromSendHabbiconMessageComposer_Array_1.push(param2);
         this.UnknownVarFromSendHabbiconMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSendHabbiconMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSendHabbiconMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

