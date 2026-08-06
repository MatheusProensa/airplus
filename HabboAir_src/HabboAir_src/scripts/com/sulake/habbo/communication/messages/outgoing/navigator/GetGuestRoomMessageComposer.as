package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetGuestRoomMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetGuestRoomMessageComposer_Array_1:Array = [];
      
      public function GetGuestRoomMessageComposer(param1:int, param2:Boolean, param3:Boolean)
      {
         super();
         this.UnknownVarFromGetGuestRoomMessageComposer_Array_1.push(param1);
         this.UnknownVarFromGetGuestRoomMessageComposer_Array_1.push(param2 ? 1 : 0);
         this.UnknownVarFromGetGuestRoomMessageComposer_Array_1.push(param3 ? 1 : 0);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetGuestRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetGuestRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

