package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
   
   [SecureSWF(rename="true")]
   public class GetGuestRoomResultMessageParser implements IMessageParser, IComponentInterfaceQueue
   {
      private var _enterRoom:Boolean;
      
      private var _roomForward:Boolean;
      
      private var _staffPick:Boolean;
      
      private var _data:GuestRoomData;
      
      private var _isGroupMember:Boolean;
      
      private var _roomModerationSettings:RoomModerationSettings;
      
      private var _chatSettings:RoomChatSettings;
      
      private var _openingConnection:Boolean;
      
      public function GetGuestRoomResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._enterRoom = param1.readBoolean();
         this._data = new GuestRoomData(param1);
         this._roomForward = param1.readBoolean();
         this._staffPick = param1.readBoolean();
         this._isGroupMember = param1.readBoolean();
         var _loc2_:Boolean = param1.readBoolean();
         this._roomModerationSettings = new RoomModerationSettings(param1);
         this._data.allInRoomMuted = _loc2_;
         this._data.canMute = param1.readBoolean();
         this._chatSettings = RoomChatSettings.fromFloodSensitivity(param1.readInteger());
         this._openingConnection = param1.readBoolean();
         return true;
      }
      
      public function dispose() : void
      {
         _roomModerationSettings = null;
      }
      
      public function get disposed() : Boolean
      {
         return _roomModerationSettings == null;
      }
      
      public function get enterRoom() : Boolean
      {
         return _enterRoom;
      }
      
      public function get data() : GuestRoomData
      {
         return _data;
      }
      
      public function get roomForward() : Boolean
      {
         return _roomForward;
      }
      
      public function get staffPick() : Boolean
      {
         return _staffPick;
      }
      
      public function get isGroupMember() : Boolean
      {
         return _isGroupMember;
      }
      
      public function get roomModerationSettings() : RoomModerationSettings
      {
         return _roomModerationSettings;
      }
      
      public function get openingConnection() : Boolean
      {
         return _openingConnection;
      }
      
      public function get chatSettings() : RoomChatSettings
      {
         return _chatSettings;
      }
   }
}

