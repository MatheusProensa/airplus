package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.OfficialSongIdMessageParser;
   
   [SecureSWF(rename="true")]
   public class OfficialSongIdMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function OfficialSongIdMessageEvent(param1:Function)
      {
         super(param1,OfficialSongIdMessageParser);
      }
      
      public function getParser() : OfficialSongIdMessageParser
      {
         return this._parser as OfficialSongIdMessageParser;
      }
   }
}

