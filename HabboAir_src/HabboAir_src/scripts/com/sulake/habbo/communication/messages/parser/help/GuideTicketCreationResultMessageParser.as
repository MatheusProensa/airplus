package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideTicketCreationResultMessageParser implements IMessageParser
   {
      private static const UnknownConstFromGuideTicketCreationResultMessageParser_Int_1:int = 0;
      
      private static const UnknownConstFromGuideTicketCreationResultMessageParser_Int_2:int = 1;
      
      private static const UnknownConstFromGuideTicketCreationResultMessageParser_Int_3:int = 2;
      
      private static const UnknownConstFromGuideTicketCreationResultMessageParser_Int_4:int = 3;
      
      private var UnknownVarFromGuideTicketCreationResultMessageParser_Int_1:int = -1;
      
      public function GuideTicketCreationResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromGuideTicketCreationResultMessageParser_Int_1 = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         UnknownVarFromGuideTicketCreationResultMessageParser_Int_1 = param1.readInteger();
         return true;
      }
      
      public function get localizationCode() : String
      {
         switch(UnknownVarFromGuideTicketCreationResultMessageParser_Int_1)
         {
            case 0:
               return "sent";
            case 1:
               return "blocked";
            case 2:
               return "nochat";
            case 3:
               return "alreadyreported";
            default:
               return "invalid";
         }
      }
   }
}

