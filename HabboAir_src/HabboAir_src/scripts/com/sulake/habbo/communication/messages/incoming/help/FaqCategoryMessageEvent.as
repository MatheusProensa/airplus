package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.FaqCategoryMessageParser;
   
   [SecureSWF(rename="true")]
   public class FaqCategoryMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FaqCategoryMessageEvent(param1:Function)
      {
         super(param1,FaqCategoryMessageParser);
      }
      
      public function getParser() : FaqCategoryMessageParser
      {
         return _parser as FaqCategoryMessageParser;
      }
   }
}

