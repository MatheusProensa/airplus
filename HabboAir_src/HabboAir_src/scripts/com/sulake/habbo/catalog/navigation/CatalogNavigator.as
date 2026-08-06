package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.TopViewSelector;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
   import flash.utils.Dictionary;
   
   public class CatalogNavigator implements ICatalogNavigator
   {
      public static const DUMMY_PAGE_ID_FOR_OFFER_SEARCH:int = -12345678;
      
      private var _catalog:HabboCatalog;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromCatalogNavigator_String_1:String;
      
      private var UnknownVarFromCatalogNavigator_ITabContextWindow_1:ITabContextWindow;
      
      private var UnknownVarFromCatalogNavigator_IItemListWindow_1:IItemListWindow;
      
      private var _index:ICatalogNode;
      
      private var _currentNodes:Vector.<ICatalogNode>;
      
      private var _offersToNodes:Dictionary;
      
      private var UnknownVarFromCatalogNavigator_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromCatalogNavigator_IWindowModel_2:IWindowModel;
      
      private var _listTemplate:IWindowModel;
      
      private var UnknownVarFromCatalogNavigator_TopViewSelector_1:TopViewSelector;
      
      public function CatalogNavigator(param1:HabboCatalog, param2:IWindowController_1, param3:String)
      {
         super();
         _catalog = param1;
         _container = param2;
         UnknownVarFromCatalogNavigator_String_1 = param3;
         _currentNodes = new Vector.<ICatalogNode>(0);
         UnknownVarFromCatalogNavigator_IItemListWindow_1 = _container.findChildByName("navigationList") as IItemListWindow;
         UnknownVarFromCatalogNavigator_IWindowModel_1 = UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItem(UnknownVarFromCatalogNavigator_IItemListWindow_1.getListItemByName(param3.toLowerCase() + "_topitem_template"));
         UnknownVarFromCatalogNavigator_IWindowModel_2 = UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItem(UnknownVarFromCatalogNavigator_IItemListWindow_1.getListItemByName(param3.toLowerCase() + "_subitem_template"));
         _listTemplate = UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItem(UnknownVarFromCatalogNavigator_IItemListWindow_1.getListItemByName(param3.toLowerCase() + "_list_template"));
         UnknownVarFromCatalogNavigator_ITabContextWindow_1 = ITabContextWindow(_container.findChildByName("tab_context"));
         if(UnknownVarFromCatalogNavigator_ITabContextWindow_1 != null)
         {
            if(_catalog.useNonTabbedCatalog(param3))
            {
               UnknownVarFromCatalogNavigator_ITabContextWindow_1.visible = false;
            }
            else
            {
               UnknownVarFromCatalogNavigator_TopViewSelector_1 = new TopViewSelector(this,UnknownVarFromCatalogNavigator_ITabContextWindow_1);
            }
         }
      }
      
      private static function markSearchNodes(param1:String, param2:Array, param3:Dictionary, param4:ICatalogNode, param5:Dictionary) : Boolean
      {
         var _loc6_:Boolean = false;
         try
         {
            if(param4.visible && param4.pageId > 0 && isSearchMatch(param1,param2,param3,param4))
            {
               includeVisibleSubtree(param4,param5);
               return true;
            }
            _loc6_ = false;
            for each(var _loc7_ in param4.children)
            {
               if(markSearchNodes(param1,param2,param3,_loc7_,param5))
               {
                  _loc6_ = true;
               }
            }
            if(param4.visible && param4.pageId > 0 && _loc6_)
            {
               param5[param4] = true;
            }
            return _loc6_;
         }
         catch(e:Error)
         {
            Logger.log("Error when loading nodes by name " + param1 + ":",e);
            var _loc10_:Boolean = false;
         }
         return _loc10_;
      }
      
      private static function includeVisibleSubtree(param1:ICatalogNode, param2:Dictionary) : void
      {
         if(param1.visible && param1.pageId > 0)
         {
            param2[param1] = true;
         }
         for each(var _loc3_ in param1.children)
         {
            includeVisibleSubtree(_loc3_,param2);
         }
      }
      
      private static function isSearchMatch(param1:String, param2:Array, param3:Dictionary, param4:ICatalogNode) : Boolean
      {
         if(param3 != null && param3[param4.pageId])
         {
            return true;
         }
         var _loc5_:String = [param4.pageName,param4.localization].join(" ").toLowerCase();
         _loc5_ = _loc5_.replace(/[\s_\-]+/gi,"");
         if(_loc5_.indexOf(param1) > -1)
         {
            return true;
         }
         for each(var _loc6_ in param2)
         {
            if(_loc5_.indexOf(_loc6_) >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get initialized() : Boolean
      {
         return _index != null;
      }
      
      public function dispose() : void
      {
         if(_index != null)
         {
            _index.dispose();
         }
         _index = null;
         _offersToNodes = null;
         _currentNodes = null;
         _catalog = null;
         _container = null;
         UnknownVarFromCatalogNavigator_IItemListWindow_1 = null;
      }
      
      public function buildCatalogIndex(param1:NodeData) : void
      {
         _index = null;
         _offersToNodes = new Dictionary();
         _index = buildIndexNode(param1,0,null);
      }
      
      public function showIndex() : void
      {
         if(_index == null)
         {
            return;
         }
         UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItems();
         if(UnknownVarFromCatalogNavigator_TopViewSelector_1 != null)
         {
            UnknownVarFromCatalogNavigator_TopViewSelector_1.clearTabs();
         }
         if(!_catalog.useNonTabbedCatalog(UnknownVarFromCatalogNavigator_String_1))
         {
            for each(var _loc1_ in _index.children)
            {
               if(_loc1_.visible)
               {
                  UnknownVarFromCatalogNavigator_TopViewSelector_1.addTabItem(_loc1_);
               }
            }
         }
         else if(UnknownVarFromCatalogNavigator_TopViewSelector_1 == null)
         {
            showNodeContent(_index.children[0]);
         }
         if(UnknownVarFromCatalogNavigator_TopViewSelector_1 != null)
         {
            UnknownVarFromCatalogNavigator_TopViewSelector_1.selectTabByIndex(0);
         }
      }
      
      public function showNodeContent(param1:ICatalogNode) : void
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:ICatalogNode = null;
         var _loc2_:* = false;
         if(_index == null)
         {
            return;
         }
         UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItems();
         if(param1 == null || !param1.visible)
         {
            return;
         }
         if(param1.children.length)
         {
            for each(var _loc6_ in param1.children)
            {
               if(_loc6_.visible)
               {
                  (_loc6_ as CatalogNodeRenderable).addToList(UnknownVarFromCatalogNavigator_IItemListWindow_1);
               }
            }
            _loc3_ = getPathToNodeWithLayout(param1);
            if(_loc3_.length > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc4_ = _loc3_[_loc5_];
                  _loc2_ = _loc5_ == _loc3_.length - 1;
                  if(_loc2_ || _currentNodes.indexOf(_loc4_) == -1)
                  {
                     activateNode(_loc4_);
                  }
                  _loc5_++;
               }
            }
            else
            {
               openCatalogPage(param1);
            }
         }
         else
         {
            openCatalogPage(param1);
         }
      }
      
      private function getPathToNodeWithLayout(param1:ICatalogNode) : Array
      {
         var _loc2_:Array = null;
         for each(var _loc3_ in param1.children)
         {
            if(_loc3_.visible)
            {
               if(_loc3_.pageId > -1)
               {
                  return [_loc3_];
               }
               if(_loc3_.isBranch)
               {
                  _loc2_ = getPathToNodeWithLayout(_loc3_);
                  if(_loc2_.length > 0)
                  {
                     _loc2_.unshift(_loc3_);
                     return _loc2_;
                  }
               }
            }
         }
         return [];
      }
      
      private function openCategoryForNode(param1:ICatalogNode) : ICatalogNode
      {
         var _loc3_:int = 0;
         var _loc2_:ICatalogNode = param1.parent;
         while(_loc2_ != null && _loc2_.parent != null && _loc2_.parent.pageName != "root")
         {
            _loc2_ = _loc2_.parent;
         }
         if(UnknownVarFromCatalogNavigator_TopViewSelector_1 && _loc2_.parent)
         {
            _loc3_ = int(_loc2_.parent.children.indexOf(_loc2_));
            UnknownVarFromCatalogNavigator_TopViewSelector_1.selectTabByIndex(_loc3_);
         }
         showNodeContent(_loc2_);
         return _loc2_;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function activateNode(param1:ICatalogNode) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:* = _currentNodes.indexOf(param1) >= 0;
         var _loc2_:Boolean = param1.isOpen;
         var _loc6_:Vector.<ICatalogNode> = new Vector.<ICatalogNode>(0);
         for each(var _loc4_ in _currentNodes)
         {
            _loc4_.deactivate();
            if(_loc4_.depth < param1.depth)
            {
               _loc6_.push(_loc4_);
            }
            else
            {
               _loc4_.close();
            }
         }
         _currentNodes = _loc6_;
         param1.activate();
         if(_loc8_ && _loc2_)
         {
            param1.close();
         }
         else
         {
            param1.open();
         }
         if(_currentNodes.indexOf(param1) < 0)
         {
            _currentNodes.push(param1);
         }
         if(param1.isBranch)
         {
            if(param1.parent && param1.parent is CatalogNodeRenderable)
            {
               (param1.parent as CatalogNodeRenderable).updateChildListHeight();
            }
            _loc3_ = 0;
            _loc5_ = 0;
            _loc7_ = 0;
            while(_loc7_ < UnknownVarFromCatalogNavigator_IItemListWindow_1.numListItems)
            {
               if(UnknownVarFromCatalogNavigator_IItemListWindow_1.getListItemAt(_loc7_).visible)
               {
                  _loc5_ += UnknownVarFromCatalogNavigator_IItemListWindow_1.getListItemAt(_loc7_).height;
               }
               _loc7_++;
            }
            for each(param1 in _currentNodes)
            {
               _loc3_ += param1.offsetV;
            }
            if(_loc3_ - UnknownVarFromCatalogNavigator_IItemListWindow_1.height > 0)
            {
               UnknownVarFromCatalogNavigator_IItemListWindow_1.scrollV = _loc3_ / _loc5_;
            }
         }
         if(param1.pageId > -1)
         {
            openCatalogPage(param1);
         }
      }
      
      private function openCatalogPage(param1:ICatalogNode) : void
      {
         _catalog.loadCatalogPage(param1.pageId,-1,UnknownVarFromCatalogNavigator_String_1);
         _catalog.events.dispatchEvent(new CatalogPageOpenedEvent(param1.pageId,param1.localization));
      }
      
      public function openPage(param1:String) : void
      {
         var _loc2_:ICatalogNode = getNodeByName(param1);
         if(_loc2_ != null && _loc2_.visible)
         {
            _catalog.loadCatalogPage(_loc2_.pageId,-1,UnknownVarFromCatalogNavigator_String_1);
            openNavigatorAtNode(_loc2_);
         }
         else
         {
            if(_loc2_ != null && !_loc2_.visible)
            {
               _catalog.events.dispatchEvent(new CatalogEvent("CATALOG_INVISIBLE_PAGE_VISITED"));
            }
            loadFrontPage();
         }
      }
      
      public function openPageById(param1:int, param2:int) : void
      {
         var _loc3_:ICatalogNode = null;
         var _loc4_:* = undefined;
         if(!initialized)
         {
            _catalog.openCatalogPageById(param1,param2,UnknownVarFromCatalogNavigator_String_1);
         }
         else
         {
            if(param1 == -12345678)
            {
               _loc4_ = getNodesByOfferId(param2,true);
               if(_loc4_ != null)
               {
                  _loc3_ = _loc4_[0];
               }
            }
            else
            {
               _loc3_ = getNodeById(param1);
            }
            if(_loc3_ != null)
            {
               _catalog.loadCatalogPage(_loc3_.pageId,param2,UnknownVarFromCatalogNavigator_String_1);
               openNavigatorAtNode(_loc3_);
            }
         }
      }
      
      public function openPageByOfferId(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:ICatalogNode = null;
         if(!initialized)
         {
            _catalog.openCatalogPageById(-12345678,param1,UnknownVarFromCatalogNavigator_String_1);
         }
         else
         {
            _loc3_ = getNodesByOfferId(param1);
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_[0];
               _catalog.loadCatalogPage(_loc2_.pageId,param1,UnknownVarFromCatalogNavigator_String_1);
               openNavigatorAtNode(_loc2_);
            }
         }
      }
      
      public function deactivateCurrentNode() : void
      {
         for each(var _loc1_ in _currentNodes)
         {
            _loc1_.deactivate();
            _loc1_.close();
         }
         _currentNodes = new Vector.<ICatalogNode>(0);
      }
      
      public function filter(param1:String, param2:Array, param3:Dictionary = null) : void
      {
         var _loc4_:Dictionary = new Dictionary();
         markSearchNodes(param1,param2,param3,_index,_loc4_);
         deactivateCurrentNode();
         UnknownVarFromCatalogNavigator_IItemListWindow_1.removeListItems();
         addSearchNodesToList(_index,_loc4_,1);
      }
      
      private function openNavigatorAtNode(param1:ICatalogNode) : void
      {
         if(param1 == null)
         {
            return;
         }
         deactivateCurrentNode();
         var _loc2_:ICatalogNode = param1.parent;
         while(_loc2_ != null && _loc2_.parent != null)
         {
            _loc2_.open();
            _loc2_ = _loc2_.parent;
         }
         openCategoryForNode(param1);
         activateNode(param1);
      }
      
      public function loadFrontPage() : void
      {
         if(_index == null)
         {
            return;
         }
         var _loc1_:ICatalogNode = getFirstNavigable(_index);
         if(_loc1_ == null)
         {
            return;
         }
         Logger.log("Load front page: " + _loc1_.localization + "(" + _loc1_.pageId + ")");
         showNodeContent(_loc1_);
      }
      
      private function getFirstNavigable(param1:ICatalogNode) : ICatalogNode
      {
         var _loc2_:ICatalogNode = null;
         if(param1.visible && param1 != _index)
         {
            return param1;
         }
         for each(var _loc3_ in param1.children)
         {
            _loc2_ = getFirstNavigable(_loc3_);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function buildIndexNode(param1:NodeData, param2:int, param3:ICatalogNode) : ICatalogNode
      {
         var _loc4_:ICatalogNode = null;
         var _loc5_:Boolean = param1.visible;
         if(!_loc5_)
         {
            _loc4_ = new CatalogNode(this,param1,param2,param3);
         }
         else
         {
            _loc4_ = new CatalogNodeRenderable(this,param1,param2,param3);
         }
         for each(var _loc6_ in _loc4_.offerIds)
         {
            if(_loc6_ in _offersToNodes)
            {
               _offersToNodes[_loc6_].push(_loc4_);
            }
            else
            {
               _offersToNodes[_loc6_] = new <ICatalogNode>[_loc4_];
            }
         }
         param2++;
         for each(var _loc7_ in param1.children)
         {
            _loc4_.addChild(buildIndexNode(_loc7_,param2,_loc4_));
         }
         return _loc4_;
      }
      
      public function getNodesByOfferId(param1:int, param2:Boolean = false) : Vector.<ICatalogNode>
      {
         var _loc4_:* = undefined;
         if(_offersToNodes != null)
         {
            if(param2)
            {
               _loc4_ = new Vector.<ICatalogNode>(0);
               for each(var _loc3_ in _offersToNodes[param1])
               {
                  if(_loc3_.visible)
                  {
                     _loc4_.push(_loc3_);
                  }
               }
               if(_loc4_.length > 0)
               {
                  return _loc4_;
               }
               return null;
            }
            return _offersToNodes[param1];
         }
         return null;
      }
      
      public function getNodeByName(param1:String) : ICatalogNode
      {
         return _index != null ? getFirstNodeByName(param1,_index) : null;
      }
      
      public function getOptionalNodeByName(param1:String) : ICatalogNode
      {
         return !!_index ? getFirstNodeByName(param1,_index) : null;
      }
      
      public function getNodeById(param1:int, param2:ICatalogNode = null) : ICatalogNode
      {
         if(param2 == null)
         {
            param2 = _index;
         }
         if(param2 == null)
         {
            return null;
         }
         var _loc3_:* = null;
         if(param2.pageId == param1 && param2 != _index)
         {
            _loc3_ = param2;
         }
         else
         {
            for each(var _loc4_ in param2.children)
            {
               _loc3_ = getNodeById(param1,_loc4_);
               if(_loc3_ != null)
               {
                  break;
               }
            }
         }
         return _loc3_;
      }
      
      private function getFirstNodeByName(param1:String, param2:ICatalogNode) : ICatalogNode
      {
         var _loc3_:* = null;
         try
         {
            if(param2.pageName == param1 && param2 != _index)
            {
               _loc3_ = param2;
            }
            else
            {
               for each(var _loc4_ in param2.children)
               {
                  _loc3_ = getFirstNodeByName(param1,_loc4_);
                  if(_loc3_ != null)
                  {
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            Logger.log("Error when loading node by name " + param1 + ":",e);
         }
         return _loc3_;
      }
      
      private function addSearchNodesToList(param1:ICatalogNode, param2:Dictionary, param3:int) : void
      {
         for each(var _loc4_ in param1.children)
         {
            if(_loc4_.visible && param2[_loc4_])
            {
               (_loc4_ as CatalogNodeRenderable).addSearchResultToList(UnknownVarFromCatalogNavigator_IItemListWindow_1,param3 + 1);
               addSearchNodesToList(_loc4_,param2,param3 + 1);
            }
            else
            {
               addSearchNodesToList(_loc4_,param2,param3);
            }
         }
      }
      
      public function get listTemplate() : IWindowModel
      {
         return _listTemplate;
      }
      
      public function get isDeepHierarchy() : Boolean
      {
         return (_catalog as Component).getBoolean("catalog.deep.hierarchy");
      }
      
      public function getItemTemplate(param1:int) : IWindowModel
      {
         if(isDeepHierarchy)
         {
            return param1 > 2 ? UnknownVarFromCatalogNavigator_IWindowModel_2 : UnknownVarFromCatalogNavigator_IWindowModel_1;
         }
         return param1 == 1 ? UnknownVarFromCatalogNavigator_IWindowModel_1 : UnknownVarFromCatalogNavigator_IWindowModel_2;
      }
   }
}

