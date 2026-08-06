package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BlockUserUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class BlockUserUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromBlockUserUpdateMessageEvent_Int_1:int = 0;
      
      public static const UnknownConstFromBlockUserUpdateMessageEvent_Int_2:int = 1;
      
      public function BlockUserUpdateMessageEvent(param1:Function)
      {
         super(param1,BlockUserUpdateMessageParser);
      }
      
      public function get result() : int
      {
         return (_parser as BlockUserUpdateMessageParser).result;
      }
      
      public function get userId() : int
      {
         return (_parser as BlockUserUpdateMessageParser).userId;
      }
   }
}

