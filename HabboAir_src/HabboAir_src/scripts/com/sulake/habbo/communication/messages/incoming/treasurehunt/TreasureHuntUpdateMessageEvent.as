package com.sulake.habbo.communication.messages.incoming.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.treasurehunt.TreasureHuntUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TreasureHuntUpdateMessageEvent(param1:Function)
      {
         super(param1,TreasureHuntUpdateMessageParser);
      }
      
      public function getParser() : TreasureHuntUpdateMessageParser
      {
         return _parser as TreasureHuntUpdateMessageParser;
      }
   }
}

