package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class ChatItem
   {
      private var _timeStamp:int = 0;
      
      private var _userId:int = 0;
      
      private var _roomId:int = 0;
      
      private var _text:String = "";
      
      private var _chatType:int = 0;
      
      private var _links:Array;
      
      private var _style:int;
      
      private var _userLocation:IVector3d;
      
      private var _forcedColor:*;
      
      private var _forcedScreenLocation:*;
      
      private var _forcedFigure:String;
      
      private var _forcedUserName:String;
      
      private var _extraParam:int;
      
      public function ChatItem(param1:RoomSessionChatEvent, param2:int, param3:IVector3d = null, param4:int = 0, param5:* = null, param6:* = null, param7:String = null, param8:String = null)
      {
         super();
         _timeStamp = param2;
         _userLocation = param3 != null ? new Vector3d(param3.x,param3.y,param3.z) : null;
         _userId = param1.userId;
         if(param1.session)
         {
            _roomId = param1.session.roomId;
         }
         else
         {
            _roomId = 1;
         }
         _text = param1.text;
         _chatType = param1.chatType;
         _style = param1.style;
         _links = new Array(param1.links);
         _forcedColor = param6;
         _forcedScreenLocation = param5;
         _forcedFigure = param7;
         _forcedUserName = param8;
         _extraParam = param4;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get roomId() : int
      {
         return _roomId;
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
      
      public function get style() : int
      {
         return _style;
      }
      
      public function get timeStamp() : uint
      {
         return _timeStamp;
      }
      
      public function get userLocation() : IVector3d
      {
         return _userLocation;
      }
      
      public function get forcedColor() : *
      {
         return _forcedColor;
      }
      
      public function get forcedScreenLocation() : *
      {
         return _forcedScreenLocation;
      }
      
      public function get forcedFigure() : String
      {
         return _forcedFigure;
      }
      
      public function get forcedUserName() : String
      {
         return _forcedUserName;
      }
      
      public function get extraParam() : int
      {
         return _extraParam;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function set style(param1:int) : void
      {
         _style = param1;
      }
   }
}

