package com.sulake.habbo.communication.messages.incoming.gifts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.gifts.TryPhoneNumberResultParser;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TryPhoneNumberResultMessageEvent(param1:Function)
      {
         super(param1,TryPhoneNumberResultParser);
      }
      
      public function getParser() : TryPhoneNumberResultParser
      {
         return _parser as TryPhoneNumberResultParser;
      }
   }
}

