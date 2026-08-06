package com.sulake.habbo.catalog.navigation
{
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   
   public class CatalogNode implements ICatalogNode
   {
      private static const ICON_PREFIX:String = "icon_";
      
      private var _depth:int = 0;
      
      private var _localization:String = "";
      
      private var _pageId:int = -1;
      
      private var _pageName:String = "";
      
      private var UnknownVarFromCatalogNode_Int_1:int = 0;
      
      private var _children:Vector.<ICatalogNode>;
      
      private var _offerIds:Vector.<int>;
      
      private var _navigator:ICatalogNavigator;
      
      private var _parent:ICatalogNode;
      
      public function CatalogNode(param1:ICatalogNavigator, param2:NodeData, param3:int, param4:ICatalogNode)
      {
         super();
         _depth = param3;
         _parent = param4;
         _navigator = param1;
         _localization = param2.localization;
         _pageId = param2.pageId;
         _pageName = param2.pageName;
         UnknownVarFromCatalogNode_Int_1 = param2.icon;
         _children = new Vector.<ICatalogNode>(0);
         _offerIds = param2.offerIds;
      }
      
      public function get isOpen() : Boolean
      {
         return false;
      }
      
      public function get depth() : int
      {
         return _depth;
      }
      
      public function get isBranch() : Boolean
      {
         return _children.length > 0;
      }
      
      public function get isLeaf() : Boolean
      {
         return _children.length == 0;
      }
      
      public function get visible() : Boolean
      {
         return false;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get children() : Vector.<ICatalogNode>
      {
         return _children;
      }
      
      public function get offerIds() : Vector.<int>
      {
         return _offerIds;
      }
      
      public function get navigator() : ICatalogNavigator
      {
         return _navigator;
      }
      
      public function get parent() : ICatalogNode
      {
         return _parent;
      }
      
      public function set parent(param1:ICatalogNode) : void
      {
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _children)
         {
            _loc1_.dispose();
         }
         _children = null;
         _offerIds = null;
         _navigator = null;
         _parent = null;
         _pageName = "";
         _localization = "";
      }
      
      public function addChild(param1:ICatalogNode) : void
      {
         if(param1 == null)
         {
            return;
         }
         _children.push(param1);
      }
      
      public function activate() : void
      {
      }
      
      public function deactivate() : void
      {
      }
      
      public function open() : void
      {
      }
      
      public function close() : void
      {
      }
      
      public function get iconName() : String
      {
         if(UnknownVarFromCatalogNode_Int_1 < 1)
         {
            return "";
         }
         return "icon_" + UnknownVarFromCatalogNode_Int_1.toString();
      }
      
      public function get offsetV() : int
      {
         return 0;
      }
   }
}

