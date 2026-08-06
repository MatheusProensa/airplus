package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RemoveOwnRoomRightsRoomMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRemoveOwnRoomRightsRoomMessageComposer_Array_1:Array = [];
      
      public function RemoveOwnRoomRightsRoomMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromRemoveOwnRoomRightsRoomMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRemoveOwnRoomRightsRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRemoveOwnRoomRightsRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

