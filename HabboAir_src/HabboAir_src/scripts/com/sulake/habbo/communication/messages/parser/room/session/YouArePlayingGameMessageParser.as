package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YouArePlayingGameMessageParser implements IMessageParser
   {
      private var _isPlaying:Boolean = false;
      
      public function YouArePlayingGameMessageParser()
      {
         super();
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function flush() : Boolean
      {
         _isPlaying = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isPlaying = param1.readBoolean();
         return true;
      }
   }
}

