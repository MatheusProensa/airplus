package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.roomlogs
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredGetRoomLogsComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredGetRoomLogsComposer_Array_1:Array = [];
      
      public function WiredGetRoomLogsComposer(param1:int, param2:int, param3:int, param4:int, param5:String)
      {
         super();
         UnknownVarFromWiredGetRoomLogsComposer_Array_1.push(param1);
         UnknownVarFromWiredGetRoomLogsComposer_Array_1.push(param2);
         UnknownVarFromWiredGetRoomLogsComposer_Array_1.push(param3);
         UnknownVarFromWiredGetRoomLogsComposer_Array_1.push(param4);
         UnknownVarFromWiredGetRoomLogsComposer_Array_1.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredGetRoomLogsComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredGetRoomLogsComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

