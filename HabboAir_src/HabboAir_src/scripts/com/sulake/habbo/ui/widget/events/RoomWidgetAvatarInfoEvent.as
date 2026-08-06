package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetAvatarInfoEvent extends RoomWidgetUpdateEvent
   {
      public static const AVATAR_INFO:String = "RWAIE_AVATAR_INFO";
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _userType:int;
      
      private var _allowNameChange:Boolean;
      
      private var _roomIndex:int;
      
      public function RoomWidgetAvatarInfoEvent(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWAIE_AVATAR_INFO",param6,param7);
         _userId = param1;
         _userName = param2;
         _userType = param3;
         _roomIndex = param4;
         _allowNameChange = param5;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userType() : int
      {
         return _userType;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get allowNameChange() : Boolean
      {
         return _allowNameChange;
      }
   }
}

