package com.sulake.habbo.friendbar.data
{
   public class FriendEntity implements IFriendEntity
   {
      private static var ROLLING_LOG_EVENT_ID:int = 0;
      
      private var _id:int;
      
      private var _name:String;
      
      private var _gender:int;
      
      private var _online:Boolean;
      
      private var _allowFollow:Boolean;
      
      private var _figure:String;
      
      private var _categoryId:int;
      
      private var _motto:String;
      
      private var _lastAccess:String;
      
      private var _realName:String;
      
      private var _notifications:Vector.<IFriendNotification>;
      
      private var _logEventId:int = -1;
      
      public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
      {
         super();
         _id = param1;
         _name = param2;
         _realName = param3;
         _motto = param4;
         _gender = param5;
         _online = param6;
         _allowFollow = param7;
         _figure = param8;
         _categoryId = param9;
         _lastAccess = param10;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gender() : int
      {
         return _gender;
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function get allowFollow() : Boolean
      {
         return _allowFollow;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get motto() : String
      {
         return _motto;
      }
      
      public function get lastAccess() : String
      {
         return _lastAccess;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get logEventId() : int
      {
         return _logEventId;
      }
      
      public function get notifications() : Vector.<IFriendNotification>
      {
         if(!_notifications)
         {
            _notifications = new Vector.<IFriendNotification>();
         }
         return _notifications;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         _gender = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         _online = param1;
      }
      
      public function set allowFollow(param1:Boolean) : void
      {
         _allowFollow = param1;
      }
      
      public function set figure(param1:String) : void
      {
         _figure = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         _categoryId = param1;
      }
      
      public function set motto(param1:String) : void
      {
         _motto = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         _lastAccess = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set logEventId(param1:int) : void
      {
         _logEventId = param1;
      }
      
      public function getNextLogEventId() : int
      {
         return ++ROLLING_LOG_EVENT_ID;
      }
   }
}

