package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public class CatalogViewer implements ICatalogViewer
   {
      private var _catalog:HabboCatalog;
      
      private var _container:IWindowController_1;
      
      private var _catalogType:String;
      
      private var _currentPage:ICatalogPage;
      
      private var _forceRefresh:Boolean;
      
      private var _previousPageId:int;
      
      public function CatalogViewer(param1:HabboCatalog, param2:IWindowController_1, param3:String)
      {
         super();
         _catalog = param1;
         _container = param2;
         _catalogType = param3;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      public function dispose() : void
      {
         if(_currentPage)
         {
            _currentPage.dispose();
            _currentPage = null;
         }
         _catalog = null;
         _container = null;
         _catalogType = null;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get catalogType() : String
      {
         return _catalogType;
      }
      
      public function get mainContainer() : IWindowController_1
      {
         return _container == null ? null : _container.parent as IWindowController_1;
      }
      
      public function showCatalogPage(param1:int, param2:String, param3:IPageLocalization, param4:Vector.<UnknownIHabboCatalog1>, param5:int, param6:Boolean) : void
      {
         Logger.log("[Catalog Viewer] Show Catalog Page: " + [param1,param2,param4.length,param5]);
         if(_currentPage != null)
         {
            if(!_forceRefresh && _currentPage.pageId == param1)
            {
               if(param5 > -1)
               {
                  _currentPage.selectOffer(param5);
               }
               return;
            }
            disposeCurrentPage();
         }
         var _loc7_:ICatalogPage;
         _currentPage = _loc7_ = new CatalogPage(this,param1,param2,param3,param4,_catalog,param6);
         _previousPageId = param1 > -12345678 ? param1 : _previousPageId;
         if(_loc7_.window != null)
         {
            _container.addChild(_loc7_.window);
            _loc7_.window.height = _container.height;
            _container.width = _loc7_.window.width;
            _container.x = _container.parent.width - _container.width - 8;
            setLeftPaneVisibility(_container.x >= 130);
         }
         else
         {
            Logger.log("[CatalogViewer] No window for page: " + param2);
         }
         _container.visible = true;
         _forceRefresh = false;
         _loc7_.selectOffer(param5);
      }
      
      public function disposeCurrentPage() : void
      {
         if(_currentPage != null)
         {
            _container.removeChild(_currentPage.window);
            _currentPage.dispose();
            _container.invalidate();
         }
      }
      
      public function catalogWindowClosed() : void
      {
         if(_currentPage != null)
         {
            _currentPage.closed();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         return _currentPage.dispatchWidgetEvent(param1);
      }
      
      public function getCurrentLayoutCode() : String
      {
         if(_currentPage == null)
         {
            return "";
         }
         return _currentPage.layoutCode;
      }
      
      public function get currentPage() : ICatalogPage
      {
         return _currentPage;
      }
      
      public function showSearchResults(param1:Vector.<UnknownIHabboCatalog1>) : void
      {
         if(_currentPage != null)
         {
            _container.removeChild(_currentPage.window);
            _currentPage.dispose();
         }
         var _loc2_:ICatalogPage = new CatalogPage(this,-1,"default_3x3",new PageLocalization(["catalog_header_roombuilder","credits_v3_teaser"],["${catalog.search.results}"]),param1,_catalog,false,1);
         _currentPage = _loc2_;
         if(_loc2_.window != null)
         {
            _container.addChild(_loc2_.window);
            _loc2_.window.width = _container.width;
            _loc2_.window.height = _container.height;
         }
         else
         {
            Logger.log("[CatalogViewer] No window for page: <SEARCH>");
         }
         _container.visible = true;
      }
      
      public function get viewerTags() : Array
      {
         return !!_container ? _container.tags : [];
      }
      
      public function setForceRefresh() : void
      {
         _forceRefresh = true;
      }
      
      public function get previousPageId() : int
      {
         return _previousPageId;
      }
      
      private function setLeftPaneVisibility(param1:Boolean) : void
      {
         var _loc2_:IWindowController_1 = mainContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IWindowController_1 = _loc2_.findChildByName("navigationContainer") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc3_.visible = param1;
         }
         _loc3_ = _loc2_.findChildByName("searchContainer") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc3_.visible = param1;
         }
      }
   }
}

