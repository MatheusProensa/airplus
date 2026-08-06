package com.sulake.habbo.communication.messages.parser.room.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetInfoMessageParser implements IMessageParser
   {
      private var _petId:int;
      
      private var _name:String;
      
      private var _level:int;
      
      private var _maxLevel:int;
      
      private var _experience:int;
      
      private var _energy:int;
      
      private var _nutrition:int;
      
      private var _experienceRequiredToLevel:int;
      
      private var _maxEnergy:int;
      
      private var _maxNutrition:int;
      
      private var _respect:int;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _age:int;
      
      private var _breedId:int;
      
      private var _hasFreeSaddle:Boolean;
      
      private var _isRiding:Boolean;
      
      private var _canBreed:Boolean;
      
      private var _canHarvest:Boolean;
      
      private var _canRevive:Boolean;
      
      private var _maxWellBeingSeconds:int;
      
      private var _remainingWellBeingSeconds:int;
      
      private var _remainingGrowingSeconds:int;
      
      private var _skillTresholds:Array;
      
      private var _accessRights:int;
      
      private var _rarityLevel:int;
      
      private var _hasBreedingPermission:Boolean;
      
      public function PetInfoMessageParser()
      {
         super();
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
      
      public function get experience() : int
      {
         return _experience;
      }
      
      public function get energy() : int
      {
         return _energy;
      }
      
      public function get nutrition() : int
      {
         return _nutrition;
      }
      
      public function get experienceRequiredToLevel() : int
      {
         return _experienceRequiredToLevel;
      }
      
      public function get maxEnergy() : int
      {
         return _maxEnergy;
      }
      
      public function get maxNutrition() : int
      {
         return _maxNutrition;
      }
      
      public function get respect() : int
      {
         return _respect;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
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
      
      public function get skillTresholds() : Array
      {
         return _skillTresholds;
      }
      
      public function get accessRights() : int
      {
         return _accessRights;
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return _hasBreedingPermission;
      }
      
      public function flush() : Boolean
      {
         _petId = -1;
         _skillTresholds = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         _petId = param1.readInteger();
         _name = param1.readString();
         _level = param1.readInteger();
         _maxLevel = param1.readInteger();
         _experience = param1.readInteger();
         _experienceRequiredToLevel = param1.readInteger();
         _energy = param1.readInteger();
         _maxEnergy = param1.readInteger();
         _nutrition = param1.readInteger();
         _maxNutrition = param1.readInteger();
         _respect = param1.readInteger();
         _ownerId = param1.readInteger();
         _age = param1.readInteger();
         _ownerName = param1.readString();
         _breedId = param1.readInteger();
         _hasFreeSaddle = param1.readBoolean();
         _isRiding = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _skillTresholds.push(param1.readInteger());
            _loc2_++;
         }
         _skillTresholds.sort(16);
         _accessRights = param1.readInteger();
         _canBreed = param1.readBoolean();
         _canHarvest = param1.readBoolean();
         _canRevive = param1.readBoolean();
         _rarityLevel = param1.readInteger();
         _maxWellBeingSeconds = param1.readInteger();
         _remainingWellBeingSeconds = param1.readInteger();
         _remainingGrowingSeconds = param1.readInteger();
         _hasBreedingPermission = param1.readBoolean();
         return true;
      }
   }
}

