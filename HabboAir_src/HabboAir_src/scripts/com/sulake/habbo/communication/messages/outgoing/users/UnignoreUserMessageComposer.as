package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UnignoreUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUnignoreUserMessageComposer_Array_1:Array = [];
      
      public function UnignoreUserMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromUnignoreUserMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUnignoreUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUnignoreUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

