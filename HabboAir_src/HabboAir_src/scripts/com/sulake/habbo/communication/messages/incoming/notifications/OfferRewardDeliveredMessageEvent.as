package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.OfferRewardDeliveredMessageParser;
   
   [SecureSWF(rename="true")]
   public class OfferRewardDeliveredMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function OfferRewardDeliveredMessageEvent(param1:Function)
      {
         super(param1,OfferRewardDeliveredMessageParser);
      }
      
      public function getParser() : OfferRewardDeliveredMessageParser
      {
         return _parser as OfferRewardDeliveredMessageParser;
      }
   }
}

