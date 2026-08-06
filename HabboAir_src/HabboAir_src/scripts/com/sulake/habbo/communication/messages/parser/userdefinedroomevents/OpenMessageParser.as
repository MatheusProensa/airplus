package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OpenMessageParser implements IMessageParser
   {
      private var _stuffId:int;
      
      public function OpenMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
   }
}

