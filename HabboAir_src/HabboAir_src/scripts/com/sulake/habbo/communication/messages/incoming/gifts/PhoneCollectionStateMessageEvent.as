package com.sulake.habbo.communication.messages.incoming.gifts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.gifts.PhoneCollectionStateParser;
   
   [SecureSWF(rename="true")]
   public class PhoneCollectionStateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function PhoneCollectionStateMessageEvent(param1:Function)
      {
         super(param1,PhoneCollectionStateParser);
      }
      
      public function getParser() : PhoneCollectionStateParser
      {
         return _parser as PhoneCollectionStateParser;
      }
   }
}

