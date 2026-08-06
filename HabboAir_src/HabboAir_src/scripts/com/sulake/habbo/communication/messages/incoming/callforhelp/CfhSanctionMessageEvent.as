package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class CfhSanctionMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CfhSanctionMessageEvent(param1:Function)
      {
         super(param1,CfhSanctionMessageParser);
      }
      
      public function getParser() : CfhSanctionMessageParser
      {
         return _parser as CfhSanctionMessageParser;
      }
   }
}

