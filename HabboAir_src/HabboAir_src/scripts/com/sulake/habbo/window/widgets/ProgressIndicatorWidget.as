package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.ProgressIndicatorMode;
   import com.sulake.habbo.window.enum.ProgressIndicatorStyle;
   import flash.display.BitmapData;
   
   public class ProgressIndicatorWidget implements IProgressIndicatorWidget
   {
      public static const TYPE:String = "progress_indicator";
      
      private static const STYLE_KEY:String = "progress_indicator:style";
      
      private static const SIZE_KEY:String = "progress_indicator:size";
      
      private static const UnknownConstFromProgressIndicatorWidget_String_1:String = "progress_indicator:position";
      
      private static const MODE_KEY:String = "progress_indicator:mode";
      
      private static const MAXIMUM_SIZE:uint = 1000;
      
      private static const STYLE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:style","flat","String",false,ProgressIndicatorStyle.ALL);
      
      private static const SIZE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:size",1,"uint");
      
      private static const POSITION_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:position",0,"uint");
      
      private static const MODE_DEFAULT:PropertyStruct = new PropertyStruct("progress_indicator:mode","position","String",false,ProgressIndicatorMode.ALL);
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromProgressIndicatorWidget_IItemListWindow_1:IItemListWindow;
      
      private var _position:uint = uint(POSITION_DEFAULT.value);
      
      private var _style:String = String(STYLE_DEFAULT.value);
      
      private var _mode:String = String(MODE_DEFAULT.value);
      
      public function ProgressIndicatorWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromProgressIndicatorWidget_IItemListWindow_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("progress_indicator_xml").content as XML) as IItemListWindow;
         UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1.setParamFlag(147456);
         UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromProgressIndicatorWidget_IItemListWindow_1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromProgressIndicatorWidget_IItemListWindow_1 != null)
            {
               UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.dispose();
               UnknownVarFromProgressIndicatorWidget_IItemListWindow_1 = null;
            }
            if(UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromProgressIndicatorWidget_IWidgetWindowController_1 = null;
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
         _loc1_.push(STYLE_DEFAULT.withValue(_style));
         _loc1_.push(SIZE_DEFAULT.withValue(size));
         _loc1_.push(POSITION_DEFAULT.withValue(_position));
         _loc1_.push(MODE_DEFAULT.withValue(_mode));
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
               case "progress_indicator:style":
                  style = String(_loc2_.value);
                  break;
               case "progress_indicator:size":
                  size = uint(_loc2_.value);
                  break;
               case "progress_indicator:position":
                  position = uint(_loc2_.value);
                  break;
               case "progress_indicator:mode":
                  mode = String(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get style() : String
      {
         return _style;
      }
      
      public function set style(param1:String) : void
      {
         _style = param1;
         refresh();
      }
      
      public function get size() : uint
      {
         return UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.numListItems;
      }
      
      public function set size(param1:uint) : void
      {
         param1 = Math.min(Math.max(param1,1),1000);
         if(param1 != size)
         {
            while(param1 < size)
            {
               UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.removeListItemAt(size - 1);
            }
            while(param1 > size)
            {
               UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.addListItem(UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.getListItemAt(0).clone());
            }
            refresh();
         }
      }
      
      public function get position() : uint
      {
         return _position;
      }
      
      public function set position(param1:uint) : void
      {
         _position = param1;
         refresh();
      }
      
      public function get mode() : String
      {
         return _mode;
      }
      
      public function set mode(param1:String) : void
      {
         _mode = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc2_:* = false;
         var _loc1_:BitmapData = null;
         _loc3_ = 0;
         while(_loc3_ < size)
         {
            _loc4_ = UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.getListItemAt(_loc3_) as IStaticBitmapWrapperWindow;
            switch(_mode)
            {
               case "position":
                  _loc2_ = _loc3_ + 1 == position;
                  break;
               case "progress":
                  _loc2_ = _loc3_ < position;
            }
            _loc4_.assetUri = "progress_disk_" + _style + (_loc2_ ? "_on" : "_off");
            _loc1_ = UnknownICoreWindowUtils4(_loc4_).bitmapData;
            _loc4_.width = _loc1_.width;
            _loc4_.height = _loc1_.height;
            UnknownVarFromProgressIndicatorWidget_IItemListWindow_1.height = _loc1_.height;
            _loc3_++;
         }
      }
   }
}

