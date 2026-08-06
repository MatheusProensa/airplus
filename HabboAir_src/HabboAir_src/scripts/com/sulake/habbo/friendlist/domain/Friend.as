package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.friendlist.UnknownIHabboFriendlist1;
   import flash.display.BitmapData;
   
   public class Friend implements UnknownIHabboFriendlist1, IComponentInterfaceQueue
   {
      public static const GENDER_FEMALE:int = "F".charCodeAt(0);
      
      public static const GENDER_MALE:int = "M".charCodeAt(0);
      
      private var _id:int;
      
      private var _name:String;
      
      private var _gender:int;
      
      private var _online:Boolean;
      
      private var _followingAllowed:Boolean;
      
      private var _figure:String;
      
      private var _motto:String;
      
      private var _lastAccess:String;
      
      private var _categoryId:int;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      private var _view:IWindowController_1;
      
      private var _face:BitmapData;
      
      private var _realName:String;
      
      private var _persistedMessageUser:Boolean;
      
      private var _pocketHabboUser:Boolean;
      
      private var _vipMember:Boolean;
      
      private var _relationshipStatus:int;
      
      public function Friend(param1:FriendData)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         _id = param1.id;
         _name = param1.name;
         _gender = param1.gender;
         _online = param1.online;
         _followingAllowed = param1.followingAllowed && param1.online;
         _figure = param1.figure;
         _motto = param1.motto;
         _lastAccess = param1.lastAccess;
         _categoryId = 0;
         _realName = param1.realName;
         _persistedMessageUser = param1.persistedMessageUser;
         _vipMember = param1.vipMember;
         _pocketHabboUser = param1.pocketHabboUser;
         _relationshipStatus = param1.relationshipStatus;
         Logger.log("Creating friend: " + id + ", " + name + ", " + gender + ", " + online + ", " + followingAllowed + ", " + figure + ", " + categoryId);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_face != null)
         {
            _face.dispose();
            _face = null;
         }
         _disposed = true;
         _view = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
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
      
      public function get followingAllowed() : Boolean
      {
         return _followingAllowed;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get motto() : String
      {
         return _motto;
      }
      
      public function get lastAccess() : String
      {
         return _lastAccess;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function get face() : BitmapData
      {
         return _face;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return _persistedMessageUser;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return _pocketHabboUser;
      }
      
      public function get relationshipStatus() : int
      {
         return _relationshipStatus;
      }
      
      public function get vipMember() : Boolean
      {
         return _vipMember;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
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
      
      public function set followingAllowed(param1:Boolean) : void
      {
         _followingAllowed = param1;
      }
      
      public function set figure(param1:String) : void
      {
         _figure = param1;
      }
      
      public function set motto(param1:String) : void
      {
         _motto = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         _lastAccess = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         _categoryId = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         _view = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         _face = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set persistedMessageUser(param1:Boolean) : void
      {
         _persistedMessageUser = param1;
      }
      
      public function set pocketHabboUser(param1:Boolean) : void
      {
         _pocketHabboUser = param1;
      }
      
      public function set vipMember(param1:Boolean) : void
      {
         _vipMember = param1;
      }
      
      public function isGroupFriend() : Boolean
      {
         return _id < 0;
      }
   }
}

