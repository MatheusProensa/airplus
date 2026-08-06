package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.utils.getTimer;
   
   public class CountdownWidget implements ICountdownWidget, IProfiler_1
   {
      public static const TYPE:String = "countdown";
      
      private static const RUNNING_KEY:String = "countdown:running";
      
      private static const UnknownConstFromCountdownWidget_String_1:String = "countdown:digits";
      
      private static const UnknownConstFromCountdownWidget_String_2:String = "countdown:seconds";
      
      private static const COLOR_STYLE_KEY:String = "countdown:color_style";
      
      private static const UNIT_KEY_PREFIX:String = "countdown_clock_unit_";
      
      private static const RUNNING_DEFAULT:PropertyStruct = new PropertyStruct("countdown:running",false,"Boolean");
      
      private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:digits",3,"uint");
      
      private static const SECONDS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:seconds",0,"int");
      
      private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("countdown:color_style",0,"int");
      
      private static const UnknownConstFromCountdownWidget_Array_1:Array = ["weeks","days","hours","minutes","seconds"];
      
      private static const UnknownConstFromCountdownWidget_Array_2:Array = [604800,86400,3600,60,1];
      
      private static const UNIT_MAX_VALUES:Array = [100,7,24,60,60];
      
      private static const COLOR_STYLES_VALUES:Array = [0,16777215];
      
      private static const COLOR_STYLES_ETCHING_VALUES:Array = [3003121663,0];
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromCountdownWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromCountdownWidget_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromCountdownWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromCountdownWidget_ITextWindow_1:ITextWindow;
      
      private var _running:Boolean = Boolean(RUNNING_DEFAULT.value);
      
      private var _startSeconds:int = int(SECONDS_DEFAULT.value);
      
      private var _startTime:int = getTimer();
      
      private var _colorStyle:int = int(COLOR_STYLE_DEFAULT.value);
      
      private var _displayedTime:int = -1;
      
      public function CountdownWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromCountdownWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromCountdownWidget_IItemListWindow_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("clock_base_xml").content as XML) as IItemListWindow;
         UnknownVarFromCountdownWidget_IWindowController_1_1 = UnknownVarFromCountdownWidget_IItemListWindow_1.getListItemByName("counter") as IWindowController_1;
         UnknownVarFromCountdownWidget_ITextWindow_1 = UnknownVarFromCountdownWidget_IItemListWindow_1.getListItemByName("separator") as ITextWindow;
         digits = uint(DIGITS_DEFAULT.value);
         _windowManager.registerUpdateReceiver(this,10);
         UnknownVarFromCountdownWidget_IWidgetWindowController_1.setParamFlag(147456);
         UnknownVarFromCountdownWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromCountdownWidget_IItemListWindow_1;
      }
      
      private static function getMaxUnitIndex(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < UnknownConstFromCountdownWidget_Array_2.length - param1)
         {
            if(param2 >= uint(UnknownConstFromCountdownWidget_Array_2[_loc3_]))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromCountdownWidget_IItemListWindow_1 != null)
            {
               UnknownVarFromCountdownWidget_IItemListWindow_1.dispose();
               UnknownVarFromCountdownWidget_IItemListWindow_1 = null;
            }
            if(UnknownVarFromCountdownWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromCountdownWidget_IWindowController_1_1.dispose();
               UnknownVarFromCountdownWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromCountdownWidget_ITextWindow_1 != null)
            {
               UnknownVarFromCountdownWidget_ITextWindow_1.dispose();
               UnknownVarFromCountdownWidget_ITextWindow_1 = null;
            }
            if(UnknownVarFromCountdownWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromCountdownWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromCountdownWidget_IWidgetWindowController_1 = null;
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
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function update(param1:uint) : void
      {
         updateTime();
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(RUNNING_DEFAULT.withValue(_running));
         _loc1_.push(DIGITS_DEFAULT.withValue(digits));
         _loc1_.push(SECONDS_DEFAULT.withValue(seconds));
         _loc1_.push(COLOR_STYLE_DEFAULT.withValue(colorStyle));
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
               case "countdown:running":
                  running = Boolean(_loc2_.value);
                  break;
               case "countdown:digits":
                  digits = uint(_loc2_.value);
                  break;
               case "countdown:seconds":
                  seconds = int(_loc2_.value);
                  break;
               case "countdown:color_style":
                  colorStyle = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get colorStyle() : int
      {
         return _colorStyle;
      }
      
      public function set colorStyle(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowController_1 = null;
         var _loc5_:ITextWindow = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _colorStyle = param1;
         var _loc4_:int = UnknownVarFromCountdownWidget_IItemListWindow_1.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = UnknownVarFromCountdownWidget_IItemListWindow_1.getListItemAt(_loc3_) as IWindowController_1;
            if(_loc2_ != null)
            {
               _loc5_ = _loc2_.getChildByName("unit") as ITextWindow;
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.textColor;
                  _loc7_ = _loc5_.etchingColor;
                  if(colorStyle >= 0 && colorStyle < COLOR_STYLES_VALUES.length)
                  {
                     _loc6_ = uint(COLOR_STYLES_VALUES[colorStyle]);
                     _loc7_ = uint(COLOR_STYLES_ETCHING_VALUES[colorStyle]);
                  }
                  _loc5_.textColor = _loc6_;
                  _loc5_.etchingColor = _loc7_;
               }
            }
            _loc3_++;
         }
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      public function set running(param1:Boolean) : void
      {
         if(_running && !param1)
         {
            _startSeconds = seconds;
         }
         if(!_running && param1)
         {
            _startTime = getTimer();
         }
         _running = param1;
      }
      
      public function get digits() : uint
      {
         return (UnknownVarFromCountdownWidget_IItemListWindow_1.numListItems + 1) / 2;
      }
      
      public function set digits(param1:uint) : void
      {
         var _loc2_:int = 0;
         param1 = Math.max(2,Math.min(4,param1));
         if(param1 != digits)
         {
            UnknownVarFromCountdownWidget_IItemListWindow_1.removeListItems();
            _loc2_ = 0;
            while(_loc2_ < param1)
            {
               if(_loc2_ != 0)
               {
                  UnknownVarFromCountdownWidget_IItemListWindow_1.addListItem(UnknownVarFromCountdownWidget_ITextWindow_1.clone());
               }
               UnknownVarFromCountdownWidget_IItemListWindow_1.addListItem(UnknownVarFromCountdownWidget_IWindowController_1_1.clone());
               _loc2_++;
            }
            updateTime(true);
         }
      }
      
      public function get seconds() : int
      {
         return _running ? Math.max(0,_startSeconds - (getTimer() - _startTime) / 1000) : _startSeconds;
      }
      
      public function set seconds(param1:int) : void
      {
         _startSeconds = param1;
         _startTime = getTimer();
         updateTime();
      }
      
      private function updateTime(param1:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:IWindowController_1 = null;
         var _loc7_:int = 0;
         var _loc6_:int = seconds;
         if(_loc6_ == _displayedTime && !param1)
         {
            return;
         }
         var _loc4_:int = int(digits);
         var _loc2_:int = getMaxUnitIndex(_loc4_,_loc6_);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = _loc2_ + _loc5_;
            _loc3_ = UnknownVarFromCountdownWidget_IItemListWindow_1.getListItemAt(_loc5_ * 2) as IWindowController_1;
            _loc7_ = _loc6_ / UnknownConstFromCountdownWidget_Array_2[_loc8_] % UNIT_MAX_VALUES[_loc8_];
            _loc3_.getChildByName("value").caption = (_loc7_ < 10 ? "0" : "") + _loc7_.toString();
            _loc3_.getChildByName("unit").caption = "${countdown_clock_unit_" + UnknownConstFromCountdownWidget_Array_1[_loc8_] + "}";
            _loc5_++;
         }
         _displayedTime = _loc6_;
      }
   }
}

