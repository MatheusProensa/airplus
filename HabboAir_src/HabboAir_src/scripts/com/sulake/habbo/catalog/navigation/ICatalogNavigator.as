package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import flash.utils.Dictionary;
   
   public interface ICatalogNavigator
   {
      function dispose() : void;
      
      function get catalog() : IHabboCatalog;
      
      function buildCatalogIndex(param1:NodeData) : void;
      
      function showIndex() : void;
      
      function activateNode(param1:ICatalogNode) : void;
      
      function loadFrontPage() : void;
      
      function get initialized() : Boolean;
      
      function getNodesByOfferId(param1:int, param2:Boolean = false) : Vector.<ICatalogNode>;
      
      function getNodeByName(param1:String) : ICatalogNode;
      
      function getOptionalNodeByName(param1:String) : ICatalogNode;
      
      function getNodeById(param1:int, param2:ICatalogNode = null) : ICatalogNode;
      
      function openPage(param1:String) : void;
      
      function openPageById(param1:int, param2:int) : void;
      
      function openPageByOfferId(param1:int) : void;
      
      function deactivateCurrentNode() : void;
      
      function filter(param1:String, param2:Array, param3:Dictionary = null) : void;
      
      function get listTemplate() : IWindowModel;
      
      function getItemTemplate(param1:int) : IWindowModel;
      
      function get isDeepHierarchy() : Boolean;
   }
}

