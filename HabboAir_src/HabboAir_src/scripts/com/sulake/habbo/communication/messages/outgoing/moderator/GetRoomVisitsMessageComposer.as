package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetRoomVisitsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetRoomVisitsMessageComposer_Array_1:Array = [];
      
      public function GetRoomVisitsMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromGetRoomVisitsMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetRoomVisitsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetRoomVisitsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

