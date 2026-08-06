package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSavedSearchesParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorSavedSearchesEvent extends MessageEvent
   {
      public function NavigatorSavedSearchesEvent(param1:Function)
      {
         super(param1,NavigatorSavedSearchesParser);
      }
      
      public function getParser() : NavigatorSavedSearchesParser
      {
         return parser as NavigatorSavedSearchesParser;
      }
   }
}

