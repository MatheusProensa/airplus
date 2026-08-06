package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MiniMailUnreadCountMessageParser implements IMessageParser
   {
      private var _unreadMessageCount:int;
      
      public function MiniMailUnreadCountMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _unreadMessageCount = param1.readInteger();
         return true;
      }
      
      public function get unreadMessageCount() : int
      {
         return _unreadMessageCount;
      }
   }
}

