package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NewNavigatorPreferencesParser;
   
   [SecureSWF(rename="true")]
   public class NewNavigatorPreferencesEvent extends MessageEvent
   {
      public function NewNavigatorPreferencesEvent(param1:Function)
      {
         super(param1,NewNavigatorPreferencesParser);
      }
      
      public function getParser() : NewNavigatorPreferencesParser
      {
         return parser as NewNavigatorPreferencesParser;
      }
   }
}

