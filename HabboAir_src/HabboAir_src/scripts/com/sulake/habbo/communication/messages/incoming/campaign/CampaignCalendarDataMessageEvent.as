package com.sulake.habbo.communication.messages.incoming.campaign
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarDataMessageParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CampaignCalendarDataMessageEvent(param1:Function)
      {
         super(param1,CampaignCalendarDataMessageParser);
      }
      
      public function getParser() : CampaignCalendarDataMessageParser
      {
         return _parser as CampaignCalendarDataMessageParser;
      }
   }
}

