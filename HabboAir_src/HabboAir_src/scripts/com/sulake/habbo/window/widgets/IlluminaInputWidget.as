package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class IlluminaInputWidget implements IIlluminaInputWidget
   {
      public static const TYPE:String = "illumina_input";
      
      private static const UnknownConstFromIlluminaInputWidget_String_1:String = "illumina_input:button_caption";
      
      private static const UnknownConstFromIlluminaInputWidget_String_2:String = "illumina_input:empty_message";
      
      private static const MULTILINE_KEY:String = "illumina_input:multiline";
      
      private static const MAX_CHARS_KEY:String = "illumina_input:max_chars";
      
      private static const SINGLE_LINE_HEIGHT:int = 28;
      
      private static const BUTTON_CAPTION_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:button_caption","${widgets.chatinput.say}","String");
      
      private static const EMPTY_MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:empty_message","","String");
      
      private static const MULTILINE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:multiline",false,"Boolean");
      
      private static const MAX_CHARS_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:max_chars",0,"int");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromIlluminaInputWidget_IWindowController_1_1:IWindowController_1;
      
      private var _submitButton:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1:ITextFieldWindow;
      
      private var _emptyMessageLabel:ILabelWindow;
      
      private var _submitHandler:IIlluminaInputHandler;
      
      public function IlluminaInputWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromIlluminaInputWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_input_xml").content as XML) as IWindowController_1;
         UnknownVarFromIlluminaInputWidget_IWindowController_1_1.width = UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1.width;
         _submitButton = UnknownVarFromIlluminaInputWidget_IWindowController_1_1.findChildByName("submit") as UnknownICoreWindowComponents4;
         UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1 = UnknownVarFromIlluminaInputWidget_IWindowController_1_1.findChildByName("input") as ITextFieldWindow;
         _emptyMessageLabel = UnknownVarFromIlluminaInputWidget_IWindowController_1_1.findChildByName("empty_message") as ILabelWindow;
         buttonCaption = String(BUTTON_CAPTION_DEFAULT.value);
         emptyMessage = String(EMPTY_MESSAGE_DEFAULT.value);
         multiline = Boolean(MULTILINE_DEFAULT.value);
         maxChars = int(MAX_CHARS_DEFAULT.value);
         refresh();
         UnknownVarFromIlluminaInputWidget_IWindowController_1_1.procedure = widgetProcedure;
         UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromIlluminaInputWidget_IWindowController_1_1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1 != null)
            {
               UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1 = null;
            }
            _submitButton = null;
            _emptyMessageLabel = null;
            if(UnknownVarFromIlluminaInputWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromIlluminaInputWidget_IWindowController_1_1.dispose();
               UnknownVarFromIlluminaInputWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(BUTTON_CAPTION_DEFAULT.withValue(buttonCaption));
         _loc1_.push(EMPTY_MESSAGE_DEFAULT.withValue(emptyMessage));
         _loc1_.push(MULTILINE_DEFAULT.withValue(multiline));
         _loc1_.push(MAX_CHARS_DEFAULT.withValue(maxChars));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_input:button_caption":
                  buttonCaption = String(_loc2_.value);
                  break;
               case "illumina_input:empty_message":
                  emptyMessage = String(_loc2_.value);
                  break;
               case "illumina_input:multiline":
                  multiline = Boolean(_loc2_.value);
                  break;
               case "illumina_input:max_chars":
                  maxChars = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get buttonCaption() : String
      {
         return _submitButton.caption;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         _submitButton.caption = param1;
         _submitButton.visible = param1 != null && param1.length > 0;
         refresh();
      }
      
      public function get emptyMessage() : String
      {
         return _emptyMessageLabel.caption;
      }
      
      public function set emptyMessage(param1:String) : void
      {
         _emptyMessageLabel.caption = param1;
      }
      
      public function get multiline() : Boolean
      {
         return UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.multiline = param1;
         UnknownVarFromIlluminaInputWidget_IWindowController_1_1.setParamFlag(2048,param1);
         UnknownVarFromIlluminaInputWidget_IWindowController_1_1.height = param1 ? UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1.height : 28;
      }
      
      public function get maxChars() : int
      {
         return UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.maxChars = param1;
      }
      
      public function get message() : String
      {
         return UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.caption;
      }
      
      public function set message(param1:String) : void
      {
         UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.caption = param1;
         refresh();
      }
      
      public function get submitHandler() : IIlluminaInputHandler
      {
         return _submitHandler;
      }
      
      public function set submitHandler(param1:IIlluminaInputHandler) : void
      {
         _submitHandler = param1;
      }
      
      private function widgetProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WE_CHANGE":
               if(param2 == UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1)
               {
                  refresh();
               }
               break;
            case "WKE_KEY_DOWN":
               if(param2 == UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1 && WindowKeyboardEvent(param1).charCode == 13 && Boolean(_submitButton.visible))
               {
                  submitMessage();
               }
               break;
            case "WME_CLICK":
               if(param2 == _submitButton)
               {
                  submitMessage();
               }
         }
      }
      
      private function submitMessage() : void
      {
         if(_submitHandler != null)
         {
            _submitHandler.onInput(UnknownVarFromIlluminaInputWidget_IWidgetWindowController_1,message);
         }
      }
      
      private function refresh() : void
      {
         _emptyMessageLabel.visible = UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.length == 0;
         UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.width = (!!_submitButton.visible ? _submitButton.x : int(UnknownVarFromIlluminaInputWidget_IWindowController_1_1.width)) - UnknownVarFromIlluminaInputWidget_ITextFieldWindow_1.x * 2;
      }
   }
}

