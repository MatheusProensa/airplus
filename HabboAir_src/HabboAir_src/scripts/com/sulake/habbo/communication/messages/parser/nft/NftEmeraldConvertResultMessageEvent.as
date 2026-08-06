package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   public class NftEmeraldConvertResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function NftEmeraldConvertResultMessageEvent(param1:Function)
      {
         super(param1,NftEmeraldConvertResultMessageParser);
      }
      
      public function getParser() : NftEmeraldConvertResultMessageParser
      {
         return _parser as NftEmeraldConvertResultMessageParser;
      }
   }
}

