package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserHabbiconStatusChangedMessageParser implements IMessageParser
   {
      private var _habbiconId:int;
      
      private var _habbiconState:int;
      
      public function UserHabbiconStatusChangedMessageParser()
      {
         super();
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
      
      public function get habbiconState() : int
      {
         return _habbiconState;
      }
      
      public function flush() : Boolean
      {
         _habbiconId = 0;
         _habbiconState = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _habbiconId = param1.readInteger();
         _habbiconState = param1.readInteger();
         return true;
      }
   }
}

