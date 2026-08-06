package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpDisabledNotifyMessageParser implements IMessageParser
   {
      private var _infoUrl:String;
      
      public function CallForHelpDisabledNotifyMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _infoUrl = param1.readString();
         return true;
      }
      
      public function get infoUrl() : String
      {
         return _infoUrl;
      }
   }
}

