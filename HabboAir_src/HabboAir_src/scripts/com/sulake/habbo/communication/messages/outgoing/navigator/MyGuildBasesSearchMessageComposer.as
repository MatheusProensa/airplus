package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MyGuildBasesSearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMyGuildBasesSearchMessageComposer_Array_1:Array = [];
      
      public function MyGuildBasesSearchMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMyGuildBasesSearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMyGuildBasesSearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

