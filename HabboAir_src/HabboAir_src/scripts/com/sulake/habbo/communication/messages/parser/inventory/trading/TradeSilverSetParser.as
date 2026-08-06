package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverSetParser implements IMessageParser
   {
      private var _playerSilver:int;
      
      private var _otherPlayerSilver:int;
      
      public function TradeSilverSetParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _playerSilver = -1;
         _otherPlayerSilver = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _playerSilver = param1.readInteger();
         _otherPlayerSilver = param1.readInteger();
         return true;
      }
      
      public function get playerSilver() : int
      {
         return _playerSilver;
      }
      
      public function get otherPlayerSilver() : int
      {
         return _otherPlayerSilver;
      }
   }
}

