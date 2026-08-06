package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserNftWardrobeMessageEvent(param1:Function)
      {
         super(param1,UserNftWardrobeMessageParser);
      }
      
      public function getParser() : UserNftWardrobeMessageParser
      {
         return _parser as UserNftWardrobeMessageParser;
      }
   }
}

