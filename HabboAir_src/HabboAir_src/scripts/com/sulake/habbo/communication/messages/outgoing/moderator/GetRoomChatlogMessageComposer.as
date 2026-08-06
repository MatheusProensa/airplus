package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetRoomChatlogMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetRoomChatlogMessageComposer_Array_1:Array = [];
      
      public function GetRoomChatlogMessageComposer(param1:int, param2:int)
      {
         super();
         this.UnknownVarFromGetRoomChatlogMessageComposer_Array_1.push(param1);
         this.UnknownVarFromGetRoomChatlogMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetRoomChatlogMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetRoomChatlogMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

