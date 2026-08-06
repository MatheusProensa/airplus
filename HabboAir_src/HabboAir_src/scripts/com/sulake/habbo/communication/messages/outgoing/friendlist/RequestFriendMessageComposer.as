package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RequestFriendMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRequestFriendMessageComposer_Array_1:Array = [];
      
      public function RequestFriendMessageComposer(param1:String)
      {
         super();
         this.UnknownVarFromRequestFriendMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRequestFriendMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRequestFriendMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

