package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetUnreadForumsCountMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetUnreadForumsCountMessageComposer_Array_1:Array = [];
      
      public function GetUnreadForumsCountMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetUnreadForumsCountMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetUnreadForumsCountMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

