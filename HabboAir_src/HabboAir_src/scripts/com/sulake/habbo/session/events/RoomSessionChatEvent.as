package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionChatEvent extends RoomSessionEvent
   {
      public static const ROOM_SESSION_CHAT_EVENT:String = "RSCE_CHAT_EVENT";
      
      public static const ROOM_SESSION_FLOODCONTROL_EVENT:String = "RSCE_FLOOD_EVENT";
      
      public static const CHAT_TYPE_SPEAK:int = 0;
      
      public static const CHAT_TYPE_WHISPER:int = 1;
      
      public static const CHAT_TYPE_SHOUT:int = 2;
      
      public static const CHAT_TYPE_RESPECT:int = 3;
      
      public static const CHAT_TYPE_PETRESPECT:int = 4;
      
      public static const CHAT_TYPE_HAND_ITEM_RECEIVED:int = 5;
      
      public static const CHAT_TYPE_PETTREAT:int = 6;
      
      public static const CHAT_TYPE_PETREVIVE:int = 7;
      
      public static const CHAT_TYPE_PET_REBREED_FERTILIZE:int = 8;
      
      public static const CHAT_TYPE_PET_SPEED_FERTILIZE:int = 9;
      
      public static const CHAT_TYPE_MUTE_REMAINING:int = 10;
      
      public static const CHAT_TYPE_PING:int = 11;
      
      public static const CHAT_TYPE_SPECIAL_SYSTEM:int = 12;
      
      private var _userId:int = 0;
      
      private var _text:String = "";
      
      private var _chatType:int = 0;
      
      private var _links:Array;
      
      private var _extraParam:int;
      
      private var _style:int;
      
      public function RoomSessionChatEvent(param1:String, param2:IRoomSession, param3:int, param4:String, param5:int = 0, param6:int = 0, param7:Array = null, param8:int = -1)
      {
         super(param1,param2,false,false);
         _userId = param3;
         _text = param4;
         _chatType = param5;
         _links = param7;
         _extraParam = param8;
         _style = param6;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get chatType() : int
      {
         return _chatType;
      }
      
      public function get links() : Array
      {
         return _links;
      }
      
      public function get extraParam() : int
      {
         return _extraParam;
      }
      
      public function get style() : int
      {
         return _style;
      }
   }
}

