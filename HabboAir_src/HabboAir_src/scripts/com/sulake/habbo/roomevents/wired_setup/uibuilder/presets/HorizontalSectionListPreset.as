package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HorizontalSectionListPreset extends WiredUIPreset
   {
      private var _window:IItemListWindow;
      
      private var _splitters:Vector.<IWindowModel>;
      
      private var _childPresets:Array;
      
      public function HorizontalSectionListPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         var _loc5_:int = 0;
         var _loc6_:WiredUIPreset = null;
         var _loc7_:IWindowModel = null;
         super(param1,param2,param3);
         _window = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _window.spacing = 0;
         _splitters = new Vector.<IWindowModel>();
         _childPresets = param4;
         _loc5_ = 0;
         while(_loc5_ < param4.length)
         {
            _loc6_ = param4[_loc5_];
            if(_loc5_ > 0)
            {
               _loc7_ = param3.createSplitterVerticalView();
               _loc7_.setParamFlag(16,false);
               _splitters.push(_loc7_);
               _window.addListItem(_loc7_);
            }
            _window.addListItem(_loc6_.window);
            _loc5_ += 1;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         super.resizeToWidth(param1);
         var _loc8_:int = 0;
         if(_splitters.length > 0)
         {
            _loc8_ = _splitters[0].width;
         }
         var _loc10_:int = param1 - _splitters.length * _loc8_;
         var _loc5_:int = 0;
         for each(_loc6_ in _childPresets)
         {
            if(_loc6_.hasStaticWidth())
            {
               _loc10_ -= _loc6_.staticWidth;
            }
            else
            {
               _loc5_ += 1;
            }
         }
         var _loc7_:int = Math.max(0,int(_loc10_ / _loc5_));
         var _loc2_:* = null;
         var _loc3_:* = 0;
         for each(_loc6_ in _childPresets)
         {
            if(_loc6_.hasStaticWidth())
            {
               _loc6_.resizeToWidth(_loc6_.staticWidth);
            }
            else
            {
               _loc2_ = _loc6_;
               _loc6_.resizeToWidth(_loc7_);
               _loc10_ -= _loc7_;
            }
            _loc4_ = _loc6_.window.height;
            if(_loc4_ > _loc3_)
            {
               _loc3_ = _loc4_;
            }
         }
         if(_loc10_ > 0 && _loc2_ != null)
         {
            _loc2_.resizeToWidth(_loc7_ + _loc10_);
            if(_loc4_ > _loc3_)
            {
               _loc3_ = _loc4_;
            }
         }
         for each(var _loc9_ in _splitters)
         {
            _loc9_.height = _loc3_ + UnknownVarFromWiredUIPreset_WiredStyle_1.sectionSpacing;
         }
         _window.height = _loc3_;
         _window.width = param1;
         _window.arrangeListItems();
      }
      
      override protected function get childPresets() : Array
      {
         return _childPresets;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
         _childPresets = null;
         _splitters = null;
      }
   }
}

