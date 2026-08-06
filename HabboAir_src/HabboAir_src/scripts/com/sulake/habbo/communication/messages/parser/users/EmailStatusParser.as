package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class EmailStatusParser implements IMessageParser
   {
      private var _email:String;
      
      private var _isVerified:Boolean;
      
      private var _allowChange:Boolean;
      
      public function EmailStatusParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _email = param1.readString();
         _isVerified = param1.readBoolean();
         _allowChange = param1.readBoolean();
         return true;
      }
      
      public function get email() : String
      {
         return _email;
      }
      
      public function get isVerified() : Boolean
      {
         return _isVerified;
      }
      
      public function get allowChange() : Boolean
      {
         return _allowChange;
      }
   }
}

