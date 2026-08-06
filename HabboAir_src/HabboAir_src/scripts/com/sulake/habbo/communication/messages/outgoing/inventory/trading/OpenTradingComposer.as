package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenTradingComposer implements IMessageComposer
   {
      private var UnknownVarFromOpenTradingComposer_Int_1:int;
      
      public function OpenTradingComposer(param1:int)
      {
         super();
         UnknownVarFromOpenTradingComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromOpenTradingComposer_Int_1];
      }
   }
}

