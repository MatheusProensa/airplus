package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.MysteryBoxKeysMessageParser;
   
   [SecureSWF(rename="true")]
   public class MysteryBoxKeysMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function MysteryBoxKeysMessageEvent(param1:Function)
      {
         super(param1,MysteryBoxKeysMessageParser);
      }
      
      public function getParser() : MysteryBoxKeysMessageParser
      {
         return _parser as MysteryBoxKeysMessageParser;
      }
   }
}

