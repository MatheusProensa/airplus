package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class CfhTopicsInitMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CfhTopicsInitMessageEvent(param1:Function)
      {
         super(param1,CfhTopicsInitMessageParser);
      }
      
      public function getParser() : CfhTopicsInitMessageParser
      {
         return _parser as CfhTopicsInitMessageParser;
      }
   }
}

