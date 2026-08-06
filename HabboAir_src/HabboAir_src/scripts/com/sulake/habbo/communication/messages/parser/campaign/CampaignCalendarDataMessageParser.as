package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarDataMessageParser implements IMessageParser
   {
      private var UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1:CampaignCalendarData;
      
      public function CampaignCalendarDataMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1 = new CampaignCalendarData();
         UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1.parse(param1);
         return true;
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1 = null;
         return true;
      }
      
      public function cloneData() : CampaignCalendarData
      {
         return !!UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1 ? UnknownVarFromCampaignCalendarDataMessageParser_CampaignCalendarData_1.clone() : null;
      }
   }
}

