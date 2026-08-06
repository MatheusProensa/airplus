package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionMessageMessageParser implements IMessageParser
   {
      private var _chatMessage:String;
      
      private var _senderId:int;
      
      public function GuideSessionMessageMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chatMessage = param1.readString();
         _senderId = param1.readInteger();
         return true;
      }
      
      public function get chatMessage() : String
      {
         return _chatMessage;
      }
      
      public function get senderId() : int
      {
         return _senderId;
      }
   }
}

