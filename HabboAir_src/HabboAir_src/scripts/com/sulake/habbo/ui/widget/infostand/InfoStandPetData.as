package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandPetData
   {
      private var _level:int;
      
      private var _levelMax:int;
      
      private var _experience:int;
      
      private var _experienceMax:int;
      
      private var _energy:int;
      
      private var _energyMax:int;
      
      private var _nutrition:int;
      
      private var _nutritionMax:int;
      
      private var _petRespect:int;
      
      private var _name:String = "";
      
      private var _id:int = -1;
      
      private var _type:int;
      
      private var _race:int;
      
      private var _image:BitmapData;
      
      private var _isOwnPet:Boolean;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _canRemovePet:Boolean;
      
      private var _roomIndex:int;
      
      private var _age:int;
      
      private var _breedId:int;
      
      private var _skillTresholds:Array;
      
      private var _accessRights:int;
      
      private var _rarityLevel:int;
      
      private var _hasBreedingPermission:Boolean;
      
      private var _maxWellBeingSeconds:int;
      
      private var _remainingWellBeingSeconds:int;
      
      private var _remainingGrowingSeconds:int;
      
      public function InfoStandPetData()
      {
         super();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get race() : int
      {
         return _race;
      }
      
      public function get image() : BitmapData
      {
         return _image;
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
      
      public function get age() : int
      {
         return _age;
      }
      
      public function get breedId() : int
      {
         return _breedId;
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
      
      public function get petRespect() : int
      {
         return _petRespect;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return _maxWellBeingSeconds;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return _remainingWellBeingSeconds;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return _remainingGrowingSeconds;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
      
      public function setData(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         _name = param1.name;
         _id = param1.id;
         _type = param1.petType;
         _race = param1.petRace;
         _image = param1.image;
         _isOwnPet = param1.isOwnPet;
         _ownerId = param1.ownerId;
         _ownerName = param1.ownerName;
         _canRemovePet = param1.canRemovePet;
         _level = param1.level;
         _levelMax = param1.levelMax;
         _experience = param1.experience;
         _experienceMax = param1.experienceMax;
         _energy = param1.energy;
         _energyMax = param1.energyMax;
         _nutrition = param1.nutrition;
         _nutritionMax = param1.nutritionMax;
         _petRespect = param1.petRespect;
         _roomIndex = param1.roomIndex;
         _age = param1.age;
         _breedId = param1.breedId;
         _skillTresholds = param1.skillTresholds;
         _accessRights = param1.accessRights;
         _maxWellBeingSeconds = param1.maxWellBeingSeconds;
         _remainingWellBeingSeconds = param1.remainingWellBeingSeconds;
         _remainingGrowingSeconds = param1.remainingGrowingSeconds;
         _rarityLevel = param1.rarityLevel;
         _hasBreedingPermission = param1.hasBreedingPermission;
      }
   }
}

