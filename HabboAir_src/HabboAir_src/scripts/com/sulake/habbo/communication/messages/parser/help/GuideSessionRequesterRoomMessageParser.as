package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionRequesterRoomMessageParser implements IMessageParser
   {
      private var _requesterRoomId:int;
      
      public function GuideSessionRequesterRoomMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requesterRoomId = param1.readInteger();
         return true;
      }
      
      public function getRequesterRoomId() : int
      {
         return _requesterRoomId;
      }
   }
}

