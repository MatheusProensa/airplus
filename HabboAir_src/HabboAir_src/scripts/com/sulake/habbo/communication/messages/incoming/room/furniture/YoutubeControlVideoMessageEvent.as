package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeControlVideoMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeControlVideoMessageEvent extends MessageEvent
   {
      public function YoutubeControlVideoMessageEvent(param1:Function)
      {
         super(param1,YoutubeControlVideoMessageParser);
      }
      
      public function getParser() : YoutubeControlVideoMessageParser
      {
         return parser as YoutubeControlVideoMessageParser;
      }
   }
}

