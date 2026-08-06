package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
   
   [SecureSWF(rename="true")]
   public class ModeratorRoomInfoMessageParser implements IMessageParser
   {
      private var _data:RoomModerationData;
      
      public function ModeratorRoomInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new RoomModerationData(param1);
         return true;
      }
      
      public function get data() : RoomModerationData
      {
         return _data;
      }
   }
}

