package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.PaddedContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.AbstractSectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InnerBorderFramePreset extends FramePreset
   {
      public function InnerBorderFramePreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:String, param7:int, param8:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      override protected function createListView(param1:Array) : void
      {
         var _loc8_:SpacerPreset = null;
         var _loc9_:int = 0;
         var _loc12_:WiredUIPreset = null;
         var _loc10_:SimpleListViewPreset = null;
         var _loc7_:PaddedContainerPreset = null;
         var _loc2_:UnknownICoreWindowComponents6 = UnknownVarFromWiredUIPreset_WiredStyle_1.createInnerBorder();
         var _loc4_:int = UnknownVarFromWiredUIPreset_WiredStyle_1.sectionSpacing;
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Boolean = false;
         var _loc11_:Boolean = false;
         _loc9_ = 0;
         while(_loc9_ < param1.length)
         {
            _loc12_ = param1[_loc9_];
            if(_loc12_ is FooterPreset)
            {
               FooterPreset(_loc12_).splitterVisible = false;
               _loc11_ = true;
               _loc10_ = UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(true,_loc5_);
               _loc10_.spacing = 0;
               _loc10_.backgroundColor = UnknownVarFromWiredUIPreset_WiredStyle_1.backgroundColor;
               _loc7_ = UnknownVarFromWiredUIPreset_PresetManager_1.createPaddedContainerPreset(_loc10_,9,8,9,8,_loc2_);
               _loc3_.push(_loc7_);
            }
            if(!_loc6_ || _loc11_)
            {
               _loc3_.push(_loc12_);
            }
            else
            {
               _loc5_.push(_loc12_);
               if(_loc5_.length > 1)
               {
                  _loc8_ = UnknownVarFromWiredUIPreset_PresetManager_1.createSpacer(_loc4_);
                  _loc12_.blendSpacer = _loc8_;
                  _loc5_.push(_loc8_);
               }
               if(_loc5_.length == 1)
               {
                  if(_loc12_ is SectionPreset)
                  {
                     SectionPreset(_loc12_).splitterVisible = false;
                  }
                  else if(_loc12_ is AbstractSectionPreset)
                  {
                     AbstractSectionPreset(_loc12_).splitterVisible = false;
                  }
               }
            }
            if(_loc12_ is HeaderPreset)
            {
               _headerPreset = _loc12_ as HeaderPreset;
               _loc6_ = true;
            }
            _loc9_++;
         }
         UnknownVarFromFramePreset_IListPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(true,_loc3_);
         UnknownVarFromFramePreset_IListPreset_1.backgroundColor = UnknownVarFromWiredUIPreset_WiredStyle_1.frameColor;
      }
   }
}

