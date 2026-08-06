package com.sulake.habbo.communication.messages.parser.perk
{
   [SecureSWF(rename="true")]
   public class Perk
   {
      private var _code:String;
      
      private var _isAllowed:Boolean = false;
      
      private var _errorMessage:String = "";
      
      public function Perk()
      {
         super();
      }
      
      public function get code() : String
      {
         return _code;
      }
      
      public function set code(param1:String) : void
      {
         _code = param1;
      }
      
      public function get isAllowed() : Boolean
      {
         return _isAllowed;
      }
      
      public function set isAllowed(param1:Boolean) : void
      {
         _isAllowed = param1;
      }
      
      public function get errorMessage() : String
      {
         return _errorMessage;
      }
      
      public function set errorMessage(param1:String) : void
      {
         _errorMessage = param1;
      }
   }
}

