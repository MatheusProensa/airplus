package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UnreadForumsCountMessageParser implements IMessageParser
   {
      private var _unreadForumsCount:int;
      
      public function UnreadForumsCountMessageParser()
      {
         super();
      }
      
      public function get unreadForumsCount() : int
      {
         return _unreadForumsCount;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _unreadForumsCount = param1.readInteger();
         return true;
      }
   }
}

