package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.DirectSMSClubBuyAvailableMessageParser;
   
   [SecureSWF(rename="true")]
   public class DirectSMSClubBuyAvailableMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function DirectSMSClubBuyAvailableMessageEvent(param1:Function)
      {
         super(param1,DirectSMSClubBuyAvailableMessageParser);
      }
      
      public function getParser() : DirectSMSClubBuyAvailableMessageParser
      {
         return this._parser as DirectSMSClubBuyAvailableMessageParser;
      }
   }
}

