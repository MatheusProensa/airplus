package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.misc
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   public class SelfDonationResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SelfDonationResultMessageEvent(param1:Function)
      {
         super(param1,SelfDonationResultMessageParser);
      }
      
      public function getParser() : SelfDonationResultMessageParser
      {
         return _parser as SelfDonationResultMessageParser;
      }
   }
}

