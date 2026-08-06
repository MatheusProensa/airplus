package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.UpgradeChestResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpgradeChestResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UpgradeChestResultMessageEvent(param1:Function)
      {
         super(param1,UpgradeChestResultMessageParser);
      }
      
      public function getParser() : UpgradeChestResultMessageParser
      {
         return this._parser as UpgradeChestResultMessageParser;
      }
   }
}

