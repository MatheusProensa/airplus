package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.DeBouncer;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TableView implements IComponentInterfaceQueue
   {
      private static var SKIP_SCROLL_RESIZE:int = 500;
      
      private static var LAZY_CHUNKING:int = 30;
      
      private static var LAZY_CHUNKING_MINIMAL:int = 8;
      
      private static var SCROLL_BUFFER:int = 24;
      
      private static var SCROLL_BUFFER_MINIMAL:int = 2;
      
      private static var TABLE_MARGIN:int = 5;
      
      private static var SCROLLBAR_OFFSET:int = 21;
      
      private var UnknownVarFromTableView_Vector_1:Vector.<TableRowView>;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromTableView_Boolean_1:Boolean;
      
      private var _parent:IWindowController_1;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromTableView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromTableView_UnknownICoreWindowComponents7_1:UnknownICoreWindowComponents7;
      
      private var UnknownVarFromTableView_ITextWindow_1:ITextWindow;
      
      private var _rowTemplate:IItemListWindow;
      
      private var _cellTemplate:CellTemplate;
      
      private var _columns:Vector.<TableColumn>;
      
      private var _rowModels:Vector.<TableRowModel>;
      
      private var UnknownVarFromTableView_Dictionary_1:Dictionary;
      
      private var _canSelect:Boolean;
      
      private var _onRowClickedCallback:Function = null;
      
      private var _onRowSelectedCallback:Function = null;
      
      private var _onRowHoverCallback:Function = null;
      
      private var _onCellEditCallback:Function = null;
      
      private var UnknownVarFromTableView_Boolean_2:Boolean = true;
      
      private var UnknownVarFromTableView_Boolean_3:Boolean = false;
      
      private var UnknownVarFromTableView_TableRowModel_1:TableRowModel = null;
      
      private var UnknownVarFromTableView_TableRowModel_2:TableRowModel = null;
      
      private var _ignoreListeners:Boolean = false;
      
      private var UnknownVarFromTableView_DeBouncer_1:DeBouncer;
      
      private var _forceUpdate:Boolean = false;
      
      private var _minimalResourcesMode:Boolean = false;
      
      private var UnknownVarFromTableView_Boolean_4:Boolean = false;
      
      public function TableView(param1:IHabboWindowManagerComponent, param2:IWindowController_1, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _parent = param2;
         UnknownVarFromTableView_DeBouncer_1 = new DeBouncer(150,300,manageRowViews);
         _minimalResourcesMode = param4;
         _container = param1.buildFromXML(param1.assets.getAssetByName("table_view_xml").content as XML) as IWindowController_1;
         param2.addChild(_container);
         UnknownVarFromTableView_IItemListWindow_1 = _container.findChildByName("table_titlerow") as IItemListWindow;
         UnknownVarFromTableView_UnknownICoreWindowComponents7_1 = _container.findChildByName("splitter") as UnknownICoreWindowComponents7;
         tableContents.removeListItem(UnknownVarFromTableView_IItemListWindow_1);
         tableContents.removeListItem(UnknownVarFromTableView_UnknownICoreWindowComponents7_1);
         UnknownVarFromTableView_ITextWindow_1 = UnknownVarFromTableView_IItemListWindow_1.removeListItemAt(0) as ITextWindow;
         _rowTemplate = tableItems.removeListItemAt(1) as IItemListWindow;
         _cellTemplate = new CellTemplate(_rowTemplate.removeListItemAt(0) as IRegionWindow);
         _container.width = param2.width;
         _container.height = param2.height;
         updateTableItemsHeight();
         resizeHorizontally();
         updateEmptyText();
         if(param3)
         {
            _container.setParamFlag(2048,true);
         }
         tableContents.addEventListener("WE_RESIZED",onTableContentsResized);
         tableItems.findChildByTag("_ITEMLIST").addEventListener("WE_SCROLL",onScrolled);
      }
      
      public function initialize(param1:Vector.<TableColumn>, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(UnknownVarFromTableView_Boolean_1)
         {
            return;
         }
         _canSelect = param3;
         UnknownVarFromTableView_Vector_1 = new Vector.<TableRowView>();
         _rowModels = new Vector.<TableRowModel>();
         UnknownVarFromTableView_Dictionary_1 = new Dictionary();
         UnknownVarFromTableView_Boolean_2 = param2;
         if(param2)
         {
            tableContents.addListItemAt(UnknownVarFromTableView_IItemListWindow_1,0);
            tableContents.addListItemAt(UnknownVarFromTableView_UnknownICoreWindowComponents7_1,1);
         }
         else
         {
            updateTableItemsHeight();
            updateEmptyText();
         }
         initializeColumns(param1);
         UnknownVarFromTableView_Boolean_1 = true;
      }
      
      private function updateTableItemsHeight() : void
      {
         tableItems.height = tableContents.height - (UnknownVarFromTableView_Boolean_2 ? UnknownVarFromTableView_IItemListWindow_1.height + UnknownVarFromTableView_UnknownICoreWindowComponents7_1.height : 0);
         onScrollBarVisibilityMayHaveChanged();
      }
      
      private function updateEmptyText() : void
      {
         if(UnknownVarFromTableView_Boolean_2)
         {
            emptyTextContainer.y = UnknownVarFromTableView_IItemListWindow_1.height + UnknownVarFromTableView_UnknownICoreWindowComponents7_1.height;
            emptyTextContainer.height = tableContents.height - emptyTextContainer.y;
         }
         else
         {
            emptyTextContainer.y = 0;
            emptyTextContainer.height = tableContents.height;
         }
         emptyTextContainer.visible = _rowModels == null || _rowModels.length == 0;
      }
      
      private function onTableContentsResized(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         updateTableItemsHeight();
         manageRowViewsWithDebounce();
      }
      
      private function onScrolled(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         manageRowViewsWithDebounce();
      }
      
      private function initializeColumns(param1:Vector.<TableColumn>) : void
      {
         var _loc3_:ITextWindow = null;
         var _loc2_:int = 0;
         _columns = param1;
         for each(var _loc4_ in param1)
         {
            _loc3_ = UnknownVarFromTableView_ITextWindow_1.clone() as ITextWindow;
            _loc3_.text = _loc4_.columnName;
            _loc2_ = getCellWidth(_loc4_.id);
            _loc3_.width = _loc2_;
            _loc3_.autoSize = _loc4_.alignment;
            UnknownVarFromTableView_IItemListWindow_1.addListItem(_loc3_);
         }
      }
      
      public function setObjects(param1:Vector.<ITableObject>, param2:Boolean = false) : void
      {
         var _loc13_:ITableObject = null;
         var _loc6_:int = 0;
         var _loc9_:TableRowModel = null;
         var _loc12_:TableRowModel = null;
         if(!UnknownVarFromTableView_Boolean_1)
         {
            return;
         }
         if(param1.length == 0)
         {
            clear();
            return;
         }
         _ignoreListeners = true;
         var _loc7_:int = int(_rowModels.length);
         var _loc8_:Boolean = false;
         var _loc11_:Dictionary = new Dictionary();
         var _loc3_:Vector.<TableRowModel> = new Vector.<TableRowModel>();
         for each(_loc13_ in param1)
         {
            _loc9_ = getRowForObject(_loc13_);
            if(_loc9_ != null)
            {
               _loc9_.update(_loc13_);
               _loc11_[_loc9_] = true;
               _loc3_.push(_loc9_);
            }
            else
            {
               _loc3_.push(null);
            }
         }
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         for each(var _loc10_ in _rowModels)
         {
            if(!(_loc10_ in _loc11_))
            {
               if(UnknownVarFromTableView_TableRowModel_1 == _loc10_)
               {
                  UnknownVarFromTableView_TableRowModel_1 = null;
                  _loc4_ = true;
               }
               if(UnknownVarFromTableView_TableRowModel_2 == _loc10_)
               {
                  UnknownVarFromTableView_TableRowModel_2 = null;
                  _loc5_ = true;
               }
               if(_loc10_.view != null)
               {
                  recycleRowView(_loc10_.view);
                  _loc10_.view = null;
                  _forceUpdate = true;
               }
               _loc8_ = true;
               _loc10_.dispose();
            }
         }
         UnknownVarFromTableView_Dictionary_1 = new Dictionary();
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc13_ = param1[_loc6_];
            _loc12_ = _loc3_[_loc6_];
            if(_loc12_ == null)
            {
               _loc12_ = new TableRowModel(_loc13_,_loc6_);
               _loc3_[_loc6_] = _loc12_;
               _loc8_ = true;
            }
            UnknownVarFromTableView_Dictionary_1[_loc13_.identifier] = _loc12_;
            if(_loc12_.i != _loc6_)
            {
               _loc8_ = true;
            }
            _loc6_ += 1;
         }
         _rowModels = _loc3_;
         _ignoreListeners = false;
         UnknownVarFromTableView_Boolean_4 ||= param2;
         if(_loc8_)
         {
            _loc6_ = 0;
            while(_loc6_ < _rowModels.length)
            {
               _rowModels[_loc6_].index = _loc6_;
               _loc6_ += 1;
            }
         }
         if(_loc8_ || UnknownVarFromTableView_Boolean_4)
         {
            manageRowViewsWithDebounce();
         }
         if(_loc7_ != _rowModels.length)
         {
            itemListAmountChanged();
         }
         if(_loc4_ && _onRowSelectedCallback != null)
         {
            _onRowSelectedCallback(null);
         }
         if(_loc5_ && _onRowHoverCallback != null)
         {
            _onRowHoverCallback(null);
         }
      }
      
      public function manageRowViewsWithDebounce() : void
      {
         if(manageRowViews(true))
         {
            UnknownVarFromTableView_DeBouncer_1.trigger();
         }
      }
      
      private function manageRowViews(param1:Boolean = false) : Boolean
      {
         var _loc10_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         if(!param1 && UnknownVarFromTableView_Boolean_4)
         {
            tableItems.scrollV = 0;
            UnknownVarFromTableView_Boolean_4 = false;
            _forceUpdate = true;
         }
         var _loc9_:IWindowModel = tableItems.getListItemAt(0);
         var _loc5_:IWindowModel = tableItems.getListItemAt(tableItems.numListItems - 1);
         var _loc7_:int = visibleRangeFirstIndex;
         var _loc13_:int = visibleRangeLastIndex;
         var _loc15_:int = int(_rowTemplate.height);
         var _loc8_:Vector.<IWindowModel> = new Vector.<IWindowModel>();
         _loc8_.push(_loc9_);
         var _loc2_:int = _loc7_ * _loc15_;
         var _loc6_:int = Math.max(0,_rowModels.length - 1 - _loc13_) * _loc15_;
         var _loc3_:Boolean = _forceUpdate || _rowModels.length < SKIP_SCROLL_RESIZE && (_loc2_ != _loc9_.height || _loc6_ != _loc5_.height);
         if(_loc3_ && param1)
         {
            return true;
         }
         for each(var _loc14_ in _rowModels)
         {
            if(shouldBeVisible(_loc14_,_loc7_,_loc13_))
            {
               if(_loc14_.view == null)
               {
                  if(!param1)
                  {
                     _loc14_.view = createOrReuseTableRowView(_loc14_);
                  }
                  _loc3_ = true;
               }
               if(!param1)
               {
                  _loc8_.push(_loc14_.view.container);
               }
            }
            else if(_loc14_.view != null)
            {
               if(!param1)
               {
                  recycleRowView(_loc14_.view);
                  _loc14_.view = null;
               }
               _loc3_ = true;
            }
         }
         if(param1)
         {
            return _loc3_ || UnknownVarFromTableView_Boolean_4;
         }
         _loc8_.push(_loc5_);
         _forceUpdate = false;
         _ignoreListeners = true;
         if(_loc3_)
         {
            tableItems.autoArrangeItems = false;
            _loc10_ = Number(tableItems.scrollableRegion.height);
            _loc4_ = Number(tableItems.visibleRegion.y);
            _loc11_ = Number(tableItems.scrollV);
            tableItems.removeListItems();
            _loc9_.height = _loc2_;
            _loc5_.height = _loc6_;
            _loc12_ = 0;
            for each(var _loc16_ in _loc8_)
            {
               _loc16_.y = _loc12_;
               tableItems.addListItem(_loc16_);
               _loc12_ += _loc16_.height;
            }
            if(_loc12_ != _loc10_)
            {
               if(_loc12_ > tableItems.height)
               {
                  tableItems.scrollV = _loc4_ / (_loc12_ - tableItems.height);
               }
               else
               {
                  _loc5_.width = rowWidth;
                  tableItems.scrollV = 0;
               }
            }
            else
            {
               tableItems.scrollV = _loc11_;
            }
            tableItems.autoArrangeItems = true;
            onScrollBarVisibilityMayHaveChanged();
         }
         _ignoreListeners = false;
         return _loc3_;
      }
      
      public function scrollToTop() : void
      {
         tableItems.scrollV = 0;
      }
      
      private function shouldBeVisible(param1:TableRowModel, param2:int, param3:int) : Boolean
      {
         return param1.i >= param2 && param1.i <= param3;
      }
      
      private function get visibleRangeFirstIndex() : int
      {
         if(_container == null)
         {
            return 0;
         }
         var _loc5_:int = int(_rowTemplate.height);
         var _loc3_:Rectangle = tableItems.visibleRegion;
         var _loc2_:int = _loc3_.y;
         var _loc4_:int = _loc2_ / _loc5_;
         var _loc1_:int = Math.min(_loc4_ - 1,_rowModels.length - tableItems.height / _loc5_);
         _loc1_ -= scrollBuffer + _loc1_ % lazyChunking;
         return Math.max(0,_loc1_);
      }
      
      private function get visibleRangeLastIndex() : int
      {
         if(_container == null)
         {
            return 0;
         }
         var _loc5_:int = int(_rowTemplate.height);
         var _loc4_:Rectangle = tableItems.visibleRegion;
         var _loc3_:int = _loc4_.y + _loc4_.height;
         var _loc2_:int = _loc3_ / _loc5_;
         var _loc1_:int = Math.min(_loc2_ + 1,_rowModels.length - 1);
         return int(_loc1_ + (scrollBuffer + lazyChunking - _loc1_ % lazyChunking));
      }
      
      private function get lazyChunking() : int
      {
         return _minimalResourcesMode ? LAZY_CHUNKING_MINIMAL : LAZY_CHUNKING;
      }
      
      private function get scrollBuffer() : int
      {
         return _minimalResourcesMode ? SCROLL_BUFFER : SCROLL_BUFFER_MINIMAL;
      }
      
      public function clear() : void
      {
         if(!UnknownVarFromTableView_Boolean_1)
         {
            return;
         }
         _ignoreListeners = true;
         var _loc2_:IWindowModel = tableItems.getListItemAt(0);
         var _loc3_:IWindowModel = tableItems.getListItemAt(tableItems.numListItems - 1);
         tableItems.removeListItems();
         _loc2_.height = 0;
         _loc3_.height = 0;
         tableItems.addListItem(_loc2_);
         tableItems.addListItem(_loc3_);
         _ignoreListeners = false;
         for each(var _loc1_ in _rowModels)
         {
            if(_loc1_.view != null)
            {
               recycleRowView(_loc1_.view);
               _loc1_.view = null;
            }
            _loc1_.dispose();
         }
         _rowModels = new Vector.<TableRowModel>();
         UnknownVarFromTableView_Dictionary_1 = new Dictionary();
         if(UnknownVarFromTableView_TableRowModel_1 != null)
         {
            UnknownVarFromTableView_TableRowModel_1 = null;
            if(_onRowSelectedCallback != null)
            {
               _onRowSelectedCallback(null);
            }
         }
         if(UnknownVarFromTableView_TableRowModel_2 != null)
         {
            UnknownVarFromTableView_TableRowModel_2 = null;
            if(_onRowHoverCallback != null)
            {
               _onRowHoverCallback(null);
            }
         }
         itemListAmountChanged();
      }
      
      public function resetScrollingNextUpdate() : void
      {
         UnknownVarFromTableView_Boolean_4 = true;
      }
      
      private function recycleRowView(param1:TableRowView) : void
      {
         param1.recycle();
         UnknownVarFromTableView_Vector_1.push(param1);
      }
      
      private function createOrReuseTableRowView(param1:TableRowModel) : TableRowView
      {
         var _loc2_:TableRowView = null;
         if(UnknownVarFromTableView_Vector_1.length > 0)
         {
            _loc2_ = UnknownVarFromTableView_Vector_1.pop();
            _loc2_.reuse(param1);
            _loc2_.updateWidth();
         }
         else
         {
            _loc2_ = new TableRowView(this,param1);
         }
         return _loc2_;
      }
      
      private function itemListAmountChanged() : void
      {
         onScrollBarVisibilityMayHaveChanged();
         updateEmptyText();
      }
      
      private function onScrollBarVisibilityMayHaveChanged() : void
      {
         var _loc1_:Boolean = UnknownVarFromTableView_Boolean_3;
         UnknownVarFromTableView_Boolean_3 = tableItems.isScrollBarVisible;
         if(_loc1_ != UnknownVarFromTableView_Boolean_3)
         {
            resizeHorizontally();
         }
      }
      
      public function resizeHorizontally() : void
      {
         var _loc3_:int = 0;
         var _loc4_:ITextWindow = null;
         _container.width = _parent.width;
         UnknownVarFromTableView_IItemListWindow_1.width = rowWidth;
         UnknownVarFromTableView_UnknownICoreWindowComponents7_1.width = rowWidth;
         var _loc2_:int = UnknownVarFromTableView_IItemListWindow_1.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = UnknownVarFromTableView_IItemListWindow_1.getListItemAt(_loc3_) as ITextWindow;
            _loc4_.width = getCellWidth(_columns[_loc3_].id);
            _loc3_++;
         }
         for each(var _loc1_ in _rowModels)
         {
            if(_loc1_.view != null)
            {
               _loc1_.view.updateWidth();
            }
         }
      }
      
      public function getColumnById(param1:String) : TableColumn
      {
         for each(var _loc2_ in _columns)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getRowForObject(param1:ITableObject) : TableRowModel
      {
         return UnknownVarFromTableView_Dictionary_1[param1.identifier];
      }
      
      public function getIndexOfObject(param1:ITableObject) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc2_:TableRowModel = getRowForObject(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.i;
      }
      
      public function getObjectByIndex(param1:int) : ITableObject
      {
         if(param1 < 0 || param1 >= _rowModels.length)
         {
            return null;
         }
         return _rowModels[param1].object;
      }
      
      public function trySelect(param1:ITableObject, param2:Boolean = false) : void
      {
         var _loc4_:TableRowModel = null;
         if(_onRowClickedCallback && param2)
         {
            _onRowClickedCallback(param1);
         }
         if(!_canSelect)
         {
            return;
         }
         if(UnknownVarFromTableView_TableRowModel_1 != null && param1 != null && UnknownVarFromTableView_TableRowModel_1.object == param1)
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(UnknownVarFromTableView_TableRowModel_1 != null)
         {
            UnknownVarFromTableView_TableRowModel_1.selected = false;
            UnknownVarFromTableView_TableRowModel_1 = null;
            _loc3_ = true;
         }
         if(param1 != null)
         {
            _loc4_ = getRowForObject(param1);
            if(_loc4_ != null)
            {
               _loc4_.selected = true;
               UnknownVarFromTableView_TableRowModel_1 = _loc4_;
               _loc3_ = true;
            }
         }
         if(_loc3_ && _onRowSelectedCallback != null)
         {
            _onRowSelectedCallback(UnknownVarFromTableView_TableRowModel_1?.object);
         }
      }
      
      internal function onHover(param1:ITableObject) : void
      {
         var _loc3_:TableRowModel = null;
         if(UnknownVarFromTableView_TableRowModel_2 != null && param1 != null && UnknownVarFromTableView_TableRowModel_2.object == param1)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(UnknownVarFromTableView_TableRowModel_2 != null)
         {
            UnknownVarFromTableView_TableRowModel_2.hovered = false;
            UnknownVarFromTableView_TableRowModel_2 = null;
            _loc2_ = true;
         }
         if(param1 != null)
         {
            _loc3_ = getRowForObject(param1);
            if(_loc3_ != null)
            {
               _loc3_.hovered = true;
               UnknownVarFromTableView_TableRowModel_2 = _loc3_;
               _loc2_ = true;
            }
         }
         if(_loc2_ && _onRowHoverCallback != null)
         {
            _onRowHoverCallback(UnknownVarFromTableView_TableRowModel_2?.object);
         }
      }
      
      public function getGlobalRowRectangle(param1:ITableObject) : Rectangle
      {
         var _loc3_:TableRowModel = getRowForObject(param1);
         if(_loc3_ == null || _loc3_.view == null)
         {
            return null;
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc3_.view.container.getGlobalRectangle(_loc2_);
         return _loc2_;
      }
      
      public function get selected() : ITableObject
      {
         if(UnknownVarFromTableView_TableRowModel_1 == null)
         {
            return null;
         }
         return UnknownVarFromTableView_TableRowModel_1.object;
      }
      
      public function get size() : int
      {
         return _rowModels.length;
      }
      
      internal function onEnterNewCellValue(param1:String, param2:ITableObject, param3:String) : void
      {
         if(_onCellEditCallback != null)
         {
            _onCellEditCallback(param2,param3,param1);
         }
      }
      
      public function get rowWidth() : int
      {
         return tableContents.width - (UnknownVarFromTableView_Boolean_3 ? SCROLLBAR_OFFSET : 0);
      }
      
      public function getCellWidth(param1:String) : int
      {
         return rowWidth * getColumnById(param1).widthFactor;
      }
      
      public function get columns() : Vector.<TableColumn>
      {
         return _columns;
      }
      
      public function get rowTemplate() : IItemListWindow
      {
         return _rowTemplate;
      }
      
      public function get cellTemplate() : CellTemplate
      {
         return _cellTemplate;
      }
      
      public function set onRowSelectedCallback(param1:Function) : void
      {
         _onRowSelectedCallback = param1;
      }
      
      public function set onRowClickedCallback(param1:Function) : void
      {
         _onRowClickedCallback = param1;
      }
      
      public function set onRowHoveredCallback(param1:Function) : void
      {
         _onRowHoverCallback = param1;
      }
      
      public function set onCellEditCallback(param1:Function) : void
      {
         _onCellEditCallback = param1;
      }
      
      public function get rowCount() : int
      {
         return _rowModels.length;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromTableView_DeBouncer_1.dispose();
         UnknownVarFromTableView_DeBouncer_1 = null;
         clear();
         UnknownVarFromTableView_Boolean_1 = false;
         _container.dispose();
         _container = null;
         _parent = null;
         UnknownVarFromTableView_IItemListWindow_1 = null;
         UnknownVarFromTableView_UnknownICoreWindowComponents7_1 = null;
         UnknownVarFromTableView_ITextWindow_1.dispose();
         UnknownVarFromTableView_ITextWindow_1 = null;
         _rowTemplate.dispose();
         _rowTemplate = null;
         _columns = null;
         _onRowHoverCallback = null;
         _onRowSelectedCallback = null;
         _onRowClickedCallback = null;
         _onCellEditCallback = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get border() : UnknownICoreWindowComponents6
      {
         return _container.findChildByName("table_border") as UnknownICoreWindowComponents6;
      }
      
      private function get tableContents() : IItemListWindow
      {
         return _container.findChildByName("table_contents") as IItemListWindow;
      }
      
      private function get tableItems() : IScrollableListWindow
      {
         return _container.findChildByName("table_items") as IScrollableListWindow;
      }
      
      private function get emptyTextContainer() : IWindowController_1
      {
         return _container.findChildByName("empty_container") as IWindowController_1;
      }
   }
}

