package com.sulake.habbo.communication.messages.outgoing.userclassification
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomUsersClassificationMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRoomUsersClassificationMessageComposer_String_1:String;
      
      public function RoomUsersClassificationMessageComposer(param1:String)
      {
         super();
         UnknownVarFromRoomUsersClassificationMessageComposer_String_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRoomUsersClassificationMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomUsersClassificationMessageComposer_String_1 = null;
      }
   }
}

