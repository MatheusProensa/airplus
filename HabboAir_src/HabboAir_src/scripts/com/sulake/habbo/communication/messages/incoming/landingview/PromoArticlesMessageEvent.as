package com.sulake.habbo.communication.messages.incoming.landingview
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.landingview.PromoArticlesMessageParser;
   
   [SecureSWF(rename="true")]
   public class PromoArticlesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function PromoArticlesMessageEvent(param1:Function)
      {
         super(param1,PromoArticlesMessageParser);
      }
      
      public function getParser() : PromoArticlesMessageParser
      {
         return _parser as PromoArticlesMessageParser;
      }
   }
}

