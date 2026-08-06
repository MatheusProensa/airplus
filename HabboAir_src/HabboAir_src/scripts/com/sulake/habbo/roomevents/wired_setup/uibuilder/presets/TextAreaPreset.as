package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextAreaPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromTextAreaPreset_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromTextAreaPreset_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromTextAreaPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromTextAreaPreset_TextAreaParam_1:TextAreaParam;
      
      private var UnknownVarFromTextAreaPreset_Int_1:int;
      
      public function TextAreaPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:TextAreaParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromTextAreaPreset_IWindowModel_1 = param3.createTextInputView();
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1 = UnknownVarFromTextAreaPreset_IWindowModel_1.findChildByName("field") as ITextFieldWindow;
         UnknownVarFromTextAreaPreset_Int_1 = UnknownVarFromTextAreaPreset_IWindowModel_1.width - UnknownVarFromTextAreaPreset_ITextFieldWindow_1.width;
         UnknownVarFromTextAreaPreset_TextAreaParam_1 = param4;
         if(param4.maxCharacters > 0)
         {
            UnknownVarFromTextAreaPreset_ITextFieldWindow_1.maxChars = param4.maxCharacters;
         }
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text = UnknownVarFromTextAreaPreset_TextAreaParam_1.initialText;
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.multiline = true;
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.wordWrap = param4.wordwrap;
         if(param4.width >= 0)
         {
            UnknownVarFromTextAreaPreset_IWindowModel_1.width = param4.width + UnknownVarFromTextAreaPreset_Int_1;
         }
         UnknownVarFromTextAreaPreset_IWindowModel_1.height = param4.height;
         if(param4.maxLines >= 0)
         {
            UnknownVarFromTextAreaPreset_ITextFieldWindow_1.maxLines = param4.maxLines;
         }
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.editable = param4.editable;
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.restrict = param4.restrict;
         if(param4.tooltip != null)
         {
            UnknownVarFromTextAreaPreset_ITextFieldWindow_1.toolTipCaption = param4.tooltip;
         }
         _container.addChild(UnknownVarFromTextAreaPreset_IWindowModel_1);
         if(param4.placeholder != null)
         {
            UnknownVarFromTextAreaPreset_TextPreset_1 = param2.createText(param4.placeholder,new TextParam(1));
            UnknownVarFromTextAreaPreset_TextPreset_1.window.blend = 0.5;
            UnknownVarFromTextAreaPreset_TextPreset_1.window.tags.push("HALF_BLEND");
            UnknownVarFromTextAreaPreset_TextPreset_1.window.x = UnknownVarFromTextAreaPreset_ITextFieldWindow_1.x;
            UnknownVarFromTextAreaPreset_TextPreset_1.window.y = UnknownVarFromTextAreaPreset_ITextFieldWindow_1.y;
            _container.addChild(UnknownVarFromTextAreaPreset_TextPreset_1.window);
         }
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.addEventListener("WE_CHANGE",textHasChanged);
         textHasChanged(null);
      }
      
      private function textHasChanged(param1:WindowEvent) : void
      {
         if(UnknownVarFromTextAreaPreset_TextPreset_1)
         {
            UnknownVarFromTextAreaPreset_TextPreset_1.visible = UnknownVarFromTextAreaPreset_ITextFieldWindow_1.length == 0;
         }
         updateWarn();
      }
      
      public function get text() : String
      {
         return UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text.replace(/\n\r/g,"\n").replace(/\r/g,"\n");
      }
      
      public function set text(param1:String) : void
      {
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text = param1.replace(/\n/g,"\r");
         textHasChanged(null);
      }
      
      public function reset() : void
      {
         UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text = "";
         textHasChanged(null);
      }
      
      private function shouldShowWarn() : Boolean
      {
         var _loc2_:int = UnknownVarFromTextAreaPreset_TextAreaParam_1.maxCharacters;
         if(_loc2_ <= 10)
         {
            return false;
         }
         var _loc1_:int = Math.min(30,Math.max(6,_loc2_ / 5));
         return UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text.length > _loc2_ - _loc1_;
      }
      
      private function updateWarn() : void
      {
         if(charLimitWarnArea == null)
         {
            return;
         }
         var _loc1_:Boolean = shouldShowWarn();
         charLimitWarnArea.visible = _loc1_;
         if(_loc1_)
         {
            limitText.text = UnknownVarFromTextAreaPreset_ITextFieldWindow_1.text.length + "/" + UnknownVarFromTextAreaPreset_TextAreaParam_1.maxCharacters;
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var _loc2_:int = int(UnknownVarFromTextAreaPreset_TextAreaParam_1.width >= 0 ? UnknownVarFromTextAreaPreset_TextAreaParam_1.width + UnknownVarFromTextAreaPreset_Int_1 : param1);
         UnknownVarFromTextAreaPreset_IWindowModel_1.width = _loc2_;
         if(UnknownVarFromTextAreaPreset_TextPreset_1 != null)
         {
            UnknownVarFromTextAreaPreset_TextPreset_1.resizeToWidth(_loc2_ - UnknownVarFromTextAreaPreset_Int_1);
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         return UnknownVarFromTextAreaPreset_TextPreset_1 == null ? [] : [UnknownVarFromTextAreaPreset_TextPreset_1];
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
         UnknownVarFromTextAreaPreset_TextPreset_1 = null;
         UnknownVarFromTextAreaPreset_TextAreaParam_1 = null;
      }
      
      private function get charLimitWarnArea() : IWindowController_1
      {
         return _container.findChildByName("char_limit_warn") as IWindowController_1;
      }
      
      private function get limitText() : ITextWindow
      {
         return _container.findChildByName("limit_text") as ITextWindow;
      }
   }
}

