package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModerateRoomMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModerateRoomMessageComposer_Array_1:Array = [];
      
      public function ModerateRoomMessageComposer(param1:int, param2:Boolean, param3:Boolean, param4:Boolean)
      {
         super();
         this.UnknownVarFromModerateRoomMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModerateRoomMessageComposer_Array_1.push(param2 ? 1 : 0);
         this.UnknownVarFromModerateRoomMessageComposer_Array_1.push(param3 ? 1 : 0);
         this.UnknownVarFromModerateRoomMessageComposer_Array_1.push(param4 ? 1 : 0);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModerateRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModerateRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

