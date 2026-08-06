package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class FriendData
   {
      private var _id:int;
      
      private var _name:String;
      
      private var _gender:int;
      
      private var _online:Boolean;
      
      private var _followingAllowed:Boolean;
      
      private var _figure:String;
      
      private var _categoryId:int;
      
      private var _motto:String;
      
      private var _lastAccess:String;
      
      private var _realName:String;
      
      private var _facebookId:String;
      
      private var _persistedMessageUser:Boolean;
      
      private var _vipMember:Boolean;
      
      private var _pocketHabboUser:Boolean;
      
      private var _relationshipStatus:int;
      
      public function FriendData(param1:IMessageDataWrapper)
      {
         super();
         this._id = param1.readInteger();
         this._name = param1.readString();
         this._gender = param1.readInteger();
         this._online = param1.readBoolean();
         this._followingAllowed = param1.readBoolean();
         this._figure = param1.readString();
         this._categoryId = param1.readInteger();
         this._motto = param1.readString();
         this._realName = param1.readString();
         this._facebookId = param1.readString();
         this._persistedMessageUser = param1.readBoolean();
         this._vipMember = param1.readBoolean();
         this._pocketHabboUser = param1.readBoolean();
         this._relationshipStatus = param1.readShort();
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
      
      public function get facebookId() : String
      {
         return _facebookId;
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return _persistedMessageUser;
      }
      
      public function get vipMember() : Boolean
      {
         return _vipMember;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return _pocketHabboUser;
      }
      
      public function get relationshipStatus() : int
      {
         return _relationshipStatus;
      }
   }
}

