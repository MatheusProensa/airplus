package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextPreset extends WiredUIPreset
   {
      private var UnknownVarFromTextPreset_TextParam_1:TextParam;
      
      protected var _window:ITextWindow;
      
      public function TextPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:TextParam)
      {
         super(param1,param2,param3);
         UnknownVarFromTextPreset_TextParam_1 = param5;
         _window = createView();
         if(UnknownVarFromTextPreset_TextParam_1.fontSize != -1)
         {
            _window.fontSize = UnknownVarFromTextPreset_TextParam_1.fontSize;
         }
         if(UnknownVarFromTextPreset_TextParam_1.textColor != 0)
         {
            _window.textColor = UnknownVarFromTextPreset_TextParam_1.textColor;
         }
         _window.text = param4;
         initializeMode(param5);
      }
      
      protected function initializeMode(param1:TextParam) : void
      {
         if(param1.mode == 1)
         {
            _window.multiline = true;
            _window.wordWrap = true;
            _window.maxLines = param1.maxLines;
            if(param1.alignment != null)
            {
               _window.autoSize = param1.alignment;
            }
         }
         if(param1.mode == 2)
         {
            _window.overflowReplace = "...";
            _window.autoSize = "none";
         }
      }
      
      protected function createView() : ITextWindow
      {
         var _loc1_:ITextWindow = UnknownVarFromWiredUIPreset_WiredStyle_1.createTextView(UnknownVarFromTextPreset_TextParam_1.bold);
         _loc1_.underline = UnknownVarFromTextPreset_TextParam_1.underline;
         return _loc1_;
      }
      
      public function get text() : String
      {
         return _window.text;
      }
      
      public function set text(param1:String) : void
      {
         _window.text = param1;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return canStretch;
      }
      
      override public function get staticWidth() : int
      {
         if(canStretch)
         {
            return _window.width;
         }
         throw new Exception("Non stretching text has no static width");
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         if(!canStretch)
         {
            _window.width = param1;
         }
      }
      
      public function get canStretch() : Boolean
      {
         return UnknownVarFromTextPreset_TextParam_1.mode == 0;
      }
      
      public function get width() : int
      {
         return _window.width;
      }
      
      public function get fontSize() : int
      {
         return (_window as ITextWindow).fontSize;
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
         UnknownVarFromTextPreset_TextParam_1 = null;
      }
   }
}

