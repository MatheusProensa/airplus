package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomAdSearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRoomAdSearchMessageComposer_Array_1:Array = [];
      
      public function RoomAdSearchMessageComposer(param1:int, param2:int)
      {
         super();
         this.UnknownVarFromRoomAdSearchMessageComposer_Array_1.push(param1);
         this.UnknownVarFromRoomAdSearchMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRoomAdSearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRoomAdSearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

