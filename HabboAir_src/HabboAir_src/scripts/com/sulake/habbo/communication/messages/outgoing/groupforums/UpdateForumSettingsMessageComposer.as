package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateForumSettingsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateForumSettingsMessageComposer_Array_1:Array = [];
      
      public function UpdateForumSettingsMessageComposer(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         this.UnknownVarFromUpdateForumSettingsMessageComposer_Array_1 = [param1,param2,param3,param4,param5];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateForumSettingsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateForumSettingsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

