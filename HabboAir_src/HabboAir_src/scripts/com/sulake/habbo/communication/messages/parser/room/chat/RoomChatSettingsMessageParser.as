package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
   
   [SecureSWF(rename="true")]
   public class RoomChatSettingsMessageParser implements IMessageParser
   {
      private var _chatSettings:RoomChatSettings;
      
      public function RoomChatSettingsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chatSettings = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _chatSettings = RoomChatSettings.fromFloodSensitivity(param1.readInteger());
         return true;
      }
      
      public function get chatSettings() : RoomChatSettings
      {
         return _chatSettings;
      }
   }
}

