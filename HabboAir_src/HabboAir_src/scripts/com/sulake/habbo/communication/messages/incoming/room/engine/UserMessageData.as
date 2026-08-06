package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class UserMessageData
   {
      public static const UnknownConstFromUserMessageData_String_1:String = "M";
      
      public static const UnknownConstFromUserMessageData_String_2:String = "F";
      
      private var _roomIndex:int = 0;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      private var _dir:int = 0;
      
      private var _name:String = "";
      
      private var _userType:int = 0;
      
      private var _sex:String = "";
      
      private var _figure:String = "";
      
      private var _custom:String = "";
      
      private var _achievementScore:int;
      
      private var _badgesRank:int = -1;
      
      private var _webID:int = 0;
      
      private var _groupID:String = "";
      
      private var _groupStatus:int = 0;
      
      private var _groupName:String = "";
      
      private var _subType:String = "";
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String;
      
      private var _rarityLevel:int;
      
      private var _hasSaddle:Boolean;
      
      private var _isRiding:Boolean;
      
      private var _canBreed:Boolean;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _hasBreedingPermission:Boolean;
      
      private var _petLevel:int = 0;
      
      private var _petPosture:String = "";
      
      private var _botSkills:Array;
      
      private var _isModerator:Boolean;
      
      private var UnknownVarFromUserMessageData_Boolean_1:Boolean = false;
      
      public function UserMessageData(param1:int)
      {
         super();
         _roomIndex = param1;
      }
      
      public function setReadOnly() : void
      {
         UnknownVarFromUserMessageData_Boolean_1 = true;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _x = param1;
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _y = param1;
         }
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _z = param1;
         }
      }
      
      public function get dir() : int
      {
         return _dir;
      }
      
      public function set dir(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _dir = param1;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _name = param1;
         }
      }
      
      public function get userType() : int
      {
         return _userType;
      }
      
      public function set userType(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _userType = param1;
         }
      }
      
      public function get sex() : String
      {
         return _sex;
      }
      
      public function set sex(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _sex = param1;
         }
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function set figure(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _figure = param1;
         }
      }
      
      public function get custom() : String
      {
         return _custom;
      }
      
      public function set custom(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _custom = param1;
         }
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _achievementScore = param1;
         }
      }
      
      public function get badgesRank() : int
      {
         return _badgesRank;
      }
      
      public function set badgesRank(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _badgesRank = param1;
         }
      }
      
      public function get webID() : int
      {
         return _webID;
      }
      
      public function set webID(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _webID = param1;
         }
      }
      
      public function get groupID() : String
      {
         return _groupID;
      }
      
      public function set groupID(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _groupID = param1;
         }
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _groupName = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return _groupStatus;
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _groupStatus = param1;
         }
      }
      
      public function get subType() : String
      {
         return _subType;
      }
      
      public function set subType(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _subType = param1;
         }
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _ownerId = param1;
         }
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _ownerName = param1;
         }
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _rarityLevel = param1;
         }
      }
      
      public function get hasSaddle() : Boolean
      {
         return _hasSaddle;
      }
      
      public function set hasSaddle(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _hasSaddle = param1;
         }
      }
      
      public function get isRiding() : Boolean
      {
         return _isRiding;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _isRiding = param1;
         }
      }
      
      public function get canBreed() : Boolean
      {
         return _canBreed;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _canBreed = param1;
         }
      }
      
      public function get canHarvest() : Boolean
      {
         return _canHarvest;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _canHarvest = param1;
         }
      }
      
      public function get canRevive() : Boolean
      {
         return _canRevive;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _canRevive = param1;
         }
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _hasBreedingPermission = param1;
         }
      }
      
      public function get petLevel() : int
      {
         return _petLevel;
      }
      
      public function set petLevel(param1:int) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _petLevel = param1;
         }
      }
      
      public function get petPosture() : String
      {
         return _petPosture;
      }
      
      public function set petPosture(param1:String) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _petPosture = param1;
         }
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return _isModerator;
      }
      
      public function set isModerator(param1:Boolean) : void
      {
         if(!UnknownVarFromUserMessageData_Boolean_1)
         {
            _isModerator = param1;
         }
      }
   }
}

