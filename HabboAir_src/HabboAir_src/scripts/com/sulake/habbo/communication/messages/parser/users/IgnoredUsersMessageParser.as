package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IgnoredUsersMessageParser implements IMessageParser
   {
      protected var UnknownVarFromIgnoredUsersMessageParser_Array_1:Array = null;
      
      public function IgnoredUsersMessageParser()
      {
         super();
         UnknownVarFromIgnoredUsersMessageParser_Array_1 = [];
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         UnknownVarFromIgnoredUsersMessageParser_Array_1 = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            UnknownVarFromIgnoredUsersMessageParser_Array_1.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get ignoredUsers() : Array
      {
         return UnknownVarFromIgnoredUsersMessageParser_Array_1.slice();
      }
   }
}

