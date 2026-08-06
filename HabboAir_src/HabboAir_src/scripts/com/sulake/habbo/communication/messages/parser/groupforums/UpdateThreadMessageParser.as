package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateThreadMessageParser implements IMessageParser
   {
      private var _groupId:int;
      
      private var _thread:ThreadData;
      
      public function UpdateThreadMessageParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get thread() : ThreadData
      {
         return _thread;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         _thread = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         _thread = ThreadData.readFromMessage(param1);
         return true;
      }
   }
}

