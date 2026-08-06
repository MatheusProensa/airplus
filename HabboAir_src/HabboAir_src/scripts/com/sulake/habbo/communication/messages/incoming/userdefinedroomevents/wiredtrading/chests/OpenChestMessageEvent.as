package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.OpenChestMessageParser;
   
   [SecureSWF(rename="true")]
   public class OpenChestMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function OpenChestMessageEvent(param1:Function)
      {
         super(param1,OpenChestMessageParser);
      }
      
      public function getParser() : OpenChestMessageParser
      {
         return this._parser as OpenChestMessageParser;
      }
   }
}

