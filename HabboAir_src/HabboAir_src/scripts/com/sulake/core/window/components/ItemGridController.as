package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.ItemGridIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class ItemGridController extends ItemListController implements IItemGridWindow
   {
      private var _containerResizeToColumns:Boolean = false;
      
      private var UnknownVarFromItemGridController_Boolean_1:Boolean = false;
      
      private var UnknownVarFromItemGridController_Int_1:int;
      
      private var _shouldRebuildGridOnResize:Boolean = true;
      
      private var _isGridRebuilding:Boolean = false;
      
      public function ItemGridController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _isScrollHorizontal = param2 != 54;
         _scaleToFitItems = true;
         if(!_isScrollHorizontal)
         {
            throw new Error("Horizontal item grid not yet implemented!");
         }
      }
      
      override public function set spacing(param1:int) : void
      {
         var _loc2_:uint = uint(numListItems);
         if(UnknownVarFromItemGridController_Boolean_1 == false)
         {
            while(_loc2_-- > 0)
            {
               IItemListWindow(getListItemAt(_loc2_)).spacing = param1;
            }
         }
         super.spacing = param1;
      }
      
      override public function set background(param1:Boolean) : void
      {
         var _loc2_:* = 0;
         super.background = param1;
         _loc2_ = 0;
         while(_loc2_ < numListItems)
         {
            getListItemAt(_loc2_).background = param1;
            _loc2_++;
         }
      }
      
      override public function set color(param1:uint) : void
      {
         var _loc2_:* = 0;
         super.color = param1;
         _loc2_ = 0;
         while(_loc2_ < numListItems)
         {
            getListItemAt(_loc2_).color = param1;
            _loc2_++;
         }
      }
      
      override public function set autoArrangeItems(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         super.autoArrangeItems = param1;
         _loc2_ = 0;
         while(_loc2_ < numColumns)
         {
            IItemListWindow(getListItemAt(_loc2_)).autoArrangeItems = param1;
            _loc2_++;
         }
      }
      
      public function get shouldRebuildGridOnResize() : Boolean
      {
         return _shouldRebuildGridOnResize;
      }
      
      public function set shouldRebuildGridOnResize(param1:Boolean) : void
      {
         _shouldRebuildGridOnResize = param1;
      }
      
      public function set verticalSpacing(param1:int) : void
      {
         UnknownVarFromItemGridController_Int_1 = param1;
         UnknownVarFromItemGridController_Boolean_1 = true;
         var _loc2_:uint = uint(numListItems);
         while(_loc2_-- > 0)
         {
            IItemListWindow(getListItemAt(_loc2_)).spacing = param1;
         }
      }
      
      override public function get iterator() : IIterator
      {
         return new ItemGridIterator(this);
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case "WE_RESIZED":
               if(_shouldRebuildGridOnResize)
               {
                  rebuildGridStructure();
               }
               break;
            case "WME_WHEEL":
            case "WME_WHEEL_HORIZONTAL":
               scrollWithWheel(getScrollWheelDelta(WindowMouseEvent(param2)) * 0.5,param2.type == "WME_WHEEL_HORIZONTAL" || Boolean(WindowMouseEvent(param2).shiftKey));
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      override protected function get isScrollHorizontal() : Boolean
      {
         return !_isScrollHorizontal;
      }
      
      public function get numGridItems() : uint
      {
         var _loc1_:uint = uint(numListItems);
         var _loc2_:uint = 0;
         while(_loc1_-- > 0)
         {
            _loc2_ += IItemListWindow(getListItemAt(_loc1_)).numListItems;
         }
         return _loc2_;
      }
      
      public function get numColumns() : uint
      {
         return numListItems;
      }
      
      public function get numRows() : uint
      {
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         var _loc1_:uint = numColumns;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = Math.max(_loc3_,IItemListWindow(getListItemAt(_loc2_)).numListItems);
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function addGridItem(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:IItemListWindow = resolveColumnForNextItem(param1);
         return param1;
      }
      
      public function addGridItemAt(param1:IWindowModel, param2:uint) : IWindowModel
      {
         offsetGridItemsForwards(param1,Math.min(numGridItems,param2));
         return param1;
      }
      
      public function getGridItemAt(param1:uint) : IWindowModel
      {
         var _loc2_:IItemListWindow = resolveColumnByIndex(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.getListItemAt(param1 / numColumns);
      }
      
      public function getGridItemByID(param1:uint) : IWindowModel
      {
         var _loc4_:IItemListWindow = null;
         var _loc2_:IWindowModel = null;
         var _loc5_:* = 0;
         var _loc3_:uint = numColumns;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = getListItemAt(_loc5_) as IItemListWindow;
            _loc2_ = _loc4_.getListItemByID(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getGridItemByName(param1:String) : IWindowModel
      {
         var _loc4_:IItemListWindow = null;
         var _loc2_:IWindowModel = null;
         var _loc5_:* = 0;
         var _loc3_:uint = numColumns;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = getListItemAt(_loc5_) as IItemListWindow;
            _loc2_ = _loc4_.getListItemByName(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getGridItemByTag(param1:String) : IWindowModel
      {
         var _loc4_:IItemListWindow = null;
         var _loc2_:IWindowModel = null;
         var _loc5_:* = 0;
         var _loc3_:uint = numColumns;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = getChildAt(_loc5_) as IItemListWindow;
            _loc2_ = _loc4_.getListItemByTag(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getGridItemIndex(param1:IWindowModel) : int
      {
         var _loc2_:IItemListWindow = resolveColumnByItem(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.getListItemIndex(param1) * numColumns + getColumnIndex(_loc2_);
      }
      
      public function removeGridItem(param1:IWindowModel) : IWindowModel
      {
         var _loc3_:int = getGridItemIndex(param1);
         if(_loc3_ == -1)
         {
            return null;
         }
         if(offsetGridItemsBackwards(_loc3_) != param1)
         {
            throw new Error("Item grid is out of order!");
         }
         var _loc2_:IItemListWindow = resolveColumnByIndex(_loc3_);
         if(!_isScrollHorizontal)
         {
            _loc2_.width = _loc2_.scrollableRegion.width;
         }
         else
         {
            _loc2_.height = _loc2_.scrollableRegion.height;
         }
         return param1;
      }
      
      public function removeGridItemAt(param1:int) : IWindowModel
      {
         return removeGridItem(getGridItemAt(param1));
      }
      
      public function setGridItemIndex(param1:IWindowModel, param2:int) : void
      {
         if(removeGridItem(param1) == null)
         {
            throw new Error("Item not found in grid!");
         }
         addListItemAt(param1,param2);
      }
      
      public function swapGridItems(param1:IWindowModel, param2:IWindowModel) : void
      {
         throw new Error("ItemGridWindow / Unimplemented method!");
      }
      
      public function swapGridItemsAt(param1:int, param2:int) : void
      {
         swapGridItems(getGridItemAt(param1),getGridItemAt(param2));
      }
      
      public function removeGridItems() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc3_:* = 0;
         var _loc1_:uint = numColumns;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = IItemListWindow(getListItemAt(_loc3_));
            _loc2_.removeListItems();
            if(!_isScrollHorizontal)
            {
               _loc2_.width = 0;
            }
            else
            {
               _loc2_.height = 0;
            }
            _loc3_++;
         }
      }
      
      public function destroyGridItems() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc3_:* = 0;
         var _loc1_:uint = numColumns;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = IItemListWindow(getListItemAt(_loc3_));
            _loc2_.destroyListItems();
            if(!_isScrollHorizontal)
            {
               _loc2_.width = 0;
            }
            else
            {
               _loc2_.height = 0;
            }
            _loc3_++;
         }
         destroyListItems();
      }
      
      protected function listEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
      }
      
      protected function listItemEventHandler(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = null;
         if(param1.type == "WE_DESTROYED")
         {
            _loc2_ = param1.target as IWindowModel;
            removeGridItem(_loc2_);
         }
      }
      
      protected function getColumnIndex(param1:IItemListWindow) : int
      {
         return getListItemIndex(param1);
      }
      
      protected function resolveColumnByIndex(param1:uint) : IItemListWindow
      {
         return getListItemAt(param1 % numColumns) as IItemListWindow;
      }
      
      public function getColumnNumberByItemIndex(param1:uint) : uint
      {
         return param1 % numColumns;
      }
      
      public function getRowNumberByItemIndex(param1:uint) : uint
      {
         return param1 / numColumns;
      }
      
      override public function populate(param1:Array) : void
      {
         var _loc7_:IItemListWindow = null;
         var _loc9_:IItemListWindow = null;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc2_:Boolean = autoArrangeItems;
         autoArrangeItems = false;
         var _loc10_:int = int(numGridItems);
         var _loc6_:int = int(numColumns);
         var _loc3_:Array = [];
         for each(var _loc4_ in param1)
         {
            if(_loc6_ == 0)
            {
               addColumnForItem(_loc4_);
               _loc6_++;
            }
            else
            {
               if(_loc10_ > 0)
               {
                  _loc9_ = resolveColumnByIndex(_loc10_ > 0 ? _loc10_ - 1 : 0);
                  _loc8_ = getListItemIndex(_loc9_);
                  _loc5_ = _loc8_ > -1 ? _loc8_ == _loc6_ - 1 : true;
                  if(_loc5_)
                  {
                     if(_loc9_.numListItems == 1)
                     {
                        if(_loc9_.right + _loc4_.width <= _width)
                        {
                           addColumnForItem(_loc4_);
                           continue;
                        }
                     }
                  }
                  _loc7_ = getListItemAt(_loc5_ ? 0 : _loc8_ + 1) as IItemListWindow;
               }
               else
               {
                  _loc7_ = getListItemAt(0) as IItemListWindow;
               }
               _loc7_.addListItem(_loc4_);
               _loc10_++;
               if(_loc4_.width > _loc7_.width)
               {
                  _loc7_.width = _loc4_.width;
               }
               if(_loc4_.bottom > _loc7_.height)
               {
                  _loc7_.height = _loc4_.bottom;
               }
            }
         }
         autoArrangeItems = _loc2_;
      }
      
      protected function resolveColumnByItem(param1:IWindowModel) : IItemListWindow
      {
         var _loc3_:IItemListWindow = null;
         var _loc2_:uint = numColumns;
         while(_loc2_-- > 0)
         {
            _loc3_ = IItemListWindow(getListItemAt(_loc2_));
            if(_loc3_.getListItemIndex(param1) > -1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      protected function resolveColumnForNextItem(param1:IWindowModel) : IItemListWindow
      {
         var _loc3_:IItemListWindow = null;
         var _loc6_:IItemListWindow = null;
         if(numColumns == 0)
         {
            return addColumnForItem(param1);
         }
         var _loc5_:uint = numGridItems;
         if(_loc5_ > 0)
         {
            _loc6_ = resolveColumnByIndex(_loc5_ > 0 ? _loc5_ - 1 : 0);
            var _loc4_:int = getListItemIndex(_loc6_);
            var _loc2_:Boolean = _loc4_ > -1 ? _loc4_ == numColumns - 1 : true;
            if(_loc2_)
            {
               if(_loc6_.numListItems == 1)
               {
                  if(_loc6_.right + param1.width <= _width)
                  {
                     return addColumnForItem(param1);
                  }
               }
            }
            _loc3_ = getListItemAt(_loc2_ ? 0 : _loc4_ + 1) as IItemListWindow;
         }
         else
         {
            _loc3_ = getListItemAt(0) as IItemListWindow;
         }
         _loc3_.addListItem(param1);
         if(param1.width > _loc3_.width)
         {
            _loc3_.width = param1.width;
         }
         if(param1.bottom > _loc3_.height)
         {
            _loc3_.height = param1.bottom;
         }
         return _loc3_;
      }
      
      protected function addColumnForItem(param1:IWindowModel) : IItemListWindow
      {
         var _loc2_:IItemListWindow = _context.create(_name + "_COLUMN_" + numListItems,null,50,0,0x10 | 0,new Rectangle(0,0,Math.max(param1.width,0),Math.max(param1.height,0)),listEventProc,null,numListItems,null,"",["_INTERNAL","_EXCLUDE"]) as IItemListWindow;
         _loc2_.isPartOfGridWindow = true;
         _loc2_.background = background;
         _loc2_.color = color;
         _loc2_.spacing = UnknownVarFromItemGridController_Boolean_1 ? UnknownVarFromItemGridController_Int_1 : _spacing;
         addListItem(_loc2_);
         _loc2_.addListItem(param1);
         return _loc2_;
      }
      
      protected function removeColumnAt(param1:uint) : void
      {
         var _loc2_:IItemListWindow = removeChildAt(param1) as IItemListWindow;
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function offsetGridItemsForwards(param1:IWindowModel, param2:uint) : void
      {
         var _loc6_:IItemListWindow = null;
         var _loc3_:IWindowModel = null;
         var _loc9_:* = 0;
         var _loc5_:* = 0;
         var _loc8_:int = 0;
         _loc5_ = numGridItems;
         var _loc7_:int = _loc5_ - 1;
         var _loc4_:uint = numColumns;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            IItemListWindow(getListItemAt(_loc8_)).autoArrangeItems = false;
            _loc8_++;
         }
         if(_loc5_ <= param2)
         {
            resolveColumnForNextItem(param1);
         }
         else
         {
            if(numRows == 1)
            {
               _loc3_ = getGridItemAt(_loc7_);
               _loc6_ = resolveColumnForNextItem(_loc3_);
               _loc7_--;
            }
            while(_loc7_ >= param2)
            {
               _loc3_ = getGridItemAt(_loc7_);
               _loc9_ = getRowNumberByItemIndex(_loc7_ + 1);
               _loc6_ = resolveColumnByIndex(_loc7_ + 1);
               _loc6_.addListItemAt(_loc3_,_loc9_);
               _loc7_--;
            }
            resolveColumnByIndex(param2).addListItemAt(param1,param2 / numColumns);
         }
         var _loc10_:uint = 0;
         _loc4_ = numColumns;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = IItemListWindow(getListItemAt(_loc8_));
            _loc6_.autoArrangeItems = true;
            _loc6_.height = _loc6_.scrollableRegion.height;
            _loc10_ = Math.max(_loc10_,_loc6_.height);
            _loc8_++;
         }
         _container.height = _loc10_;
      }
      
      protected function offsetGridItemsBackwards(param1:uint) : IWindowModel
      {
         var _loc2_:IWindowModel = null;
         var _loc8_:* = 0;
         var _loc7_:int = 0;
         _loc8_ = getRowNumberByItemIndex(param1);
         var _loc4_:IItemListWindow = resolveColumnByIndex(param1);
         var _loc3_:IWindowModel = _loc4_.removeListItemAt(_loc8_);
         var _loc5_:uint = numGridItems;
         var _loc6_:* = param1;
         if(_loc3_ == null)
         {
            return null;
         }
         _loc7_ = 0;
         while(_loc7_ < numColumns)
         {
            IItemListWindow(getListItemAt(_loc7_)).autoArrangeItems = false;
            _loc7_++;
         }
         while(_loc6_ < _loc5_)
         {
            _loc8_ = getRowNumberByItemIndex(_loc6_);
            _loc2_ = getGridItemAt(_loc6_ + 1);
            _loc4_ = resolveColumnByIndex(_loc6_);
            _loc4_.addListItemAt(_loc2_,_loc8_);
            _loc6_++;
         }
         var _loc9_:uint = 0;
         _loc7_ = 0;
         while(_loc7_ < numColumns)
         {
            _loc4_ = IItemListWindow(getListItemAt(_loc7_));
            _loc4_.autoArrangeItems = true;
            _loc4_.height = _loc4_.scrollableRegion.height;
            _loc9_ = Math.max(_loc9_,_loc4_.height);
            _loc7_++;
         }
         _container.height = _loc9_;
         return _loc3_;
      }
      
      public function rebuildGridStructure() : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc1_:IWindowModel = null;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc5_:int = int(numGridItems);
         var _loc2_:Array = [];
         var _loc3_:int = int(numColumns);
         if(_isGridRebuilding)
         {
            return;
         }
         _isGridRebuilding = true;
         var _loc6_:Boolean = autoArrangeItems;
         autoArrangeItems = false;
         while(_loc5_ > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc4_ = getListItemAt(_loc7_) as IItemListWindow;
               _loc1_ = _loc4_.removeListItemAt(0);
               _loc2_.push(_loc1_);
               _loc5_--;
               if(_loc5_ < 1)
               {
                  break;
               }
               _loc7_++;
            }
         }
         destroyListItems();
         autoArrangeItems = _loc6_;
         for each(_loc1_ in _loc2_)
         {
            addGridItem(_loc1_);
         }
         if(_containerResizeToColumns)
         {
            _loc8_ = 0;
            _loc7_ = 0;
            while(_loc7_ < numColumns)
            {
               _loc4_ = IItemListWindow(getListItemAt(_loc7_));
               _loc4_.autoArrangeItems = true;
               _loc4_.height = _loc4_.scrollableRegion.height;
               _loc8_ = Math.max(_loc8_,_loc4_.height);
               _loc7_++;
            }
            _container.height = _loc8_;
         }
         _isGridRebuilding = false;
      }
      
      public function set containerResizeToColumns(param1:Boolean) : void
      {
         _containerResizeToColumns = param1;
      }
      
      public function get containerResizeToColumns() : Boolean
      {
         return _containerResizeToColumns;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("container_resize_to_columns",containerResizeToColumns));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("container_resize_to_columns" === _loc3_)
            {
               containerResizeToColumns = _loc2_.value as Boolean;
            }
         }
         super.properties = param1;
      }
   }
}

