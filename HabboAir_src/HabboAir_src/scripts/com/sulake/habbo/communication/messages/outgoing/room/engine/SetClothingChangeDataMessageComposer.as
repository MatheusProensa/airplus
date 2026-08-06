package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetClothingChangeDataMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSetClothingChangeDataMessageComposer_Int_1:int;
      
      private var UnknownVarFromSetClothingChangeDataMessageComposer_String_1:String;
      
      private var UnknownVarFromSetClothingChangeDataMessageComposer_String_2:String;
      
      public function SetClothingChangeDataMessageComposer(param1:int, param2:String, param3:String = "")
      {
         super();
         UnknownVarFromSetClothingChangeDataMessageComposer_Int_1 = param1;
         UnknownVarFromSetClothingChangeDataMessageComposer_String_1 = param2;
         UnknownVarFromSetClothingChangeDataMessageComposer_String_2 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetClothingChangeDataMessageComposer_Int_1,UnknownVarFromSetClothingChangeDataMessageComposer_String_1,UnknownVarFromSetClothingChangeDataMessageComposer_String_2];
      }
   }
}

