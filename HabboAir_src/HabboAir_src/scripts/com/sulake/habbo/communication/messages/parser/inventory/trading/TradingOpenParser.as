package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradingOpenParser implements IMessageParser
   {
      private var _userID:int;
      
      private var _userCanTrade:Boolean;
      
      private var _otherUserID:int;
      
      private var _otherUserCanTrade:Boolean;
      
      public function TradingOpenParser()
      {
         super();
      }
      
      public function get userID() : int
      {
         return _userID;
      }
      
      public function get userCanTrade() : Boolean
      {
         return _userCanTrade;
      }
      
      public function get otherUserID() : int
      {
         return _otherUserID;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return _otherUserCanTrade;
      }
      
      public function flush() : Boolean
      {
         _userID = -1;
         _userCanTrade = false;
         _otherUserID = -1;
         _otherUserCanTrade = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userID = param1.readInteger();
         _userCanTrade = param1.readInteger() == 1;
         _otherUserID = param1.readInteger();
         _otherUserCanTrade = param1.readInteger() == 1;
         return true;
      }
   }
}

