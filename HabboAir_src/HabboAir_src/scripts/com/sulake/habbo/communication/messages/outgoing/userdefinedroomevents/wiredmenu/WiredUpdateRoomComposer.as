package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredUpdateRoomComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredUpdateRoomComposer_Array_1:Array = [];
      
      public function WiredUpdateRoomComposer(param1:Boolean)
      {
         super();
         UnknownVarFromWiredUpdateRoomComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredUpdateRoomComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredUpdateRoomComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

