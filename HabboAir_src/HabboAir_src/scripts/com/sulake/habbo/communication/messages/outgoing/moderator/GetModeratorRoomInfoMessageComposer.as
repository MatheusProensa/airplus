package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetModeratorRoomInfoMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetModeratorRoomInfoMessageComposer_Array_1:Array = [];
      
      public function GetModeratorRoomInfoMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromGetModeratorRoomInfoMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetModeratorRoomInfoMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetModeratorRoomInfoMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

