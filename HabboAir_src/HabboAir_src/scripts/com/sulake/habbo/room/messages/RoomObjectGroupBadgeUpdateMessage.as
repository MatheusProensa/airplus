package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectGroupBadgeUpdateMessage extends RoomObjectUpdateMessage
   {
      public static const BADGE_LOADED:String = "ROGBUM_BADGE_LOADED";
      
      private var _badgeId:String;
      
      private var _assetName:String;
      
      public function RoomObjectGroupBadgeUpdateMessage(param1:String, param2:String)
      {
         super(null,null);
         _badgeId = param1;
         _assetName = param2;
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
   }
}

