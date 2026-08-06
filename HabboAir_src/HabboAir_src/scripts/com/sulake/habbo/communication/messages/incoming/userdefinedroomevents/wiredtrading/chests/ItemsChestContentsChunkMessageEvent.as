package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.ItemsChestContentsChunkMessageParser;
   
   [SecureSWF(rename="true")]
   public class ItemsChestContentsChunkMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ItemsChestContentsChunkMessageEvent(param1:Function)
      {
         super(param1,ItemsChestContentsChunkMessageParser);
      }
      
      public function getParser() : ItemsChestContentsChunkMessageParser
      {
         return this._parser as ItemsChestContentsChunkMessageParser;
      }
   }
}

