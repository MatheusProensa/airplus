package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.GetPetInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
   
   public class UserDataManager implements IUserDataManager
   {
      private static const TYPE_USER:int = 1;
      
      private static const TYPE_PET:int = 2;
      
      private static const UnknownConstFromUserDataManager_Int_1:int = 3;
      
      private static const UnknownConstFromUserDataManager_Int_2:int = 4;
      
      private var UnknownVarFromUserDataManager_Map_1:Map;
      
      private var UnknownVarFromUserDataManager_Map_2:Map;
      
      private var _userSelectedBadges:Map;
      
      private var UnknownVarFromUserDataManager_IConnection_1:IConnection;
      
      public function UserDataManager()
      {
         super();
         UnknownVarFromUserDataManager_Map_1 = new Map();
         UnknownVarFromUserDataManager_Map_2 = new Map();
         _userSelectedBadges = new Map();
      }
      
      public function dispose() : void
      {
         UnknownVarFromUserDataManager_IConnection_1 = null;
         UnknownVarFromUserDataManager_Map_1.dispose();
         UnknownVarFromUserDataManager_Map_1 = null;
         UnknownVarFromUserDataManager_Map_2.dispose();
         UnknownVarFromUserDataManager_Map_2 = null;
         _userSelectedBadges.dispose();
         _userSelectedBadges = null;
      }
      
      public function set connection(param1:IConnection) : void
      {
         UnknownVarFromUserDataManager_IConnection_1 = param1;
      }
      
      public function getUserData(param1:int) : IUserData
      {
         return getUserDataByType(param1,1);
      }
      
      public function getUserDataByType(param1:int, param2:int) : IUserData
      {
         var _loc3_:IUserData = null;
         var _loc4_:Map = UnknownVarFromUserDataManager_Map_1.getValue(param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.getValue(param1);
         }
         return _loc3_;
      }
      
      public function getUserDataByIndex(param1:int) : IUserData
      {
         return UnknownVarFromUserDataManager_Map_2.getValue(param1);
      }
      
      public function getUserDataByName(param1:String) : IUserData
      {
         for each(var _loc2_ in UnknownVarFromUserDataManager_Map_2)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function requestUserSelectedBadges(param1:int) : void
      {
         if(UnknownVarFromUserDataManager_IConnection_1 != null)
         {
            UnknownVarFromUserDataManager_IConnection_1.send(new GetSelectedBadgesMessageComposer(param1));
         }
      }
      
      public function getUserSelectedBadges(param1:int) : Array
      {
         var _loc2_:Array = _userSelectedBadges.getValue(param1) as Array;
         if(_loc2_ == null)
         {
            _loc2_ = [];
         }
         return _loc2_;
      }
      
      public function setUserData(param1:IUserData) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeUserDataByRoomIndex(param1.roomObjectId);
         var _loc2_:Map = UnknownVarFromUserDataManager_Map_1.getValue(param1.type);
         if(_loc2_ == null)
         {
            _loc2_ = new Map();
            UnknownVarFromUserDataManager_Map_1.add(param1.type,_loc2_);
         }
         _loc2_.add(param1.webID,param1);
         UnknownVarFromUserDataManager_Map_2.add(param1.roomObjectId,param1);
      }
      
      public function removeUserDataByRoomIndex(param1:int) : void
      {
         var _loc4_:Map = null;
         var _loc3_:IUserData = null;
         var _loc2_:IUserData = UnknownVarFromUserDataManager_Map_2.remove(param1);
         if(_loc2_ != null)
         {
            _loc4_ = UnknownVarFromUserDataManager_Map_1.getValue(_loc2_.type);
            if(_loc4_ != null)
            {
               _loc3_ = _loc4_.remove(_loc2_.webID);
               if(_loc3_ != null)
               {
               }
            }
         }
      }
      
      public function setUserSelectedBadges(param1:int, param2:Array) : void
      {
         _userSelectedBadges.remove(param1);
         _userSelectedBadges.add(param1,param2 == null ? [] : param2);
      }
      
      public function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:IUserData = getUserDataByIndex(param1);
         if(_loc6_ != null)
         {
            _loc6_.figure = param2;
            _loc6_.sex = param3;
            _loc6_.hasSaddle = param4;
            _loc6_.isRiding = param5;
         }
      }
      
      public function updatePetLevel(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.petLevel = param2;
         }
      }
      
      public function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:IUserData = getUserDataByIndex(param1);
         if(_loc6_ != null)
         {
            _loc6_.canBreed = param2;
            _loc6_.canHarvest = param3;
            _loc6_.canRevive = param4;
            _loc6_.hasBreedingPermission = param5;
         }
      }
      
      public function updateCustom(param1:int, param2:String) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.custom = param2;
         }
      }
      
      public function updateAchievementScore(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.achievementScore = param2;
         }
      }
      
      public function updateBadgesRank(param1:int, param2:int) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.badgesRank = param2;
         }
      }
      
      public function markAsBlocked(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.isBlocked = param2;
         }
      }
      
      public function updateNameByIndex(param1:int, param2:String) : void
      {
         var _loc3_:IUserData = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.name = param2;
         }
      }
      
      public function getPetUserData(param1:int) : IUserData
      {
         return getUserDataByType(param1,2);
      }
      
      public function getRentableBotUserData(param1:int) : IUserData
      {
         return getUserDataByType(param1,4);
      }
      
      public function requestPetInfo(param1:int) : void
      {
         var _loc2_:IUserData = getPetUserData(param1);
         if(_loc2_ != null && UnknownVarFromUserDataManager_IConnection_1 != null)
         {
            UnknownVarFromUserDataManager_IConnection_1.send(new GetPetInfoMessageComposer(_loc2_.webID));
         }
      }
      
      public function getAllUserIds() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in UnknownVarFromUserDataManager_Map_2)
         {
            _loc2_.push(_loc1_.webID);
         }
         return _loc2_;
      }
      
      public function ResetUserData() : void
      {
         if(UnknownVarFromUserDataManager_Map_1)
         {
            UnknownVarFromUserDataManager_Map_1.reset();
         }
         if(UnknownVarFromUserDataManager_Map_2)
         {
            UnknownVarFromUserDataManager_Map_2.reset();
         }
         if(_userSelectedBadges)
         {
            _userSelectedBadges.reset();
         }
      }
   }
}

