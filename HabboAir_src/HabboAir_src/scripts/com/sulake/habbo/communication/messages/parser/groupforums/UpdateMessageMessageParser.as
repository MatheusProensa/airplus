package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateMessageMessageParser implements IMessageParser
   {
      private var _groupId:int;
      
      private var _threadId:int;
      
      private var _message:MessageData;
      
      public function UpdateMessageMessageParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function get message() : MessageData
      {
         return _message;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         _threadId = -1;
         _message = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         _threadId = param1.readInteger();
         _message = MessageData.readFromMessage(param1);
         return true;
      }
   }
}

