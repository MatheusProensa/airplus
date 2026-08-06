package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications.SubVariableParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SubVariableCreatorPreset extends WiredUIPreset
   {
      private var _checkboxGroup:CheckboxGroupPreset;
      
      private var UnknownVarFromSubVariableCreatorPreset_Array_1:Array;
      
      public function SubVariableCreatorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Array)
      {
         var _loc8_:int = 0;
         var _loc11_:SubVariableParam = null;
         var _loc9_:String = null;
         var _loc7_:CheckboxOptionParam = null;
         var _loc10_:TextParam = null;
         super(param1,param2,param3);
         UnknownVarFromSubVariableCreatorPreset_Array_1 = [];
         var _loc6_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < param5.length)
         {
            _loc11_ = param5[_loc8_];
            _loc9_ = param4 + _loc11_.id;
            _loc7_ = new CheckboxOptionParam("${" + _loc9_ + "}");
            _loc7_.extra1 = param2.createTextInput(new TextInputParam(_loc11_.name,-1,null,85,null,false)).alignRight();
            if(_loc11_.hasExtraText)
            {
               _loc10_ = new TextParam(1);
               _loc10_.textColor = param3.softTextColor;
               _loc7_.extra2 = param2.createText("${" + _loc9_ + ".extra}",_loc10_);
            }
            _loc6_.push(_loc7_);
            UnknownVarFromSubVariableCreatorPreset_Array_1.push(_loc11_.id);
            _loc8_++;
         }
         _checkboxGroup = param2.createCheckboxGroup(_loc6_);
      }
      
      public function set mask(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:CheckboxOptionPreset = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _checkboxGroup.numCheckboxes)
         {
            _loc4_ = _checkboxGroup.get(_loc2_);
            _loc3_ = int(UnknownVarFromSubVariableCreatorPreset_Array_1[_loc2_]);
            _loc4_.selected = (param1 & 1 << _loc3_) > 0;
            _loc2_ += 1;
         }
      }
      
      public function get mask() : int
      {
         var _loc1_:int = 0;
         var _loc4_:CheckboxOptionPreset = null;
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         _loc1_ = 0;
         while(_loc1_ < _checkboxGroup.numCheckboxes)
         {
            _loc4_ = _checkboxGroup.get(_loc1_);
            if(_loc4_.selected)
            {
               _loc2_ = int(UnknownVarFromSubVariableCreatorPreset_Array_1[_loc1_]);
               _loc3_ |= 1 << _loc2_;
            }
            _loc1_ += 1;
         }
         return _loc3_;
      }
      
      override public function get window() : IWindowModel
      {
         return _checkboxGroup.window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _checkboxGroup.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [_checkboxGroup];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _checkboxGroup = null;
         UnknownVarFromSubVariableCreatorPreset_Array_1 = null;
      }
   }
}

