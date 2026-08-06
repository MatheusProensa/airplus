package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;
   
   [SecureSWF(rename="true")]
   public class GuideReportingStatusMessageParser implements IMessageParser
   {
      public static const UnknownConstFromGuideReportingStatusMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromGuideReportingStatusMessageParser_Int_2:int = 1;
      
      public static const UnknownConstFromGuideReportingStatusMessageParser_Int_3:int = 2;
      
      public static const UnknownConstFromGuideReportingStatusMessageParser_Int_4:int = 3;
      
      private var _statusCode:int;
      
      private var _pendingTicket:PendingGuideTicket;
      
      public function GuideReportingStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _pendingTicket = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _statusCode = param1.readInteger();
         if(_statusCode == 1)
         {
            _pendingTicket = new PendingGuideTicket(param1);
         }
         return true;
      }
      
      public function get statusCode() : int
      {
         return _statusCode;
      }
      
      public function get pendingTicket() : PendingGuideTicket
      {
         return _pendingTicket;
      }
      
      public function get localizationCode() : String
      {
         switch(_statusCode - 2)
         {
            case 0:
               return "blocked";
            case 1:
               return "tooquick";
            default:
               return "";
         }
      }
   }
}

