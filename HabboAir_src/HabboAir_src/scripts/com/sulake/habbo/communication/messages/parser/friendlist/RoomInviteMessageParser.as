package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomInviteMessageParser implements IMessageParser
   {
      private var UnknownVarFromRoomInviteMessageParser_Int_1:int;
      
      private var UnknownVarFromRoomInviteMessageParser_String_1:String;
      
      public function RoomInviteMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.UnknownVarFromRoomInviteMessageParser_Int_1 = param1.readInteger();
         this.UnknownVarFromRoomInviteMessageParser_String_1 = param1.readString();
         return true;
      }
      
      public function get senderId() : int
      {
         return this.UnknownVarFromRoomInviteMessageParser_Int_1;
      }
      
      public function get messageText() : String
      {
         return this.UnknownVarFromRoomInviteMessageParser_String_1;
      }
   }
}

