package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils5;
   
   public class TableRowView implements IComponentInterfaceQueue
   {
      private static var UnknownVarFromTableRowView_Uint_1:uint = 12116732;
      
      private static var UnknownVarFromTableRowView_Uint_2:uint = 13750737;
      
      private static var UnknownVarFromTableRowView_Uint_3:uint = 15395562;
      
      private static var UnknownVarFromTableRowView_Uint_4:uint = 16382457;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromTableRowView_TableView_1:TableView;
      
      private var _container:IItemListWindow;
      
      private var UnknownVarFromTableRowView_Vector_1:Vector.<TableCellView>;
      
      private var UnknownVarFromTableRowView_TableRowModel_1:TableRowModel;
      
      public function TableRowView(param1:TableView, param2:TableRowModel)
      {
         var _loc5_:TableCell = null;
         var _loc3_:TableCellView = null;
         super();
         UnknownVarFromTableRowView_TableView_1 = param1;
         UnknownVarFromTableRowView_TableRowModel_1 = param2;
         _container = param1.rowTemplate.clone() as IItemListWindow;
         UnknownVarFromTableRowView_Vector_1 = new Vector.<TableCellView>();
         updateWidth();
         for each(var _loc4_ in param1.columns)
         {
            _loc5_ = object.getTableCell(_loc4_.id);
            _loc3_ = new TableCellView(param1,this,_loc4_.id,_loc5_);
            UnknownVarFromTableRowView_Vector_1.push(_loc3_);
            _container.addListItem(_loc3_.container);
         }
         updateColor();
         _container.addEventListener("WME_DOWN",onDown);
         _container.addEventListener("WME_OVER",onHoverOver);
         _container.addEventListener("WME_OUT",onHoverOut);
         _container.addEventListener("WME_CLICK_AWAY",onClickAway);
      }
      
      private static function windowIsChild(param1:IWindowModel, param2:IWindowModel) : Boolean
      {
         var _loc3_:IWindowController_1 = null;
         var _loc4_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         if(param1 is IWindowController_1 || param1 is IItemListWindow || param1 is ISelectorWindow)
         {
            if(param1 is UnknownICoreWindowUtils5)
            {
               for each(var _loc5_ in (param1 as UnknownICoreWindowUtils5).children)
               {
                  if(windowIsChild(_loc5_,param2))
                  {
                     return true;
                  }
               }
            }
            else if(param1 is IWindowController_1)
            {
               _loc3_ = param1 as IWindowController_1;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.numChildren)
               {
                  if(windowIsChild(_loc3_.getChildAt(_loc4_),param2))
                  {
                     return true;
                  }
                  _loc4_++;
               }
            }
         }
         return false;
      }
      
      public function indexUpdated() : void
      {
         updateColor();
      }
      
      public function objectUpdated(param1:ITableObject, param2:ITableObject) : void
      {
         var _loc6_:TableCell = null;
         var _loc3_:TableCellView = null;
         var _loc5_:int = 0;
         for each(var _loc4_ in UnknownVarFromTableRowView_TableView_1.columns)
         {
            if(param2.isPropertyUpdated(_loc4_.id,param1))
            {
               _loc6_ = param2.getTableCell(_loc4_.id);
               _loc3_ = UnknownVarFromTableRowView_Vector_1[_loc5_];
               _loc3_.update(_loc6_);
            }
            _loc5_ += 1;
         }
      }
      
      public function reuse(param1:TableRowModel) : void
      {
         var _loc5_:TableCell = null;
         var _loc2_:TableCellView = null;
         UnknownVarFromTableRowView_TableRowModel_1 = param1;
         var _loc4_:int = 0;
         for each(var _loc3_ in UnknownVarFromTableRowView_TableView_1.columns)
         {
            _loc5_ = object.getTableCell(_loc3_.id);
            _loc2_ = UnknownVarFromTableRowView_Vector_1[_loc4_];
            _loc2_.reuse(_loc5_);
            _loc4_ += 1;
         }
         updateColor();
      }
      
      public function updateWidth() : void
      {
         if(container.width == UnknownVarFromTableRowView_TableView_1.rowWidth)
         {
            return;
         }
         container.width = UnknownVarFromTableRowView_TableView_1.rowWidth;
         for each(var _loc1_ in UnknownVarFromTableRowView_Vector_1)
         {
            _loc1_.updateWidth();
         }
      }
      
      private function updateColor() : void
      {
         var _loc1_:* = 0;
         if(UnknownVarFromTableRowView_TableRowModel_1 == null)
         {
            return;
         }
         if(UnknownVarFromTableRowView_TableRowModel_1.selected)
         {
            if(UnknownVarFromTableRowView_TableRowModel_1.hasFocus)
            {
               _loc1_ = UnknownVarFromTableRowView_Uint_1;
            }
            else
            {
               _loc1_ = UnknownVarFromTableRowView_Uint_2;
            }
         }
         else
         {
            _loc1_ = UnknownVarFromTableRowView_TableRowModel_1.i % 2 == 0 ? UnknownVarFromTableRowView_Uint_3 : UnknownVarFromTableRowView_Uint_4;
         }
         _container.color = 4278190080 ^ _loc1_;
      }
      
      internal function onDown(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableRowView_TableRowModel_1 == null)
         {
            return;
         }
         UnknownVarFromTableRowView_TableRowModel_1.hasFocus = true;
         UnknownVarFromTableRowView_TableView_1.trySelect(object,true);
         updateColor();
      }
      
      internal function onHoverOver(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableRowView_TableRowModel_1 == null)
         {
            return;
         }
         if(!UnknownVarFromTableRowView_TableRowModel_1.hovered)
         {
            UnknownVarFromTableRowView_TableView_1.onHover(object);
         }
      }
      
      internal function onHoverOut(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableRowView_TableRowModel_1 == null)
         {
            return;
         }
         if(UnknownVarFromTableRowView_TableRowModel_1.hovered)
         {
            UnknownVarFromTableRowView_TableView_1.onHover(null);
         }
      }
      
      internal function onClickAway(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableRowView_TableRowModel_1 == null)
         {
            return;
         }
         UnknownVarFromTableRowView_TableRowModel_1.hasFocus = windowIsChild(_container,param1.related);
         updateColor();
      }
      
      public function selectedUpdated() : void
      {
         updateColor();
      }
      
      public function hovereddUpdated() : void
      {
      }
      
      public function get object() : ITableObject
      {
         return UnknownVarFromTableRowView_TableRowModel_1?.object;
      }
      
      public function get container() : IItemListWindow
      {
         return _container;
      }
      
      public function recycle() : void
      {
         for each(var _loc1_ in UnknownVarFromTableRowView_Vector_1)
         {
            _loc1_.recycle();
         }
         UnknownVarFromTableRowView_TableRowModel_1 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in UnknownVarFromTableRowView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromTableRowView_Vector_1 = null;
         _container.dispose();
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

