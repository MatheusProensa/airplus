package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpResultMessageParser implements IMessageParser
   {
      private var _resultType:int;
      
      private var _messageText:String;
      
      public function CallForHelpResultMessageParser()
      {
         super();
      }
      
      public function get resultType() : int
      {
         return _resultType;
      }
      
      public function get messageText() : String
      {
         return _messageText;
      }
      
      public function flush() : Boolean
      {
         _resultType = -1;
         _messageText = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultType = param1.readInteger();
         _messageText = param1.readString();
         return true;
      }
   }
}

