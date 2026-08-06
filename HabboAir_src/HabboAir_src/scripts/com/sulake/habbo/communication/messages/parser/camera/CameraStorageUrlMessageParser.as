package com.sulake.habbo.communication.messages.parser.camera
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraStorageUrlMessageParser implements IMessageParser
   {
      private var _url:String;
      
      public function CameraStorageUrlMessageParser()
      {
         super();
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function flush() : Boolean
      {
         _url = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _url = param1.readString();
         return true;
      }
   }
}

