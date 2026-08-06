package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ClubGiftNotificationParser implements IMessageParser
   {
      private var _numGifts:int;
      
      public function ClubGiftNotificationParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _numGifts = param1.readInteger();
         return true;
      }
      
      public function get numGifts() : int
      {
         return _numGifts;
      }
   }
}

