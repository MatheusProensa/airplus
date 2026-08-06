package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredRewardResultMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredRewardResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromWiredRewardResultMessageEvent_Int_1:int = 6;
      
      public static const UnknownConstFromWiredRewardResultMessageEvent_Int_2:int = 7;
      
      public function WiredRewardResultMessageEvent(param1:Function)
      {
         super(param1,WiredRewardResultMessageParser);
      }
      
      public function getParser() : WiredRewardResultMessageParser
      {
         return this._parser as WiredRewardResultMessageParser;
      }
   }
}

