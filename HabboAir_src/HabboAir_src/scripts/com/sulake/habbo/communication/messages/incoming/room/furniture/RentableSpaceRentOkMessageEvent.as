package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentOkMessageParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceRentOkMessageEvent extends MessageEvent
   {
      public function RentableSpaceRentOkMessageEvent(param1:Function)
      {
         super(param1,RentableSpaceRentOkMessageParser);
      }
      
      public function getParser() : RentableSpaceRentOkMessageParser
      {
         return parser as RentableSpaceRentOkMessageParser;
      }
   }
}

