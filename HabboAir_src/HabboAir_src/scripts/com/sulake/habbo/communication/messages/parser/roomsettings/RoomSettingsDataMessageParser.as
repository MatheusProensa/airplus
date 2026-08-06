package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
   
   [SecureSWF(rename="true")]
   public class RoomSettingsDataMessageParser implements IMessageParser
   {
      private var _data:RoomSettingsData;
      
      public function RoomSettingsDataMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _data = new RoomSettingsData();
         _data.roomId = param1.readInteger();
         _data.name = param1.readString();
         _data.description = param1.readString();
         _data.doorMode = param1.readInteger();
         _data.categoryId = param1.readInteger();
         _data.maximumVisitors = param1.readInteger();
         _data.maximumVisitorsLimit = param1.readInteger();
         _data.tags = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _data.tags.push(param1.readString());
            _loc3_++;
         }
         _data.tradeMode = param1.readInteger();
         _data.allowPets = param1.readInteger() == 1;
         _data.allowFoodConsume = param1.readInteger() == 1;
         _data.allowWalkThrough = param1.readInteger() == 1;
         _data.hideWalls = param1.readInteger() == 1;
         _data.wallThickness = param1.readInteger();
         _data.floorThickness = param1.readInteger();
         _data.chatSettings = RoomChatSettings.fromFloodSensitivity(param1.readInteger());
         _data.leaveOnDoorTileEnabled = param1.readBoolean();
         _data.idleSleepEnabled = param1.readBoolean();
         _data.idleSleepTimeoutSeconds = param1.readInteger();
         _data.idleAutokickEnabled = param1.readBoolean();
         _data.idleAutokickTimeoutSeconds = param1.readInteger();
         _data.muteAllPets = param1.readBoolean();
         _data.roomModerationSettings = new RoomModerationSettings(param1);
         _data.hiddenByBc = param1.readBoolean();
         return true;
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function get data() : RoomSettingsData
      {
         return _data;
      }
   }
}

