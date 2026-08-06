package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class OpenChestMessageParser implements IMessageParser
   {
      private var _chestId:int;
      
      public function OpenChestMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chestId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chestId = param1.readInteger();
         return true;
      }
      
      public function get chestId() : int
      {
         return _chestId;
      }
   }
}

