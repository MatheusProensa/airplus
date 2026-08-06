package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboBroadcastMessageParser implements IMessageParser
   {
      private var _messageText:String = "";
      
      public function HabboBroadcastMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _messageText = param1.readString();
         return true;
      }
      
      public function get messageText() : String
      {
         return _messageText;
      }
   }
}

