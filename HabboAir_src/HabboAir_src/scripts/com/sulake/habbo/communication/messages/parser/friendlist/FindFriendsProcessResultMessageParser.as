package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FindFriendsProcessResultMessageParser implements IMessageParser
   {
      private var _success:Boolean;
      
      public function FindFriendsProcessResultMessageParser()
      {
         super();
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _success = param1.readBoolean();
         return true;
      }
   }
}

