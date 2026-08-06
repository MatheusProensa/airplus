package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.UnknownHabboCommunicationMessagesParserInventoryFurni1;
   
   [SecureSWF(rename="true")]
   public class FurniListAddOrUpdateEvent extends MessageEvent implements IMessageEvent
   {
      public function FurniListAddOrUpdateEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserInventoryFurni1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserInventoryFurni1
      {
         return this._parser as UnknownHabboCommunicationMessagesParserInventoryFurni1;
      }
   }
}

