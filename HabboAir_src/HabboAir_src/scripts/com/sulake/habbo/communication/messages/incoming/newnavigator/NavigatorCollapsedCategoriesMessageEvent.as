package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.newnavigator.CollapsedCategoriesMessageParser;
   
   [SecureSWF(rename="true")]
   public class NavigatorCollapsedCategoriesMessageEvent extends MessageEvent
   {
      public function NavigatorCollapsedCategoriesMessageEvent(param1:Function)
      {
         super(param1,CollapsedCategoriesMessageParser);
      }
      
      public function getParser() : CollapsedCategoriesMessageParser
      {
         return parser as CollapsedCategoriesMessageParser;
      }
   }
}

