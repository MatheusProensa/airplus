package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavoriteMembershipUpdateMessageEvent extends MessageEvent
   {
      public function FavoriteMembershipUpdateMessageEvent(param1:Function)
      {
         super(param1,FavouriteMembershipUpdateMessageParser);
      }
      
      public function getParser() : FavouriteMembershipUpdateMessageParser
      {
         return _parser as FavouriteMembershipUpdateMessageParser;
      }
   }
}

