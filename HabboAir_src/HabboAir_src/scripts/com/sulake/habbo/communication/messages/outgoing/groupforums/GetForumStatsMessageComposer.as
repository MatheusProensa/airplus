package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetForumStatsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetForumStatsMessageComposer_Array_1:Array = [];
      
      public function GetForumStatsMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromGetForumStatsMessageComposer_Array_1 = [param1];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetForumStatsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetForumStatsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

