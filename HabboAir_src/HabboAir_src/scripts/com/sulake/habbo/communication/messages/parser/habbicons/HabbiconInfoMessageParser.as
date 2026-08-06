package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabbiconInfoMessageParser implements IMessageParser
   {
      private var _habbicon:UnknownHabboCommunicationMessagesParserHabbicons2;
      
      private var UnknownVarFromHabbiconInfoMessageParser_UnknownHabboCommunicationMessagesParserHabbicons5_1:UnknownHabboCommunicationMessagesParserHabbicons5;
      
      public function HabbiconInfoMessageParser()
      {
         super();
         UnknownVarFromHabbiconInfoMessageParser_UnknownHabboCommunicationMessagesParserHabbicons5_1 = new UnknownHabboCommunicationMessagesParserHabbicons5();
      }
      
      public function get habbicon() : UnknownHabboCommunicationMessagesParserHabbicons2
      {
         return _habbicon;
      }
      
      public function flush() : Boolean
      {
         _habbicon = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _habbicon = UnknownVarFromHabbiconInfoMessageParser_UnknownHabboCommunicationMessagesParserHabbicons5_1.parse(param1);
         return true;
      }
   }
}

