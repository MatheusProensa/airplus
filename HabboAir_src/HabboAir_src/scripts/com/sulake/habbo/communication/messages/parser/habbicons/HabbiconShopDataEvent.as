package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class HabbiconShopDataEvent extends MessageEvent implements IMessageEvent
   {
      public function HabbiconShopDataEvent(param1:Function)
      {
         super(param1,HabbiconShopDataMessageParser);
      }
      
      public function getParser() : HabbiconShopDataMessageParser
      {
         return _parser as HabbiconShopDataMessageParser;
      }
   }
}

