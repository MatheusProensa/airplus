package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.CallForHelpDisabledNotifyMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpDisabledNotifyMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CallForHelpDisabledNotifyMessageEvent(param1:Function)
      {
         super(param1,CallForHelpDisabledNotifyMessageParser);
      }
      
      public function getParser() : CallForHelpDisabledNotifyMessageParser
      {
         return _parser as CallForHelpDisabledNotifyMessageParser;
      }
   }
}

