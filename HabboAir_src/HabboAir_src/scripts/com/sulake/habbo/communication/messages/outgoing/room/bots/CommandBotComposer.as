package com.sulake.habbo.communication.messages.outgoing.room.bots
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CommandBotComposer implements IMessageComposer
   {
      private var UnknownVarFromCommandBotComposer_Int_1:int;
      
      private var UnknownVarFromCommandBotComposer_Int_2:int;
      
      private var UnknownVarFromCommandBotComposer_String_1:String;
      
      public function CommandBotComposer(param1:int, param2:int, param3:String)
      {
         super();
         UnknownVarFromCommandBotComposer_Int_1 = param1;
         UnknownVarFromCommandBotComposer_Int_2 = param2;
         UnknownVarFromCommandBotComposer_String_1 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromCommandBotComposer_Int_1,UnknownVarFromCommandBotComposer_Int_2,UnknownVarFromCommandBotComposer_String_1];
      }
   }
}

