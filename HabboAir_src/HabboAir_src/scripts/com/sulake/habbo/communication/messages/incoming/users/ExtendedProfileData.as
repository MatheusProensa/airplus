package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileData
   {
      public static const UnknownConstFromExtendedProfileData_Int_1:int = 0;
      
      public static const UnknownConstFromExtendedProfileData_Int_2:int = 1;
      
      public static const UnknownConstFromExtendedProfileData_Int_3:int = 2;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _figure:String;
      
      private var _motto:String;
      
      private var _creationDate:String;
      
      private var _achievementScore:int;
      
      private var _friendCount:int;
      
      private var _isFriend:Boolean;
      
      private var _isFriendRequestSent:Boolean;
      
      private var _onlineStatus:int;
      
      private var _guilds:Array;
      
      private var _lastAccessSinceInSeconds:int;
      
      private var _openProfileWindow:Boolean;
      
      private var _isHidden:Boolean;
      
      private var _accountLevel:int;
      
      private var UnknownVarFromExtendedProfileData_Int_1:int;
      
      private var _starGemCount:int;
      
      private var UnknownVarFromExtendedProfileData_Boolean_1:Boolean;
      
      private var UnknownVarFromExtendedProfileData_Boolean_2:Boolean;
      
      private var _totalBadges:int;
      
      private var _achievementLevel:int;
      
      private var _badgeRarityCounts:Array;
      
      private var _totalBadgesRank:int = -1;
      
      public function ExtendedProfileData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _guilds = [];
         _badgeRarityCounts = [];
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _figure = param1.readString();
         _motto = param1.readString();
         _creationDate = param1.readString();
         _achievementScore = param1.readInteger();
         _friendCount = param1.readInteger();
         _isFriend = param1.readBoolean();
         _isFriendRequestSent = param1.readBoolean();
         _onlineStatus = param1.readByte();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _guilds.push(new HabboGroupEntryData(param1));
            _loc3_++;
         }
         _lastAccessSinceInSeconds = param1.readInteger();
         _openProfileWindow = param1.readBoolean();
         _isHidden = param1.readBoolean();
         _accountLevel = param1.readInteger();
         UnknownVarFromExtendedProfileData_Int_1 = param1.readInteger();
         _starGemCount = param1.readInteger();
         UnknownVarFromExtendedProfileData_Boolean_1 = param1.readBoolean();
         UnknownVarFromExtendedProfileData_Boolean_2 = param1.readBoolean();
         _totalBadges = param1.readInteger();
         _achievementLevel = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _badgeRarityCounts.push(new BadgeRarityCountData(param1.readByte(),param1.readInteger()));
            _loc3_++;
         }
         _totalBadgesRank = param1.readInteger();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get isHidden() : Boolean
      {
         return _isHidden;
      }
      
      public function get motto() : String
      {
         return _motto;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get creationDate() : String
      {
         return _creationDate;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function get friendCount() : int
      {
         return _friendCount;
      }
      
      public function get isFriend() : Boolean
      {
         return _isFriend;
      }
      
      public function get isFriendRequestSent() : Boolean
      {
         return _isFriendRequestSent;
      }
      
      public function get onlineStatus() : int
      {
         return _onlineStatus;
      }
      
      public function get guilds() : Array
      {
         return _guilds;
      }
      
      public function set isFriendRequestSent(param1:Boolean) : void
      {
         _isFriendRequestSent = param1;
      }
      
      public function get lastAccessSinceInSeconds() : int
      {
         return _lastAccessSinceInSeconds;
      }
      
      public function get openProfileWindow() : Boolean
      {
         return _openProfileWindow;
      }
      
      public function get accountLevel() : int
      {
         return _accountLevel;
      }
      
      public function get starGemCount() : int
      {
         return _starGemCount;
      }
      
      public function get totalBadges() : int
      {
         return _totalBadges;
      }
      
      public function get achievementLevel() : int
      {
         return _achievementLevel;
      }
      
      public function get badgeRarityCounts() : Array
      {
         return _badgeRarityCounts;
      }
      
      public function get totalBadgesRank() : int
      {
         return _totalBadgesRank;
      }
      
      public function getBadgeCountByRarityId(param1:int) : int
      {
         for each(var _loc2_ in _badgeRarityCounts)
         {
            if(_loc2_.rarityId == param1)
            {
               return _loc2_.count;
            }
         }
         return 0;
      }
   }
}

