package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.ElementPointerMessageParser;
   
   [SecureSWF(rename="true")]
   public class ElementPointerMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ElementPointerMessageEvent(param1:Function)
      {
         super(param1,ElementPointerMessageParser);
      }
      
      public function getParser() : ElementPointerMessageParser
      {
         return _parser as ElementPointerMessageParser;
      }
   }
}

