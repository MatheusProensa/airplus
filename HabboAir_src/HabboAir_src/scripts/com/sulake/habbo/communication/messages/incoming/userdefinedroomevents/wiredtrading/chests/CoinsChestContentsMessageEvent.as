package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.CoinsChestContentsMessageParser;
   
   [SecureSWF(rename="true")]
   public class CoinsChestContentsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CoinsChestContentsMessageEvent(param1:Function)
      {
         super(param1,CoinsChestContentsMessageParser);
      }
      
      public function getParser() : CoinsChestContentsMessageParser
      {
         return this._parser as CoinsChestContentsMessageParser;
      }
   }
}

