package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AuthenticationOKMessageParser implements IMessageParser
   {
      private var _accountId:int;
      
      private var _suggestedLoginActions:Array;
      
      private var _identityId:int;
      
      public function AuthenticationOKMessageParser()
      {
         super();
         _suggestedLoginActions = [];
      }
      
      public function flush() : Boolean
      {
         _accountId = -1;
         _suggestedLoginActions = [];
         _identityId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _accountId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _suggestedLoginActions.push(param1.readShort());
            _loc3_++;
         }
         _identityId = param1.readInteger();
         return true;
      }
      
      public function get accountId() : int
      {
         return _accountId;
      }
      
      public function get suggestedLoginActions() : Array
      {
         return _suggestedLoginActions;
      }
      
      public function get identityId() : int
      {
         return _identityId;
      }
   }
}

