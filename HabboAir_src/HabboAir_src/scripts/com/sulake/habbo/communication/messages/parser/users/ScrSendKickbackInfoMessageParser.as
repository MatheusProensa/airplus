package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
   
   [SecureSWF(rename="true")]
   public class ScrSendKickbackInfoMessageParser implements IMessageParser
   {
      private var _data:ScrKickbackData;
      
      public function ScrSendKickbackInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new ScrKickbackData(param1);
         return true;
      }
      
      public function get data() : ScrKickbackData
      {
         return _data;
      }
   }
}

