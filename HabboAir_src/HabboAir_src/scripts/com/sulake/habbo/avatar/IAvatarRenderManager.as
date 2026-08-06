package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.avatar.animation.IAnimationManager;
   import com.sulake.habbo.avatar.structure.IFigureSetData;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public interface IAvatarRenderManager extends IUnknown
   {
      function createAvatarImage(param1:String, param2:String, param3:String = null, param4:UnknownIHabboAvatar1 = null, param5:IAvatarImage_1 = null) : IAvatarImage_2;
      
      function createBlockedAvatarImage(param1:String, param2:String) : IAvatarImage_2;
      
      function get assets() : IAssetLibraryCollection;
      
      function getFigureData() : IFigureSetData;
      
      function getFigureStringWithFigureIds(param1:String, param2:String, param3:Vector.<int>) : String;
      
      function isValidFigureSetForGender(param1:int, param2:String) : Boolean;
      
      function getMandatoryAvatarPartSetIds(param1:String, param2:int) : Array;
      
      function getAssetByName(param1:String) : ISoundAsset;
      
      function get mode() : String;
      
      function set mode(param1:String) : void;
      
      function injectFigureData(param1:XML) : void;
      
      function createFigureContainer(param1:String) : IAvatarFigureContainer;
      
      function isFigureReady(param1:IAvatarFigureContainer) : Boolean;
      
      function downloadFigure(param1:IAvatarFigureContainer, param2:UnknownIHabboAvatar1) : void;
      
      function getAnimationManager() : IAnimationManager;
      
      function get events() : IEventDispatcher;
      
      function resetAssetManager() : void;
      
      function resolveClubLevel(param1:IAvatarFigureContainer, param2:String, param3:Array = null) : int;
      
      function getItemIds() : Array;
      
      function get effectMap() : Dictionary;
      
      function purgeAssets() : void;
      
      function get isReady() : Boolean;
      
      function resetAllCaches() : void;
   }
}

