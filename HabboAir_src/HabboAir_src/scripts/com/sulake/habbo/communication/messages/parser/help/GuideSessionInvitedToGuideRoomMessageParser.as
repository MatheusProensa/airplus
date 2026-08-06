package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionInvitedToGuideRoomMessageParser implements IMessageParser
   {
      private var _roomId:int = 0;
      
      private var _roomName:String = "";
      
      public function GuideSessionInvitedToGuideRoomMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         return true;
      }
      
      public function getRoomId() : int
      {
         return _roomId;
      }
      
      public function getRoomName() : String
      {
         return _roomName;
      }
   }
}

