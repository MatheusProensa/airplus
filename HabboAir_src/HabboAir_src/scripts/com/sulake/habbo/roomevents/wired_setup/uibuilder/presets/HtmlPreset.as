package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HtmlPreset extends TextPreset
   {
      private var UnknownVarFromHtmlPreset_HtmlTextParam_1:HtmlTextParam;
      
      public function HtmlPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:HtmlTextParam)
      {
         super(param1,param2,param3,param4,param5);
         UnknownVarFromHtmlPreset_HtmlTextParam_1 = param5;
         (window as IHTMLTextController).selectable = UnknownVarFromHtmlPreset_HtmlTextParam_1.selectable;
      }
      
      override protected function createView() : ITextWindow
      {
         return UnknownVarFromWiredUIPreset_WiredStyle_1.createHtmlView();
      }
      
      override protected function initializeMode(param1:TextParam) : void
      {
         super.initializeMode(param1);
         _window.multiline = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromHtmlPreset_HtmlTextParam_1 = null;
      }
   }
}

