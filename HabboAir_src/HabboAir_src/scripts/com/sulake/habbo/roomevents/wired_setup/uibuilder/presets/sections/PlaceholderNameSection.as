package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HtmlPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PlaceholderNameSection extends AbstractSectionPreset
   {
      private var _name:TextInputPreset;
      
      private var _preview:HtmlPreset;
      
      private var UnknownVarFromPlaceholderNameSection_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromPlaceholderNameSection_String_1:String;
      
      public function PlaceholderNameSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String)
      {
         super(param1,param2,param3);
         UnknownVarFromPlaceholderNameSection_String_1 = param5;
         _name = param2.createTextInput(new TextInputParam("",32,null,-1,"a-zA-Z_0-9 "));
         _preview = param2.createHtml(l("texts.placeholder_preview").replace("#ffffaa",Util.uintToHexColor(param3.yellowTextColor)),new HtmlTextParam(1,true,2));
         UnknownVarFromPlaceholderNameSection_SimpleListViewPreset_1 = param2.createSimpleListView(true,[_name,_preview.staticHeight(_preview.fontSize * 3)]);
         _name.addListener(onPlaceholderChange);
         initializeSection(param4,UnknownVarFromPlaceholderNameSection_SimpleListViewPreset_1);
      }
      
      private function onPlaceholderChange(param1:String) : void
      {
         var _loc3_:String = _name.text;
         var _loc4_:String = param1.split(" ").join("_").toLowerCase();
         if(_loc3_ != _loc4_)
         {
            _name.text = _loc4_;
         }
         var _loc2_:String = _roomEvents.localization.getLocalizationWithParams("wiredfurni.params.texts.placeholder_preview","","placeholder",UnknownVarFromPlaceholderNameSection_String_1 + "(" + _loc4_.toLowerCase() + ")").replace("#ffffaa",Util.uintToHexColor(UnknownVarFromWiredUIPreset_WiredStyle_1.yellowTextColor));
         _preview.text = _loc2_;
      }
      
      public function set placeholderName(param1:String) : void
      {
         _name.text = param1;
         onPlaceholderChange(param1);
      }
      
      public function get placeholderName() : String
      {
         return _name.text.split(" ").join("_").toLowerCase();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromPlaceholderNameSection_SimpleListViewPreset_1 = null;
         _name = null;
         _preview = null;
         UnknownVarFromPlaceholderNameSection_String_1 = null;
      }
   }
}

