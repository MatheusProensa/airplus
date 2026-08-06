package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSearchResultBlocksParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSearchResultBlocksEvent extends MessageEvent
   {
      public function NavigatorSearchResultBlocksEvent(param1:Function)
      {
         super(param1,NavigatorSearchResultBlocksParser);
      }
      
      public function getParser() : NavigatorSearchResultBlocksParser
      {
         return parser as NavigatorSearchResultBlocksParser;
      }
   }
}

