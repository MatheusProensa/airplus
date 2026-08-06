package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CheckUserNameResultMessageParser implements IMessageParser
   {
      private var _resultCode:int = -1;
      
      private var _name:String;
      
      private var _nameSuggestions:Array;
      
      public function CheckUserNameResultMessageParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get nameSuggestions() : Array
      {
         return _nameSuggestions;
      }
      
      public function flush() : Boolean
      {
         _resultCode = -1;
         _name = "";
         _nameSuggestions = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _resultCode = param1.readInteger();
         _name = param1.readString();
         var _loc2_:int = param1.readInteger();
         _nameSuggestions = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _nameSuggestions.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
   }
}

