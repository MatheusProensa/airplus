package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OpenConnectionMessageParser implements IMessageParser
   {
      private var _flatId:int = 0;
      
      public function OpenConnectionMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
   }
}

