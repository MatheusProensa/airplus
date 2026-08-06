package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateForumReadMarkerMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1:Array = [0];
      
      public function UpdateForumReadMarkerMessageComposer()
      {
         super();
      }
      
      public function add(param1:int, param2:int, param3:Boolean) : void
      {
         UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1.push(param1,param2,param3);
         UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1[0]++;
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1;
      }
      
      public function get size() : int
      {
         return UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1[0];
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateForumReadMarkerMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

