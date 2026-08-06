package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RunningNumberWidget implements IRunningNumberWidget, IProfiler_1
   {
      public static const TYPE:String = "running_number";
      
      private static const NUMBER_KEY:String = "running_number:number";
      
      private static const UnknownConstFromRunningNumberWidget_String_1:String = "running_number:digits";
      
      private static const COLOR_STYLE_KEY:String = "running_number:color_style";
      
      private static const UnknownConstFromRunningNumberWidget_String_2:String = "running_number:update_frequency";
      
      private static const NUMBER_DEFAULT:PropertyStruct = new PropertyStruct("running_number:number",0,"int");
      
      private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("running_number:digits",8,"uint");
      
      private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("running_number:color_style",0,"int");
      
      private static const UPDATE_FREQUENCY_DEFAULT:PropertyStruct = new PropertyStruct("running_number:update_frequency",50,"int");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromRunningNumberWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromRunningNumberWidget_IWindowController_1_1:IWindowController_1;
      
      private var _colorStyle:int = int(COLOR_STYLE_DEFAULT.value);
      
      private var _digits:uint = uint(DIGITS_DEFAULT.value);
      
      private var _updateFrequency:int = int(UPDATE_FREQUENCY_DEFAULT.value);
      
      private var _newNumber:int = int(NUMBER_DEFAULT.value);
      
      private var _displayedNumber:Number = 0;
      
      private var _millisSinceLastUpdate:uint = 0;
      
      public function RunningNumberWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRunningNumberWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromRunningNumberWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("running_number_xml").content as XML) as IWindowController_1;
         _windowManager.registerUpdateReceiver(this,_updateFrequency);
         UnknownVarFromRunningNumberWidget_IWidgetWindowController_1.setParamFlag(147456);
         UnknownVarFromRunningNumberWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRunningNumberWidget_IWindowController_1_1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromRunningNumberWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromRunningNumberWidget_IWindowController_1_1.dispose();
               UnknownVarFromRunningNumberWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromRunningNumberWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromRunningNumberWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromRunningNumberWidget_IWidgetWindowController_1 = null;
            }
            _windowManager.removeUpdateReceiver(this);
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(NUMBER_DEFAULT.withValue(colorStyle));
         _loc1_.push(COLOR_STYLE_DEFAULT.withValue(colorStyle));
         _loc1_.push(DIGITS_DEFAULT.withValue(digits));
         _loc1_.push(UPDATE_FREQUENCY_DEFAULT.withValue(updateFrequency));
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
               case "running_number:number":
                  number = int(_loc2_.value);
                  break;
               case "running_number:digits":
                  digits = uint(_loc2_.value);
                  break;
               case "running_number:color_style":
                  colorStyle = int(_loc2_.value);
                  break;
               case "running_number:update_frequency":
                  updateFrequency = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function update(param1:uint) : void
      {
         if(_displayedNumber < number)
         {
            _millisSinceLastUpdate += param1;
            if(_millisSinceLastUpdate > _updateFrequency)
            {
               _displayedNumber = Math.min(_newNumber,_displayedNumber + _millisSinceLastUpdate / _updateFrequency);
               _millisSinceLastUpdate -= _updateFrequency;
            }
            fieldValue = _displayedNumber;
         }
      }
      
      private function set fieldValue(param1:uint) : void
      {
         var _loc3_:String = param1.toString();
         while(_loc3_.length < _digits)
         {
            _loc3_ = "0" + _loc3_;
         }
         var _loc2_:ITextWindow = ITextWindow(UnknownVarFromRunningNumberWidget_IWindowController_1_1.findChildByName("number_field"));
         _loc2_.text = _loc3_;
         _loc2_.invalidate();
      }
      
      public function get digits() : uint
      {
         return _digits;
      }
      
      public function set digits(param1:uint) : void
      {
         _digits = param1;
      }
      
      public function get colorStyle() : int
      {
         return _colorStyle;
      }
      
      public function set colorStyle(param1:int) : void
      {
         _colorStyle = param1;
      }
      
      public function get updateFrequency() : int
      {
         return _updateFrequency;
      }
      
      public function set updateFrequency(param1:int) : void
      {
         _updateFrequency = param1;
      }
      
      public function get number() : int
      {
         return _newNumber;
      }
      
      public function set number(param1:int) : void
      {
         _newNumber = param1;
      }
      
      public function set initialNumber(param1:int) : void
      {
         _displayedNumber = param1;
         _newNumber = param1;
         fieldValue = _displayedNumber;
      }
   }
}

