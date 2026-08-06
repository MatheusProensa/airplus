package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubSubscriptionStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BuildersClubSubscriptionStatusMessageEvent(param1:Function)
      {
         super(param1,BuildersClubSubscriptionStatusMessageParser);
      }
      
      public function getParser() : BuildersClubSubscriptionStatusMessageParser
      {
         return this._parser as BuildersClubSubscriptionStatusMessageParser;
      }
   }
}

