package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserRightsMessageParser implements IMessageParser
   {
      private var _clubLevel:int;
      
      private var _securityLevel:int;
      
      private var _isAmbassador:Boolean;
      
      public function UserRightsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _clubLevel = param1.readInteger();
         _securityLevel = param1.readInteger();
         _isAmbassador = param1.readBoolean();
         return true;
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
      
      public function get securityLevel() : int
      {
         return _securityLevel;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
   }
}

