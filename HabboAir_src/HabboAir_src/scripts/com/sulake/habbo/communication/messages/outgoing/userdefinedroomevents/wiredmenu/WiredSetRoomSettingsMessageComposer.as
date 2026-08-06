package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredSetRoomSettingsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1:Array = [];
      
      public function WiredSetRoomSettingsMessageComposer(param1:int, param2:int, param3:String)
      {
         super();
         UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1.push(param2);
         UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredSetRoomSettingsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

