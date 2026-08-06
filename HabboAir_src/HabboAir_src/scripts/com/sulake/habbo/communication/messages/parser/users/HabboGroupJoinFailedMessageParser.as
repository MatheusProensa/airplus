package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboGroupJoinFailedMessageParser implements IMessageParser
   {
      public static const UnknownConstFromHabboGroupJoinFailedMessageParser_Int_1:int = 4;
      
      private var _reason:int;
      
      public function HabboGroupJoinFailedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _reason = param1.readInteger();
         return true;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
   }
}

