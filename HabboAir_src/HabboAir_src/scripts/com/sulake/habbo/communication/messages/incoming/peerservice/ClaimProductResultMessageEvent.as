package com.sulake.habbo.communication.messages.incoming.peerservice
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.peerservice.ClaimProductResultParser;
   
   [SecureSWF(rename="true")]
   public class ClaimProductResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ClaimProductResultMessageEvent(param1:Function)
      {
         super(param1,ClaimProductResultParser);
      }
      
      public function getParser() : ClaimProductResultParser
      {
         return _parser as ClaimProductResultParser;
      }
   }
}

