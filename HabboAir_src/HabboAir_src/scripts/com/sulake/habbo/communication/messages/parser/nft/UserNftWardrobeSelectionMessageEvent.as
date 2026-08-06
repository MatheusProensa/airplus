package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeSelectionMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function UserNftWardrobeSelectionMessageEvent(param1:Function)
      {
         super(param1,UserNftWardrobeSelectionMessageParser);
      }
      
      public function getParser() : UserNftWardrobeSelectionMessageParser
      {
         return _parser as UserNftWardrobeSelectionMessageParser;
      }
   }
}

