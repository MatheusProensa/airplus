package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetModeratorUserInfoMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetModeratorUserInfoMessageComposer_Array_1:Array = [];
      
      public function GetModeratorUserInfoMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromGetModeratorUserInfoMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetModeratorUserInfoMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetModeratorUserInfoMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

