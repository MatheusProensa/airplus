package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;
   
   [SecureSWF(rename="true")]
   public class MuteAllInRoomEvent extends MessageEvent implements IMessageEvent
   {
      public function MuteAllInRoomEvent(param1:Function)
      {
         super(param1,MuteAllInRoomParser);
      }
      
      public function getParser() : MuteAllInRoomParser
      {
         return this._parser as MuteAllInRoomParser;
      }
   }
}

