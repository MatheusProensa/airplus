package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextInputPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromTextInputPreset_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromTextInputPreset_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromTextInputPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromTextInputPreset_TextInputParam_1:TextInputParam;
      
      private var UnknownVarFromTextInputPreset_String_1:String;
      
      private var UnknownVarFromTextInputPreset_Array_1:Array = null;
      
      private var UnknownVarFromTextInputPreset_Int_1:int;
      
      public function TextInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:TextInputParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromTextInputPreset_IWindowModel_1 = param3.createTextInputView();
         UnknownVarFromTextInputPreset_ITextFieldWindow_1 = UnknownVarFromTextInputPreset_IWindowModel_1.findChildByName("field") as ITextFieldWindow;
         UnknownVarFromTextInputPreset_Int_1 = UnknownVarFromTextInputPreset_IWindowModel_1.width - UnknownVarFromTextInputPreset_ITextFieldWindow_1.width;
         UnknownVarFromTextInputPreset_TextInputParam_1 = param4;
         if(param4.maxCharacters > 0)
         {
            UnknownVarFromTextInputPreset_ITextFieldWindow_1.maxChars = param4.maxCharacters;
         }
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.text = UnknownVarFromTextInputPreset_TextInputParam_1.initialText;
         if(param4.width >= 0)
         {
            UnknownVarFromTextInputPreset_IWindowModel_1.width = param4.width + UnknownVarFromTextInputPreset_Int_1;
         }
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.editable = param4.editable;
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.restrict = param4.restrict;
         if(param4.tooltip != null)
         {
            UnknownVarFromTextInputPreset_ITextFieldWindow_1.toolTipCaption = param4.tooltip;
         }
         _container.addChild(UnknownVarFromTextInputPreset_IWindowModel_1);
         if(param4.placeholder != null)
         {
            UnknownVarFromTextInputPreset_TextPreset_1 = param2.createText(param4.placeholder,new TextParam(2));
            UnknownVarFromTextInputPreset_TextPreset_1.window.blend = 0.5;
            UnknownVarFromTextInputPreset_TextPreset_1.window.tags.push("HALF_BLEND");
            _container.addChild(UnknownVarFromTextInputPreset_TextPreset_1.window);
            UnknownVarFromTextInputPreset_TextPreset_1.window.x = UnknownVarFromTextInputPreset_ITextFieldWindow_1.x;
            UnknownVarFromTextInputPreset_TextPreset_1.window.y = UnknownVarFromTextInputPreset_ITextFieldWindow_1.y;
         }
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.addEventListener("WE_CHANGE",textHasChanged);
         textHasChanged(null);
      }
      
      private function textHasChanged(param1:WindowEvent) : void
      {
         if(UnknownVarFromTextInputPreset_TextPreset_1)
         {
            UnknownVarFromTextInputPreset_TextPreset_1.window.visible = UnknownVarFromTextInputPreset_ITextFieldWindow_1.text.length == 0;
         }
         if(UnknownVarFromTextInputPreset_ITextFieldWindow_1.text != UnknownVarFromTextInputPreset_String_1)
         {
            if(UnknownVarFromTextInputPreset_Array_1 != null)
            {
               for each(var _loc2_ in UnknownVarFromTextInputPreset_Array_1)
               {
                  _loc2_(UnknownVarFromTextInputPreset_ITextFieldWindow_1.text);
               }
            }
            UnknownVarFromTextInputPreset_String_1 = UnknownVarFromTextInputPreset_ITextFieldWindow_1.text;
         }
         updateWarn();
      }
      
      public function get text() : String
      {
         return UnknownVarFromTextInputPreset_ITextFieldWindow_1.text;
      }
      
      public function set text(param1:String) : void
      {
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.text = param1;
         textHasChanged(null);
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var _loc2_:int = int(UnknownVarFromTextInputPreset_TextInputParam_1.width >= 0 ? UnknownVarFromTextInputPreset_TextInputParam_1.width + UnknownVarFromTextInputPreset_Int_1 : param1);
         UnknownVarFromTextInputPreset_IWindowModel_1.width = _loc2_;
         if(UnknownVarFromTextInputPreset_TextPreset_1 != null)
         {
            UnknownVarFromTextInputPreset_TextPreset_1.resizeToWidth(_loc2_ - UnknownVarFromTextInputPreset_Int_1);
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromTextInputPreset_TextInputParam_1.width >= 0;
      }
      
      override public function get staticWidth() : int
      {
         return UnknownVarFromTextInputPreset_TextInputParam_1.width + UnknownVarFromTextInputPreset_Int_1;
      }
      
      override protected function get childPresets() : Array
      {
         return UnknownVarFromTextInputPreset_TextPreset_1 == null ? [] : [UnknownVarFromTextInputPreset_TextPreset_1];
      }
      
      public function addListener(param1:Function) : void
      {
         if(UnknownVarFromTextInputPreset_Array_1 == null)
         {
            UnknownVarFromTextInputPreset_Array_1 = [];
            UnknownVarFromTextInputPreset_String_1 = UnknownVarFromTextInputPreset_ITextFieldWindow_1.text;
         }
         UnknownVarFromTextInputPreset_Array_1.push(param1);
      }
      
      private function shouldShowWarn() : Boolean
      {
         var _loc2_:int = UnknownVarFromTextInputPreset_TextInputParam_1.maxCharacters;
         if(_loc2_ <= 10)
         {
            return false;
         }
         var _loc1_:int = Math.min(30,Math.max(6,_loc2_ / 5));
         return UnknownVarFromTextInputPreset_ITextFieldWindow_1.text.length > _loc2_ - _loc1_;
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
            limitText.text = UnknownVarFromTextInputPreset_ITextFieldWindow_1.text.length + "/" + UnknownVarFromTextInputPreset_TextInputParam_1.maxCharacters;
         }
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.addEventListener(param1,param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromTextInputPreset_ITextFieldWindow_1.removeEventListener(param1,param2);
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
         UnknownVarFromTextInputPreset_IWindowModel_1 = null;
         UnknownVarFromTextInputPreset_TextPreset_1 = null;
         UnknownVarFromTextInputPreset_TextInputParam_1 = null;
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

