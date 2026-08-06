package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BanInfoMessageParser implements IMessageParser
   {
      private var _target:int;
      
      private var _reason:String;
      
      private var _banExpirySeconds:int;
      
      private var _localizedReason:String;
      
      public function BanInfoMessageParser()
      {
         super();
      }
      
      public function get target() : int
      {
         return _target;
      }
      
      public function get reason() : String
      {
         return _reason;
      }
      
      public function get banExpirySeconds() : Number
      {
         return _banExpirySeconds;
      }
      
      public function get localizedReason() : String
      {
         return _localizedReason;
      }
      
      public function flush() : Boolean
      {
         _target = -1;
         _reason = "";
         _banExpirySeconds = -1;
         _localizedReason = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _target = param1.readShort();
         _reason = param1.readString();
         _banExpirySeconds = param1.readInteger();
         _localizedReason = param1.readString();
         return true;
      }
   }
}

