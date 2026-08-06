package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CompetitionStatusMessageParser implements IMessageParser
   {
      private var _isOk:Boolean = false;
      
      private var _errorReason:String = null;
      
      public function CompetitionStatusMessageParser()
      {
         super();
      }
      
      public function isOk() : Boolean
      {
         return _isOk;
      }
      
      public function getErrorReason() : String
      {
         return _errorReason;
      }
      
      public function flush() : Boolean
      {
         _isOk = false;
         _errorReason = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOk = param1.readBoolean();
         _errorReason = param1.readString();
         return true;
      }
   }
}

