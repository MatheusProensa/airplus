package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorMessageParser implements IMessageParser
   {
      private var _message:String;
      
      private var _url:String;
      
      public function ModeratorMessageParser()
      {
         super();
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function ModerationCautionParser() : *
      {
      }
      
      public function flush() : Boolean
      {
         _message = "";
         _url = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _message = param1.readString();
         _url = param1.readString();
         return true;
      }
   }
}

