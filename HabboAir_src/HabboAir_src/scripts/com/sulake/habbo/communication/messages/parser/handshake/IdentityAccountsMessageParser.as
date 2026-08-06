package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class IdentityAccountsMessageParser implements IMessageParser
   {
      private var _accounts:Dictionary;
      
      public function IdentityAccountsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_accounts)
         {
            _accounts = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _accounts = new Dictionary();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _accounts[param1.readInteger()] = param1.readString();
            _loc3_++;
         }
         return true;
      }
      
      public function get accounts() : Dictionary
      {
         return _accounts;
      }
   }
}

