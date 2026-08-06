package com.sulake.habbo.communication.messages.incoming.vault
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.CreditVaultStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CreditVaultStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CreditVaultStatusMessageEvent(param1:Function)
      {
         super(param1,CreditVaultStatusMessageEventParser);
      }
      
      public function getParser() : CreditVaultStatusMessageEventParser
      {
         return _parser as CreditVaultStatusMessageEventParser;
      }
   }
}

