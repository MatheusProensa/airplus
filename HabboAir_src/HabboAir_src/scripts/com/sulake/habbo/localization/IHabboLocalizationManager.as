package com.sulake.habbo.localization
{
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   
   public interface IHabboLocalizationManager extends ICoreLocalizationManager, IUnknown
   {
      function loadDefaultEmbedLocalizations(param1:String, param2:Boolean = false) : Boolean;
      
      function requestLocalizationInit() : void;
      
      function getActiveEnvironmentId() : String;
      
      function getExternalVariablesUrl() : String;
      
      function getExternalVariablesHash() : String;
      
      function getGameDataResourceUrl(param1:String) : String;
      
      function getGameDataResourceHash(param1:String) : String;
      
      function getLocalizationWithParams(param1:String, param2:String = "", ... rest) : String;
      
      function getLocalizationWithParamMap(param1:String, param2:String = "", param3:Map = null) : String;
      
      function getAchievementName(param1:String) : String;
      
      function getAchievementDesc(param1:String, param2:int) : String;
      
      function getAchievementInstruction(param1:String) : String;
      
      function getBadgeBaseName(param1:String) : String;
      
      function getBadgeName(param1:String) : String;
      
      function getBadgeDesc(param1:String) : String;
      
      function setBadgePointLimit(param1:String, param2:int) : void;
      
      function getPreviousLevelBadgeId(param1:String) : String;
   }
}

