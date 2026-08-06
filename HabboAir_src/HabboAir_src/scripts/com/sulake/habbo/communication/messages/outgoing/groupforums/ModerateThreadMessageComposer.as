package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModerateThreadMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModerateThreadMessageComposer_Array_1:Array = [];
      
      public function ModerateThreadMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.UnknownVarFromModerateThreadMessageComposer_Array_1 = [param1,param2,param3];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModerateThreadMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModerateThreadMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

