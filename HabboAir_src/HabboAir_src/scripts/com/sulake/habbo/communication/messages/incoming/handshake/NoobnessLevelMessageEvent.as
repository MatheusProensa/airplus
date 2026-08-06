package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.NoobnessLevelMessageEventMessageParser;
   
   [SecureSWF(rename="true")]
   public class NoobnessLevelMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function NoobnessLevelMessageEvent(param1:Function)
      {
         super(param1,NoobnessLevelMessageEventMessageParser);
      }
      
      public function get noobnessLevel() : int
      {
         return (this._parser as NoobnessLevelMessageEventMessageParser).noobnessLevel;
      }
   }
}

