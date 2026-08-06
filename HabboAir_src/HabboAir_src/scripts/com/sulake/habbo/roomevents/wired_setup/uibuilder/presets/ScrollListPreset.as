package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.interfaces.IListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ScrollListPreset extends WiredUIPreset implements IListPreset
   {
      private var SCROLLBAR_WIDTH:int = 9;
      
      private var SCROLLBAR_MARGIN:int = 3;
      
      private var _container:IScrollableListWindow;
      
      private var UnknownVarFromScrollListPreset_Vector_1:Vector.<WiredUIPreset>;
      
      private var UnknownVarFromScrollListPreset_Boolean_1:Boolean;
      
      private var _scrollParams:ListScrollParams;
      
      private var _cachedWidth:int;
      
      private var _ignoreListeners:Boolean;
      
      public function ScrollListPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:ListScrollParams, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_scroll_list_view") as IScrollableListWindow;
         UnknownVarFromScrollListPreset_Boolean_1 = param6;
         _scrollParams = param5;
         _container.spacing = param3.genericVerticalSpacing;
         UnknownVarFromScrollListPreset_Vector_1 = new Vector.<WiredUIPreset>();
         for each(var _loc7_ in param4)
         {
            UnknownVarFromScrollListPreset_Vector_1.push(_loc7_);
            _container.addListItem(_loc7_.window);
         }
         _container.limits.minHeight = param5.minHeight;
         _container.limits.maxHeight = param5.maxHeight;
         if(param5.alwaysShowScrollbar)
         {
            _container.autoHideScrollBar = true;
         }
         _container.scrollableWindow.addEventListener("WE_RESIZED",onScrollableWindowResized);
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      public function set spacing(param1:int) : void
      {
         _container.spacing = param1;
      }
      
      public function get spacing() : int
      {
         return _container.spacing;
      }
      
      public function resizeChildrenToWidth(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         _loc2_ += _container.spacing * (UnknownVarFromScrollListPreset_Vector_1.length - 1);
         for each(_loc3_ in UnknownVarFromScrollListPreset_Vector_1)
         {
            _loc3_.resizeToWidth(param1);
            _loc2_ += _loc3_.window.height;
         }
         if(UnknownVarFromScrollListPreset_Boolean_1)
         {
            for each(_loc3_ in UnknownVarFromScrollListPreset_Vector_1)
            {
               _loc3_.window.x = param1 / 2 - _loc3_.window.width / 2;
            }
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         _ignoreListeners = true;
         _cachedWidth = param1;
         super.resizeToWidth(param1);
         var _loc2_:* = param1;
         var _loc3_:* = param1;
         if(!_scrollParams.alwaysShowScrollbar)
         {
            resizeChildrenToWidth(_loc2_);
            fixHeight();
         }
         if(_container.isScrollBarVisible)
         {
            _loc2_ = param1 - SCROLLBAR_WIDTH - SCROLLBAR_MARGIN;
            resizeChildrenToWidth(_loc2_);
            _loc3_ = param1 - SCROLLBAR_MARGIN;
         }
         _container.width = _loc3_;
         fixHeight();
         _ignoreListeners = false;
      }
      
      private function fixHeight() : void
      {
         _container.height = Math.min(_scrollParams.maxHeight,Math.max(_scrollParams.minHeight,_container.scrollableRegion.height));
      }
      
      private function onScrollableWindowResized(param1:WindowEvent) : void
      {
         if(_ignoreListeners || disposing)
         {
            return;
         }
         resizeToWidth(_cachedWidth);
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         _container.background = true;
         _container.color = 4278190080 | param1;
      }
      
      override protected function get childPresets() : Array
      {
         return toArray(UnknownVarFromScrollListPreset_Vector_1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromScrollListPreset_Vector_1 = null;
      }
   }
}

