package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HtmlPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class LevelXpPreviewPreset extends WiredUIPreset
   {
      private static var UnknownVarFromLevelXpPreviewPreset_Number_1:Number = 9223372036854776000;
      
      private var UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var _window:IWindowController_1;
      
      private var _previewLevels:Array;
      
      private var UnknownVarFromLevelXpPreviewPreset_Vector_1:Vector.<HtmlPreset>;
      
      public function LevelXpPreviewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         var _loc8_:HtmlPreset = null;
         super(param1,param2,param3);
         _previewLevels = param4;
         UnknownVarFromLevelXpPreviewPreset_Vector_1 = new Vector.<HtmlPreset>();
         var _loc5_:Array = [];
         var _loc6_:HtmlTextParam = new HtmlTextParam(0);
         for each(var _loc7_ in _previewLevels)
         {
            _loc8_ = param2.createHtml(getText(_loc7_,"0"),_loc6_);
            UnknownVarFromLevelXpPreviewPreset_Vector_1.push(_loc8_);
            _loc5_.push(_loc8_);
         }
         UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1 = param2.createSimpleListView(true,_loc5_);
         UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1.spacing = 1;
         _window = param2.createLayout("container_view") as IWindowController_1;
         _window.addChild(UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1.window);
      }
      
      private function getText(param1:int, param2:String) : String
      {
         return _roomEvents.localization.getLocalizationWithParams("wiredfurni.params.levelup.preview.entry","","lvl","<font color=\"" + yellowColorHex + "\">" + param1 + "</font>","xp","<font color=\"" + yellowColorHex + "\">" + param2 + "</font>");
      }
      
      private function get yellowColorHex() : String
      {
         return Util.uintToHexColor(UnknownVarFromWiredUIPreset_WiredStyle_1.yellowTextColor);
      }
      
      public function setPreviewXps(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < _previewLevels.length)
         {
            _loc2_ = int(_previewLevels[_loc3_]);
            _loc5_ = "Unreachable level";
            if(_loc3_ < param1.length)
            {
               _loc4_ = Number(param1[_loc3_]);
               if(_loc4_ > UnknownVarFromLevelXpPreviewPreset_Number_1)
               {
                  _loc5_ = "Out of bounds";
               }
               else
               {
                  _loc5_ = Math.round(param1[_loc3_]).toString();
               }
            }
            UnknownVarFromLevelXpPreviewPreset_Vector_1[_loc3_].text = getText(_loc2_,_loc5_);
            _loc3_++;
         }
      }
      
      public function get previewLevels() : Array
      {
         return _previewLevels;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1.resizeToWidth(param1);
         _window.height = UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1.window.height;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1];
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
         UnknownVarFromLevelXpPreviewPreset_SimpleListViewPreset_1 = null;
         _previewLevels = null;
         UnknownVarFromLevelXpPreviewPreset_Vector_1 = null;
      }
   }
}

