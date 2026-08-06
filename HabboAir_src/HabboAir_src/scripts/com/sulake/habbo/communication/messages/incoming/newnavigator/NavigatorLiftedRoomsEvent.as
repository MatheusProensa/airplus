package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorLiftedRoomsParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorLiftedRoomsEvent extends MessageEvent
   {
      public function NavigatorLiftedRoomsEvent(param1:Function)
      {
         super(param1,NavigatorLiftedRoomsParser);
      }
      
      public function getParser() : NavigatorLiftedRoomsParser
      {
         return parser as NavigatorLiftedRoomsParser;
      }
   }
}

