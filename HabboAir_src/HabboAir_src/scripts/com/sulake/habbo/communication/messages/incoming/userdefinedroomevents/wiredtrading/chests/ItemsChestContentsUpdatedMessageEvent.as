package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsUpdatedMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemsChestContentsUpdatedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ItemsChestContentsUpdatedMessageEvent(param1:Function)
      {
         super(param1,ItemsChestContentsUpdatedMessageParser);
      }
      
      public function getParser() : ItemsChestContentsUpdatedMessageParser
      {
         return this._parser as ItemsChestContentsUpdatedMessageParser;
      }
   }
}

