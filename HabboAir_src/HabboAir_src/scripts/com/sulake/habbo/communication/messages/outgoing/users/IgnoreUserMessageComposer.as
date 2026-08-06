package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class IgnoreUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromIgnoreUserMessageComposer_Array_1:Array = [];
      
      public function IgnoreUserMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromIgnoreUserMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromIgnoreUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromIgnoreUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

