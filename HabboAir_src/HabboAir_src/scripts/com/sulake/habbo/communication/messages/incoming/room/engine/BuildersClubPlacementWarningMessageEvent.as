package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.BuildersClubPlacementWarningMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlacementWarningMessageEvent extends MessageEvent
   {
      public function BuildersClubPlacementWarningMessageEvent(param1:Function)
      {
         super(param1,BuildersClubPlacementWarningMessageParser);
      }
      
      public function getParser() : BuildersClubPlacementWarningMessageParser
      {
         return _parser as BuildersClubPlacementWarningMessageParser;
      }
   }
}

