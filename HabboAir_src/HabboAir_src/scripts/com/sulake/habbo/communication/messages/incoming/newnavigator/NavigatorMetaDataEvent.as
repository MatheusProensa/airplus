package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorMetaDataParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorMetaDataEvent extends MessageEvent
   {
      public function NavigatorMetaDataEvent(param1:Function)
      {
         super(param1,NavigatorMetaDataParser);
      }
      
      public function getParser() : NavigatorMetaDataParser
      {
         return parser as NavigatorMetaDataParser;
      }
   }
}

