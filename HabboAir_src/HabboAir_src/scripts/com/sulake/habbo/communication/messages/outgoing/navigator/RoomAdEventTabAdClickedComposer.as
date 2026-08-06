package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomAdEventTabAdClickedComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1:Array = [];
      
      public function RoomAdEventTabAdClickedComposer(param1:int, param2:String, param3:int)
      {
         super();
         this.UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1.push(param1);
         this.UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1.push(param2);
         this.UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRoomAdEventTabAdClickedComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

