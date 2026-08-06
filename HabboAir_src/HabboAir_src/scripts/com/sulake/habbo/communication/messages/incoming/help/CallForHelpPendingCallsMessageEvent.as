package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpPendingCallsMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpPendingCallsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CallForHelpPendingCallsMessageEvent(param1:Function)
      {
         super(param1,CallForHelpPendingCallsMessageParser);
      }
      
      public function getParser() : CallForHelpPendingCallsMessageParser
      {
         return _parser as CallForHelpPendingCallsMessageParser;
      }
   }
}

