package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetCfhChatlogMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetCfhChatlogMessageComposer_Array_1:Array = [];
      
      public function GetCfhChatlogMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromGetCfhChatlogMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetCfhChatlogMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetCfhChatlogMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

