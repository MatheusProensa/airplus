package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendFailureData;
   
   [SecureSWF(rename="true")]
   public class AcceptFriendResultMessageParser implements IMessageParser
   {
      private var UnknownVarFromAcceptFriendResultMessageParser_Array_1:Array;
      
      public function AcceptFriendResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.UnknownVarFromAcceptFriendResultMessageParser_Array_1 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.UnknownVarFromAcceptFriendResultMessageParser_Array_1.push(new AcceptFriendFailureData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get failures() : Array
      {
         return this.UnknownVarFromAcceptFriendResultMessageParser_Array_1;
      }
   }
}

