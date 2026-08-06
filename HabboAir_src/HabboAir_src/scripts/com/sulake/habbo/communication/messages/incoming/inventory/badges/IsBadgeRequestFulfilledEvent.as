package com.sulake.habbo.communication.messages.incoming.inventory.badges
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.IsBadgeRequestFulfilledParser;
   
   [SecureSWF(rename="true")]
   public class IsBadgeRequestFulfilledEvent extends MessageEvent
   {
      public function IsBadgeRequestFulfilledEvent(param1:Function)
      {
         super(param1,IsBadgeRequestFulfilledParser);
      }
      
      public function getParser() : IsBadgeRequestFulfilledParser
      {
         return _parser as IsBadgeRequestFulfilledParser;
      }
   }
}

