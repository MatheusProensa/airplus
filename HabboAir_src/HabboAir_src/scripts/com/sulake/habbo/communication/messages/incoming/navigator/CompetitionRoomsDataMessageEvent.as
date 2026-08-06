package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.CompetitionRoomsDataMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionRoomsDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CompetitionRoomsDataMessageEvent(param1:Function)
      {
         super(param1,CompetitionRoomsDataMessageParser);
      }
      
      public function getParser() : CompetitionRoomsDataMessageParser
      {
         return this._parser as CompetitionRoomsDataMessageParser;
      }
   }
}

