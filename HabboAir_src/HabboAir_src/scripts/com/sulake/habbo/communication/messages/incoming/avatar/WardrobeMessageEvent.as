package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.avatar.WardrobeMessageParser;
   
   [SecureSWF(rename="true")]
   public class WardrobeMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromWardrobeMessageEvent_Int_1:int = 0;
      
      public static const UnknownConstFromWardrobeMessageEvent_Int_2:int = 1;
      
      public function WardrobeMessageEvent(param1:Function)
      {
         super(param1,WardrobeMessageParser);
      }
      
      private function getParser() : WardrobeMessageParser
      {
         return this._parser as WardrobeMessageParser;
      }
      
      public function get outfits() : Array
      {
         return getParser().outfits;
      }
      
      public function get state() : int
      {
         return getParser().state;
      }
   }
}

