package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ScrGetUserInfoMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromScrGetUserInfoMessageComposer_Array_1:Array = [];
      
      public function ScrGetUserInfoMessageComposer(param1:String)
      {
         super();
         this.UnknownVarFromScrGetUserInfoMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromScrGetUserInfoMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromScrGetUserInfoMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

