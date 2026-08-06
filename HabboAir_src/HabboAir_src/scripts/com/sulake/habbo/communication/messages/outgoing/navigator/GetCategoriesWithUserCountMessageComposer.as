package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetCategoriesWithUserCountMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetCategoriesWithUserCountMessageComposer_Array_1:Array = [];
      
      public function GetCategoriesWithUserCountMessageComposer()
      {
         super();
      }
      
      public function GetPopularRoomTagsMessageComposer() : *
      {
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetCategoriesWithUserCountMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetCategoriesWithUserCountMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

