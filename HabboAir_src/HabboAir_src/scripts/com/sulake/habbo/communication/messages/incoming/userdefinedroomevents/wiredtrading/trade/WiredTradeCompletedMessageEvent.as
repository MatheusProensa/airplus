package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTrade1;
   
   [SecureSWF(rename="true")]
   public class WiredTradeCompletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTradeCompletedMessageEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTrade1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTrade1
      {
         return this._parser as UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTrade1;
      }
   }
}

