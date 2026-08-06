package com.sulake.habbo.communication.messages.outgoing.quest
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class FriendRequestQuestCompleteMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromFriendRequestQuestCompleteMessageComposer_Array_1:Array = [];
      
      public function FriendRequestQuestCompleteMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromFriendRequestQuestCompleteMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromFriendRequestQuestCompleteMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

