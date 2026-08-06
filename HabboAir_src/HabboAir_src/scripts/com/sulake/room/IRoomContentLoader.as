package com.sulake.room
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import flash.events.IEventDispatcher;
   
   public interface IRoomContentLoader
   {
      function dispose() : void;
      
      function getPlaceHolderType(param1:String) : String;
      
      function getPlaceHolderTypes() : Array;
      
      function getContentType(param1:String) : String;
      
      function hasInternalContent(param1:String) : Boolean;
      
      function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean;
      
      function insertObjectContent(param1:int, param2:int, param3:IAssetLibraryCollection) : Boolean;
      
      function getVisualizationType(param1:String) : String;
      
      function getLogicType(param1:String) : String;
      
      function hasVisualizationXML(param1:String) : Boolean;
      
      function getVisualizationXML(param1:String) : XML;
      
      function hasAssetXML(param1:String) : Boolean;
      
      function getAssetXML(param1:String) : XML;
      
      function hasLogicXML(param1:String) : Boolean;
      
      function getLogicXML(param1:String) : XML;
      
      function getGraphicAssetCollection(param1:String) : IGraphicAssetCollection;
      
      function roomObjectCreated(param1:IRoomObject, param2:String) : void;
   }
}

