package com.sulake.habbo.communication.messages.parser.chatstyles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserPurchasableChatStyleChangedMessageParser implements IMessageParser
   {
      private var _added:Boolean;
      
      private var _styleId:int;
      
      public function UserPurchasableChatStyleChangedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _added = false;
         _styleId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _added = param1.readBoolean();
         _styleId = param1.readInteger();
         return true;
      }
      
      public function get added() : Boolean
      {
         return _added;
      }
      
      public function get styleId() : int
      {
         return _styleId;
      }
   }
}

