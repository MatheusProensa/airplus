package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetPopularRoomTagsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetPopularRoomTagsMessageComposer_Array_1:Array = [];
      
      public function GetPopularRoomTagsMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetPopularRoomTagsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetPopularRoomTagsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

