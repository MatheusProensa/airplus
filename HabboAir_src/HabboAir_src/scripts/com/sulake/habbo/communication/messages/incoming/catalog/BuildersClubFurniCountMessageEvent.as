package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubFurniCountMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubFurniCountMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BuildersClubFurniCountMessageEvent(param1:Function)
      {
         super(param1,BuildersClubFurniCountMessageParser);
      }
      
      public function getParser() : BuildersClubFurniCountMessageParser
      {
         return this._parser as BuildersClubFurniCountMessageParser;
      }
   }
}

