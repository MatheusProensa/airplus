package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetRoomSessionTagsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSetRoomSessionTagsMessageComposer_Array_1:Array = [];
      
      public function SetRoomSessionTagsMessageComposer(param1:String, param2:String)
      {
         super();
         this.UnknownVarFromSetRoomSessionTagsMessageComposer_Array_1.push(param1);
         this.UnknownVarFromSetRoomSessionTagsMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSetRoomSessionTagsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSetRoomSessionTagsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

