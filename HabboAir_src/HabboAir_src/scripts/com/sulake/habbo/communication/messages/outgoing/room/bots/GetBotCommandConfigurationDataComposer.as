package com.sulake.habbo.communication.messages.outgoing.room.bots
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetBotCommandConfigurationDataComposer implements IMessageComposer
   {
      private var UnknownVarFromGetBotCommandConfigurationDataComposer_Int_1:int;
      
      private var UnknownVarFromGetBotCommandConfigurationDataComposer_Int_2:int;
      
      public function GetBotCommandConfigurationDataComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromGetBotCommandConfigurationDataComposer_Int_1 = param1;
         UnknownVarFromGetBotCommandConfigurationDataComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetBotCommandConfigurationDataComposer_Int_1,UnknownVarFromGetBotCommandConfigurationDataComposer_Int_2];
      }
   }
}

