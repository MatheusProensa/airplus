package com.sulake.habbo.communication.messages.incoming.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.treasurehunt.TreasureHuntFirstWinnerMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFirstWinnerMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TreasureHuntFirstWinnerMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntFirstWinnerMessageParser);
      }
      
      public function getParser() : TreasureHuntFirstWinnerMessageParser
      {
         return _parser as TreasureHuntFirstWinnerMessageParser;
      }
   }
}

