package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class HabbiconInfoEvent extends MessageEvent implements IMessageEvent
   {
      public function HabbiconInfoEvent(param1:Function)
      {
         super(param1,HabbiconInfoMessageParser);
      }
      
      public function getParser() : HabbiconInfoMessageParser
      {
         return _parser as HabbiconInfoMessageParser;
      }
   }
}

