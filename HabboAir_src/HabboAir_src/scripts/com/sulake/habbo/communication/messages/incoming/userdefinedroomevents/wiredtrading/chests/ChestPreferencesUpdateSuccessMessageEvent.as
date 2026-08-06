package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.ChestPreferencesUpdateSuccessMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChestPreferencesUpdateSuccessMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ChestPreferencesUpdateSuccessMessageEvent(param1:Function)
      {
         super(param1,ChestPreferencesUpdateSuccessMessageParser);
      }
      
      public function getParser() : ChestPreferencesUpdateSuccessMessageParser
      {
         return this._parser as ChestPreferencesUpdateSuccessMessageParser;
      }
   }
}

