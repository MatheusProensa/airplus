package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildFurniContextMenuInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildFurniContextMenuInfoMessageEvent(param1:Function)
      {
         super(param1,GuildFurniContextMenuInfoMessageParser);
      }
      
      public function getParser() : GuildFurniContextMenuInfoMessageParser
      {
         return _parser as GuildFurniContextMenuInfoMessageParser;
      }
   }
}

