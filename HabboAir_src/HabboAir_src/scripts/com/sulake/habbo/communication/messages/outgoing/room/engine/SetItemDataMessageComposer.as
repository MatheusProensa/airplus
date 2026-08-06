package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetItemDataMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSetItemDataMessageComposer_Int_1:int;
      
      private var UnknownVarFromSetItemDataMessageComposer_String_1:String;
      
      private var UnknownVarFromSetItemDataMessageComposer_String_2:String;
      
      public function SetItemDataMessageComposer(param1:int, param2:String = "", param3:String = "")
      {
         super();
         UnknownVarFromSetItemDataMessageComposer_Int_1 = param1;
         UnknownVarFromSetItemDataMessageComposer_String_1 = param3;
         UnknownVarFromSetItemDataMessageComposer_String_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetItemDataMessageComposer_Int_1,UnknownVarFromSetItemDataMessageComposer_String_2,UnknownVarFromSetItemDataMessageComposer_String_1];
      }
   }
}

