package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VolterHeaderPreset extends HeaderPreset
   {
      private var UnknownVarFromVolterHeaderPreset_TextPreset_1:TextPreset;
      
      public function VolterHeaderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:UnknownIHabboRoomeventsWired_Setup1, param6:int, param7:Function, param8:Function, param9:Function)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      override protected function createTopHeaderElement(param1:String, param2:UnknownIHabboRoomeventsWired_Setup1) : WiredUIPreset
      {
         var _loc3_:TextParam = new TextParam(1,true);
         _loc3_.fontSize = UnknownVarFromWiredUIPreset_WiredStyle_1.headerNameFontSize;
         UnknownVarFromVolterHeaderPreset_TextPreset_1 = UnknownVarFromWiredUIPreset_PresetManager_1.createText(param1,_loc3_);
         return UnknownVarFromWiredUIPreset_PresetManager_1.createSimpleListView(false,[UnknownVarFromWiredUIPreset_PresetManager_1.createBitmapWrapperPreset("wired_type_icons_icon_" + param2.getKey()),UnknownVarFromVolterHeaderPreset_TextPreset_1]);
      }
      
      override public function updateName(param1:String) : void
      {
         UnknownVarFromVolterHeaderPreset_TextPreset_1.text = param1;
         resizeToWidth(_width);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromVolterHeaderPreset_TextPreset_1 = null;
      }
   }
}

