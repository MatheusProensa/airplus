package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.interfaces.IListPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SimpleListViewPreset extends WiredUIPreset implements IListPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromSimpleListViewPreset_Vector_1:Vector.<WiredUIPreset>;
      
      private var UnknownVarFromSimpleListViewPreset_Boolean_1:Boolean;
      
      private var UnknownVarFromSimpleListViewPreset_Boolean_2:Boolean;
      
      private var _allChildrenStaticWidth:Boolean;
      
      private var _staticWidth:int;
      
      public function SimpleListViewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Boolean, param5:Array, param6:Boolean)
      {
         super(param1,param2,param3);
         _container = param4 ? param2.createLayout("vertical_list_view") as IItemListWindow : param2.createLayout("horizontal_list_view") as IItemListWindow;
         UnknownVarFromSimpleListViewPreset_Boolean_1 = param4;
         UnknownVarFromSimpleListViewPreset_Boolean_2 = param6;
         _container.spacing = param4 ? param3.genericHorizontalSpacing : param3.genericVerticalSpacing;
         UnknownVarFromSimpleListViewPreset_Vector_1 = new Vector.<WiredUIPreset>();
         for each(var _loc7_ in param5)
         {
            UnknownVarFromSimpleListViewPreset_Vector_1.push(_loc7_);
            _container.addListItem(_loc7_.window);
            _loc7_.invisibilityListener = this;
         }
         if(!param4)
         {
            _allChildrenStaticWidth = true;
            _staticWidth = 0;
            for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
            {
               if(!_loc7_.hasStaticWidth())
               {
                  _allChildrenStaticWidth = false;
                  break;
               }
               _staticWidth += _loc7_.staticWidth;
            }
            if(_allChildrenStaticWidth && UnknownVarFromSimpleListViewPreset_Vector_1.length > 1)
            {
               _staticWidth += _container.spacing * (UnknownVarFromSimpleListViewPreset_Vector_1.length - 1);
            }
            if(_allChildrenStaticWidth)
            {
               _container.width = _staticWidth;
            }
         }
      }
      
      override protected function onInvisibilityChanged(param1:WiredUIPreset, param2:Boolean) : void
      {
         _container.arrangeListItems();
         resize();
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
      
      public function set minHeight(param1:int) : void
      {
         _container.limits.minHeight = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         super.resizeToWidth(param1);
         var _loc6_:int = 0;
         for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
         {
            if(_loc7_.visible)
            {
               _loc6_ += 1;
            }
         }
         if(UnknownVarFromSimpleListViewPreset_Boolean_1)
         {
            _container.width = param1;
            for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
            {
               _loc7_.resizeToWidth(param1);
            }
            if(UnknownVarFromSimpleListViewPreset_Boolean_2)
            {
               throw new Exception("Centering vertical lists not implemented yet");
            }
         }
         else
         {
            _loc8_ = _allChildrenStaticWidth ? _staticWidth : param1;
            _loc5_ = _loc8_ - (_loc6_ - 1) * _container.spacing;
            _loc3_ = 0;
            for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
            {
               if(_loc7_.visible)
               {
                  if(_loc7_.hasStaticWidth())
                  {
                     _loc5_ -= _loc7_.staticWidth;
                  }
                  else
                  {
                     _loc3_ += 1;
                  }
               }
            }
            _loc9_ = Math.max(0,int(_loc5_ / _loc3_));
            _loc2_ = int(_container.limits.minHeight);
            for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
            {
               if(_loc7_.visible)
               {
                  if(_loc7_.hasStaticWidth())
                  {
                     _loc7_.resizeToWidth(_loc7_.staticWidth);
                  }
                  else
                  {
                     _loc7_.resizeToWidth(_loc9_);
                  }
                  _loc4_ = _loc7_.window.height;
                  if(_loc4_ > _loc2_)
                  {
                     _loc2_ = _loc4_;
                  }
               }
            }
            if(UnknownVarFromSimpleListViewPreset_Boolean_2)
            {
               for each(_loc7_ in UnknownVarFromSimpleListViewPreset_Vector_1)
               {
                  _loc7_.window.y = _loc2_ / 2 - _loc7_.window.height / 2;
               }
            }
            _container.width = _loc8_;
            _container.height = _loc2_;
         }
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         _container.background = true;
         _container.color = 4278190080 | param1;
      }
      
      override protected function get childPresets() : Array
      {
         return toArray(UnknownVarFromSimpleListViewPreset_Vector_1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _allChildrenStaticWidth;
      }
      
      override public function get staticWidth() : int
      {
         if(!_allChildrenStaticWidth)
         {
            return -1;
         }
         return _staticWidth;
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
         UnknownVarFromSimpleListViewPreset_Vector_1 = null;
      }
   }
}

