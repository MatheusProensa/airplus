package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public class TableRowModel implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _object:ITableObject;
      
      private var _i:int;
      
      private var _selected:Boolean = false;
      
      private var _hovered:Boolean = false;
      
      private var _hasFocus:Boolean = false;
      
      private var _view:TableRowView;
      
      public function TableRowModel(param1:ITableObject, param2:int)
      {
         super();
         _object = param1;
         _i = param2;
      }
      
      public function set index(param1:int) : void
      {
         _i = param1;
         if(_view != null)
         {
            _view.indexUpdated();
         }
      }
      
      public function update(param1:ITableObject) : void
      {
         if(!param1.isUpdated(_object))
         {
            _object = param1;
            return;
         }
         var _loc2_:ITableObject = _object;
         _object = param1;
         if(_view != null)
         {
            _view.objectUpdated(_loc2_,param1);
         }
      }
      
      public function set hasFocus(param1:Boolean) : void
      {
         _hasFocus = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_view != null)
         {
            _view.selectedUpdated();
         }
      }
      
      public function set hovered(param1:Boolean) : void
      {
         _hovered = param1;
         if(_view != null)
         {
            _view.hovereddUpdated();
         }
      }
      
      public function set view(param1:TableRowView) : void
      {
         _view = param1;
      }
      
      public function get object() : ITableObject
      {
         return _object;
      }
      
      public function get i() : int
      {
         return _i;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get hovered() : Boolean
      {
         return _hovered;
      }
      
      public function get hasFocus() : Boolean
      {
         return _hasFocus;
      }
      
      public function get view() : TableRowView
      {
         return _view;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _object = null;
         _i = 0;
         _selected = false;
         _hovered = false;
         _hasFocus = false;
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

