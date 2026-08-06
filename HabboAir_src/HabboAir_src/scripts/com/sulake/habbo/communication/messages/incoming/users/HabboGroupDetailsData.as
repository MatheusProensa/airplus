package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HabboGroupDetailsData
   {
      public static const TYPE_REGULAR:int = 0;
      
      public static const TYPE_EXCLUSIVE:int = 1;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_1:int = 2;
      
      public static const TYPE_LARGE:int = 3;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_2:int = 4;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_3:int = 0;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_4:int = 1;
      
      public static const UnknownConstFromHabboGroupDetailsData_Int_5:int = 2;
      
      private var _groupId:int;
      
      private var _isGuild:Boolean;
      
      private var _type:int;
      
      private var _groupName:String;
      
      private var _description:String;
      
      private var _badgeCode:String;
      
      private var _roomId:int = -1;
      
      private var _roomName:String = "";
      
      private var _status:int;
      
      private var _totalMembers:int;
      
      private var _favourite:Boolean;
      
      private var _creationDate:String;
      
      private var _isOwner:Boolean;
      
      private var _isAdmin:Boolean;
      
      private var _ownerName:String;
      
      private var _openDetails:Boolean;
      
      private var _hasBoard:Boolean;
      
      private var _membersCanDecorate:Boolean;
      
      private var _pendingMemberCount:int;
      
      public function HabboGroupDetailsData(param1:IMessageDataWrapper)
      {
         super();
         _groupId = param1.readInteger();
         _isGuild = param1.readBoolean();
         _type = param1.readInteger();
         _groupName = param1.readString();
         _description = param1.readString();
         _badgeCode = param1.readString();
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         _status = param1.readInteger();
         _totalMembers = param1.readInteger();
         _favourite = param1.readBoolean();
         _creationDate = param1.readString();
         _isOwner = param1.readBoolean();
         _isAdmin = param1.readBoolean();
         _ownerName = param1.readString();
         _openDetails = param1.readBoolean();
         _membersCanDecorate = param1.readBoolean();
         _pendingMemberCount = param1.readInteger();
         _hasBoard = param1.readBoolean();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get isGuild() : Boolean
      {
         return _isGuild;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get totalMembers() : int
      {
         return _totalMembers;
      }
      
      public function get favourite() : Boolean
      {
         return _favourite;
      }
      
      public function get creationDate() : String
      {
         return _creationDate;
      }
      
      public function get isOwner() : Boolean
      {
         return _isOwner;
      }
      
      public function get isAdmin() : Boolean
      {
         return _isAdmin;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get openDetails() : Boolean
      {
         return _openDetails;
      }
      
      public function get membersCanDecorate() : Boolean
      {
         return _membersCanDecorate;
      }
      
      public function get pendingMemberCount() : int
      {
         return _pendingMemberCount;
      }
      
      public function get hasBoard() : Boolean
      {
         return _hasBoard;
      }
      
      public function get joiningAllowed() : Boolean
      {
         return _status == 0 && (_type == 0 || _type == 4);
      }
      
      public function get requestMembershipAllowed() : Boolean
      {
         return _status == 0 && _type == 1;
      }
      
      public function get leaveAllowed() : Boolean
      {
         return _isGuild && !_isOwner && _status == 1;
      }
   }
}

