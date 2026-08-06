package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const PET_INFO:String = "RWPIUE_PET_INFO";
      
      private var _level:int;
      
      private var _levelMax:int;
      
      private var _experience:int;
      
      private var _experienceMax:int;
      
      private var _energy:int;
      
      private var _energyMax:int;
      
      private var _nutrition:int;
      
      private var _nutritionMax:int;
      
      private var _petRespectLeft:int;
      
      private var _petRespect:int;
      
      private var _age:int;
      
      private var _name:String;
      
      private var _id:int;
      
      private var _image:BitmapData;
      
      private var _petType:int;
      
      private var _petRace:int;
      
      private var _isOwnPet:Boolean;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _canRemovePet:Boolean;
      
      private var _roomIndex:int;
      
      private var _breedId:int;
      
      private var _hasFreeSaddle:Boolean;
      
      private var _isRiding:Boolean;
      
      private var _canBreed:Boolean;
      
      private var _skillTresholds:Array;
      
      private var _accessRights:int;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _rarityLevel:int;
      
      private var _maxWellBeingSeconds:int;
      
      private var _remainingWellBeingSeconds:int;
      
      private var _remainingGrowingSeconds:int;
      
      private var _hasBreedingPermission:Boolean;
      
      public function RoomWidgetPetInfoUpdateEvent(param1:int, param2:int, param3:String, param4:int, param5:BitmapData, param6:Boolean, param7:int, param8:String, param9:int, param10:int, param11:Boolean = false, param12:Boolean = false)
      {
         super("RWPIUE_PET_INFO",param11,param12);
         _petType = param1;
         _petRace = param2;
         _name = param3;
         _id = param4;
         _image = param5;
         _isOwnPet = param6;
         _ownerId = param7;
         _ownerName = param8;
         _roomIndex = param9;
         _breedId = param10;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get petType() : int
      {
         return _petType;
      }
      
      public function get petRace() : int
      {
         return _petRace;
      }
      
      public function get isOwnPet() : Boolean
      {
         return _isOwnPet;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get canRemovePet() : Boolean
      {
         return _canRemovePet;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get age() : int
      {
         return _age;
      }
      
      public function get breedId() : int
      {
         return _breedId;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         return _hasFreeSaddle;
      }
      
      public function get isRiding() : Boolean
      {
         return _isRiding;
      }
      
      public function get canBreed() : Boolean
      {
         return _canBreed;
      }
      
      public function get canHarvest() : Boolean
      {
         return _canHarvest;
      }
      
      public function get canRevive() : Boolean
      {
         return _canRevive;
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function get skillTresholds() : Array
      {
         return _skillTresholds;
      }
      
      public function get accessRights() : int
      {
         return _accessRights;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get levelMax() : int
      {
         return _levelMax;
      }
      
      public function get experience() : int
      {
         return _experience;
      }
      
      public function get experienceMax() : int
      {
         return _experienceMax;
      }
      
      public function get energy() : int
      {
         return _energy;
      }
      
      public function get energyMax() : int
      {
         return _energyMax;
      }
      
      public function get nutrition() : int
      {
         return _nutrition;
      }
      
      public function get nutritionMax() : int
      {
         return _nutritionMax;
      }
      
      public function get petRespectLeft() : int
      {
         return _petRespectLeft;
      }
      
      public function get petRespect() : int
      {
         return _petRespect;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function set levelMax(param1:int) : void
      {
         _levelMax = param1;
      }
      
      public function set experience(param1:int) : void
      {
         _experience = param1;
      }
      
      public function set experienceMax(param1:int) : void
      {
         _experienceMax = param1;
      }
      
      public function set energy(param1:int) : void
      {
         _energy = param1;
      }
      
      public function set energyMax(param1:int) : void
      {
         _energyMax = param1;
      }
      
      public function set nutrition(param1:int) : void
      {
         _nutrition = param1;
      }
      
      public function set nutritionMax(param1:int) : void
      {
         _nutritionMax = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         _petRespectLeft = param1;
      }
      
      public function set canRemovePet(param1:Boolean) : void
      {
         _canRemovePet = param1;
      }
      
      public function set petRespect(param1:int) : void
      {
         _petRespect = param1;
      }
      
      public function set age(param1:int) : void
      {
         _age = param1;
      }
      
      public function set hasFreeSaddle(param1:Boolean) : void
      {
         _hasFreeSaddle = param1;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         _isRiding = param1;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         _canBreed = param1;
      }
      
      public function set skillTresholds(param1:Array) : void
      {
         _skillTresholds = param1;
      }
      
      public function set accessRights(param1:int) : void
      {
         _accessRights = param1;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         _canHarvest = param1;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         _canRevive = param1;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         _rarityLevel = param1;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return _maxWellBeingSeconds;
      }
      
      public function set maxWellBeingSeconds(param1:int) : void
      {
         _maxWellBeingSeconds = param1;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return _remainingWellBeingSeconds;
      }
      
      public function set remainingWellBeingSeconds(param1:int) : void
      {
         _remainingWellBeingSeconds = param1;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return _remainingGrowingSeconds;
      }
      
      public function set remainingGrowingSeconds(param1:int) : void
      {
         _remainingGrowingSeconds = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         _hasBreedingPermission = param1;
      }
   }
}

