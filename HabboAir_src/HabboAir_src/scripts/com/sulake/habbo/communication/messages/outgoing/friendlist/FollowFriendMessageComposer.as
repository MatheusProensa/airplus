package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class FollowFriendMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromFollowFriendMessageComposer_Array_1:Array = [];
      
      public function FollowFriendMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromFollowFriendMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromFollowFriendMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromFollowFriendMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

