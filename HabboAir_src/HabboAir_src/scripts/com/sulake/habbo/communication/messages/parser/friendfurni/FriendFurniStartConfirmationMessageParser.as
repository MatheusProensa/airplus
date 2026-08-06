package com.sulake.habbo.communication.messages.parser.friendfurni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniStartConfirmationMessageParser implements IMessageParser
   {
      private var _stuffId:int;
      
      private var _isOwner:Boolean;
      
      public function FriendFurniStartConfirmationMessageParser()
      {
         super();
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get isOwner() : Boolean
      {
         return _isOwner;
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         _isOwner = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         _isOwner = param1.readBoolean();
         return true;
      }
   }
}

