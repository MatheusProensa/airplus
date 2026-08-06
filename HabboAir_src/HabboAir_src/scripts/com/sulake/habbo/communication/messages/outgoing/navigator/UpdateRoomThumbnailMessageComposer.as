package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateRoomThumbnailMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1:Array = [];
      
      public function UpdateRoomThumbnailMessageComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param1);
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param2);
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param3);
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param4);
      }
      
      public function addObj(param1:int, param2:int) : void
      {
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param1);
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateRoomThumbnailMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

