package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetGuildFurniContextMenuInfoMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_1:int;
      
      private var UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_2:int;
      
      public function GetGuildFurniContextMenuInfoMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_1 = param1;
         UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_1,UnknownVarFromGetGuildFurniContextMenuInfoMessageComposer_Int_2];
      }
   }
}

