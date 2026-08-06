package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageParser;
   
   [SecureSWF(rename="true")]
   public class GotMysteryBoxPrizeMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GotMysteryBoxPrizeMessageEvent(param1:Function)
      {
         super(param1,GotMysteryBoxPrizeMessageParser);
      }
      
      public function getParser() : GotMysteryBoxPrizeMessageParser
      {
         return _parser as GotMysteryBoxPrizeMessageParser;
      }
   }
}

