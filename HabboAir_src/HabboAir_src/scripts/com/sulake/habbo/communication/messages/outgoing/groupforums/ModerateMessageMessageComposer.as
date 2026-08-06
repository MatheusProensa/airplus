package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModerateMessageMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModerateMessageMessageComposer_Array_1:Array = [];
      
      public function ModerateMessageMessageComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.UnknownVarFromModerateMessageMessageComposer_Array_1 = [param1,param2,param3,param4];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModerateMessageMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModerateMessageMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

