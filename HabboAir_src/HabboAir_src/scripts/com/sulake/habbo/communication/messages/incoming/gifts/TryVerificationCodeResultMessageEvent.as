package com.sulake.habbo.communication.messages.incoming.gifts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.gifts.TryVerificationCodeResultParser;
   
   [SecureSWF(rename="true")]
   public class TryVerificationCodeResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TryVerificationCodeResultMessageEvent(param1:Function)
      {
         super(param1,TryVerificationCodeResultParser);
      }
      
      public function getParser() : TryVerificationCodeResultParser
      {
         return _parser as TryVerificationCodeResultParser;
      }
   }
}

