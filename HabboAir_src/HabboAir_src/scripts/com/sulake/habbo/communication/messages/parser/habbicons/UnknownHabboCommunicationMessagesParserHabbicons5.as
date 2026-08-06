package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class UnknownHabboCommunicationMessagesParserHabbicons5
   {
      public function UnknownHabboCommunicationMessagesParserHabbicons5()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : UnknownHabboCommunicationMessagesParserHabbicons2
      {
         var _loc2_:UnknownHabboCommunicationMessagesParserHabbicons2 = new UnknownHabboCommunicationMessagesParserHabbicons2();
         _loc2_.habbiconId = param1.readInteger();
         _loc2_.name = param1.readString();
         _loc2_.collectionId = param1.readInteger();
         _loc2_.state = param1.readInteger();
         _loc2_.priceCredits = param1.readInteger();
         _loc2_.priceActivityPoints = param1.readInteger();
         _loc2_.activityPointType = param1.readInteger();
         return _loc2_;
      }
   }
}

