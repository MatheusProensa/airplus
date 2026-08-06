package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketResolutionMessageParser implements IMessageParser
   {
      private static const UnknownConstFromGuideTicketResolutionMessageParser_Int_1:int = 0;
      
      private static const UnknownConstFromGuideTicketResolutionMessageParser_Int_2:int = 1;
      
      private static const UnknownConstFromGuideTicketResolutionMessageParser_Int_3:int = 2;
      
      private var UnknownVarFromGuideTicketResolutionMessageParser_Int_1:int = -1;
      
      public function GuideTicketResolutionMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromGuideTicketResolutionMessageParser_Int_1 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         UnknownVarFromGuideTicketResolutionMessageParser_Int_1 = param1.readInteger();
         return true;
      }
      
      public function get localizationCode() : String
      {
         if(UnknownVarFromGuideTicketResolutionMessageParser_Int_1 == 0 || UnknownVarFromGuideTicketResolutionMessageParser_Int_1 == 1)
         {
            return "valid";
         }
         return "invalid";
      }
   }
}

