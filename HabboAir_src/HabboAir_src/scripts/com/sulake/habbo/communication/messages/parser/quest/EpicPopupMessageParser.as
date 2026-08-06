package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class EpicPopupMessageParser implements IMessageParser
   {
      private var _imageUri:String;
      
      public function EpicPopupMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _imageUri = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _imageUri = param1.readString();
         return true;
      }
      
      public function get imageUri() : String
      {
         return _imageUri;
      }
   }
}

