package com.sulake.habbo.session
{
   public interface IUserDataManager
   {
      function setUserData(param1:IUserData) : void;
      
      function getUserData(param1:int) : IUserData;
      
      function getUserDataByType(param1:int, param2:int) : IUserData;
      
      function getUserDataByIndex(param1:int) : IUserData;
      
      function getUserDataByName(param1:String) : IUserData;
      
      function getUserSelectedBadges(param1:int) : Array;
      
      function requestUserSelectedBadges(param1:int) : void;
      
      function removeUserDataByRoomIndex(param1:int) : void;
      
      function setUserSelectedBadges(param1:int, param2:Array) : void;
      
      function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void;
      
      function updatePetLevel(param1:int, param2:int) : void;
      
      function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void;
      
      function updateCustom(param1:int, param2:String) : void;
      
      function updateAchievementScore(param1:int, param2:int) : void;
      
      function updateBadgesRank(param1:int, param2:int) : void;
      
      function updateNameByIndex(param1:int, param2:String) : void;
      
      function markAsBlocked(param1:int, param2:Boolean = true) : void;
      
      function getPetUserData(param1:int) : IUserData;
      
      function getRentableBotUserData(param1:int) : IUserData;
      
      function requestPetInfo(param1:int) : void;
      
      function getAllUserIds() : Array;
   }
}

