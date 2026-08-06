package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class ClickFurniMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromClickFurniMessageComposer_Int_1:int;
      
      private var UnknownVarFromClickFurniMessageComposer_Int_2:int = 0;
      
      public function ClickFurniMessageComposer(param1:int, param2:int = 0)
      {
         super();
         UnknownVarFromClickFurniMessageComposer_Int_1 = param1;
         UnknownVarFromClickFurniMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromClickFurniMessageComposer_Int_1,UnknownVarFromClickFurniMessageComposer_Int_2];
      }
   }
}

