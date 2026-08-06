package com.sulake.habbo.communication.messages.parser.customfilter
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class GetCustomFilterResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GetCustomFilterResultMessageEvent(param1:Function)
      {
         super(param1,GetCustomFilterResultMessageEventParser);
      }
      
      public function getParser() : GetCustomFilterResultMessageEventParser
      {
         return _parser as GetCustomFilterResultMessageEventParser;
      }
   }
}

