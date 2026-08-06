package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetOfficialRoomsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetOfficialRoomsMessageComposer_Array_1:Array = [];
      
      public function GetOfficialRoomsMessageComposer(param1:int = 0)
      {
         super();
         UnknownVarFromGetOfficialRoomsMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetOfficialRoomsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetOfficialRoomsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

