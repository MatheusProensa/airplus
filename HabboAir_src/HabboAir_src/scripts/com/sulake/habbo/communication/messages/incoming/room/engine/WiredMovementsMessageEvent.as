package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.WiredMovementsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredMovementsMessageEvent extends MessageEvent
   {
      public function WiredMovementsMessageEvent(param1:Function)
      {
         super(param1,WiredMovementsMessageParser);
      }
      
      public function getParser() : WiredMovementsMessageParser
      {
         return _parser as WiredMovementsMessageParser;
      }
   }
}

