package com.sulake.habbo.session
{
   public class UserData implements IUserData
   {
      private var _roomObjectId:int = -1;
      
      private var _name:String = "";
      
      private var _type:int = 0;
      
      private var UnknownVarFromUserData_String_1:String = "";
      
      private var UnknownVarFromUserData_String_2:String = "";
      
      private var UnknownVarFromUserData_String_3:String = "";
      
      private var _achievementScore:int;
      
      private var UnknownVarFromUserData_Int_1:int = -1;
      
      private var _webID:int = 0;
      
      private var UnknownVarFromUserData_String_4:String = "";
      
      private var _groupStatus:int = 0;
      
      private var _groupName:String = "";
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _petLevel:int = 0;
      
      private var _rarityLevel:int = 0;
      
      private var _hasSaddle:Boolean;
      
      private var _isRiding:Boolean;
      
      private var _canBreed:Boolean;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _hasBreedingPermission:Boolean;
      
      private var _botSkills:Array;
      
      private var _botSkillData:Array;
      
      private var _isModerator:Boolean;
      
      private var _isBlocked:Boolean = false;
      
      public function UserData(param1:int)
      {
         super();
         _roomObjectId = param1;
      }
      
      public function get roomObjectId() : int
      {
         return _roomObjectId;
      }
      
      public function get achievementScore() : int
      {
         return _isBlocked ? 0 : _achievementScore;
      }
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get badgesRank() : int
      {
         return _isBlocked ? -1 : UnknownVarFromUserData_Int_1;
      }
      
      public function set badgesRank(param1:int) : void
      {
         UnknownVarFromUserData_Int_1 = param1;
      }
      
      public function get name() : String
      {
         return _isBlocked ? "" : _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get sex() : String
      {
         return _isBlocked ? "M" : UnknownVarFromUserData_String_1;
      }
      
      public function set sex(param1:String) : void
      {
         UnknownVarFromUserData_String_1 = param1;
      }
      
      public function get figure() : String
      {
         return _isBlocked ? "" : UnknownVarFromUserData_String_2;
      }
      
      public function set figure(param1:String) : void
      {
         UnknownVarFromUserData_String_2 = param1;
      }
      
      public function get custom() : String
      {
         return _isBlocked ? "" : UnknownVarFromUserData_String_3;
      }
      
      public function set custom(param1:String) : void
      {
         UnknownVarFromUserData_String_3 = param1;
      }
      
      public function get webID() : int
      {
         return _webID;
      }
      
      public function set webID(param1:int) : void
      {
         _webID = param1;
      }
      
      public function get groupID() : String
      {
         return _isBlocked ? "" : UnknownVarFromUserData_String_4;
      }
      
      public function set groupID(param1:String) : void
      {
         UnknownVarFromUserData_String_4 = param1;
      }
      
      public function get groupName() : String
      {
         return _isBlocked ? "" : _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupStatus() : int
      {
         return _isBlocked ? 0 : _groupStatus;
      }
      
      public function set groupStatus(param1:int) : void
      {
         _groupStatus = param1;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         _ownerId = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         _rarityLevel = param1;
      }
      
      public function get hasSaddle() : Boolean
      {
         return _hasSaddle;
      }
      
      public function set hasSaddle(param1:Boolean) : void
      {
         _hasSaddle = param1;
      }
      
      public function get isRiding() : Boolean
      {
         return _isRiding;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         _isRiding = param1;
      }
      
      public function get canBreed() : Boolean
      {
         return _canBreed;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         _canBreed = param1;
      }
      
      public function get canHarvest() : Boolean
      {
         return _canHarvest;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         _canHarvest = param1;
      }
      
      public function get canRevive() : Boolean
      {
         return _canRevive;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         _canRevive = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         _hasBreedingPermission = param1;
      }
      
      public function get petLevel() : int
      {
         return _petLevel;
      }
      
      public function set petLevel(param1:int) : void
      {
         _petLevel = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillData() : Array
      {
         return _botSkillData;
      }
      
      public function set botSkillData(param1:Array) : void
      {
         _botSkillData = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return _isModerator;
      }
      
      public function set isModerator(param1:Boolean) : void
      {
         _isModerator = param1;
      }
      
      public function get isBlocked() : Boolean
      {
         return _isBlocked;
      }
      
      public function set isBlocked(param1:Boolean) : void
      {
         _isBlocked = param1;
      }
   }
}

