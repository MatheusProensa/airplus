package com.sulake.habbo.communication.messages.incoming.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.treasurehunt.TreasureHuntFailMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFailMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TreasureHuntFailMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntFailMessageParser);
      }
      
      public function getParser() : TreasureHuntFailMessageParser
      {
         return _parser as TreasureHuntFailMessageParser;
      }
   }
}

