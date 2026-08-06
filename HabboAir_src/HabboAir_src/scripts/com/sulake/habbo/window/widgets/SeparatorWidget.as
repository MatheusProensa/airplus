package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SeparatorWidget implements ISeparatorWidget
   {
      public static const TYPE:String = "separator";
      
      private static const VERTICAL_KEY:String = "separator:vertical";
      
      private static const BORDER_IMAGE_HORIZONTAL:String = "illumina_light_separator_horizontal";
      
      private static const BORDER_IMAGE_VERTICAL:String = "illumina_light_separator_vertical";
      
      private static const VERTICAL_DEFAULT:PropertyStruct = new PropertyStruct("separator:vertical",false,"Boolean");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromSeparatorWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromSeparatorWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromSeparatorWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromSeparatorWidget_BitmapData_1:BitmapData;
      
      private var _children:IWindowController_1;
      
      private var _vertical:Boolean = Boolean(VERTICAL_DEFAULT.value);
      
      public function SeparatorWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromSeparatorWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromSeparatorWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("separator_xml").content as XML) as IWindowController_1;
         UnknownVarFromSeparatorWidget_IBitmapWrapperController_1 = UnknownVarFromSeparatorWidget_IWindowController_1_1.getChildByName("canvas") as IBitmapWrapperController;
         _children = UnknownVarFromSeparatorWidget_IWindowController_1_1.getChildByName("children") as IWindowController_1;
         UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.addEventListener("WE_RESIZE",onChange);
         UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         UnknownVarFromSeparatorWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromSeparatorWidget_IWindowController_1_1;
         UnknownVarFromSeparatorWidget_IWindowController_1_1.width = UnknownVarFromSeparatorWidget_IWidgetWindowController_1.width;
         UnknownVarFromSeparatorWidget_IWindowController_1_1.height = UnknownVarFromSeparatorWidget_IWidgetWindowController_1.height;
      }
      
      private function onChange(param1:WindowEvent) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromSeparatorWidget_BitmapData_1 != null)
            {
               UnknownVarFromSeparatorWidget_BitmapData_1.dispose();
               UnknownVarFromSeparatorWidget_BitmapData_1 = null;
            }
            if(UnknownVarFromSeparatorWidget_IBitmapWrapperController_1 != null)
            {
               UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.removeEventListener("WE_RESIZE",onChange);
               UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.removeEventListener("WE_RESIZED",onChange);
               UnknownVarFromSeparatorWidget_IBitmapWrapperController_1 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
            if(UnknownVarFromSeparatorWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromSeparatorWidget_IWindowController_1_1.dispose();
               UnknownVarFromSeparatorWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromSeparatorWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromSeparatorWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromSeparatorWidget_IWidgetWindowController_1 = null;
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
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(VERTICAL_DEFAULT.withValue(_vertical));
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
            var _loc3_:* = _loc2_.key;
            if("separator:vertical" === _loc3_)
            {
               vertical = Boolean(_loc2_.value);
            }
         }
      }
      
      public function get vertical() : Boolean
      {
         return _vertical;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         _vertical = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:BitmapData = null;
         var _loc4_:Point = null;
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromSeparatorWidget_BitmapData_1 == null || UnknownVarFromSeparatorWidget_BitmapData_1.width != UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.width || UnknownVarFromSeparatorWidget_BitmapData_1.height != UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.height)
         {
            if(UnknownVarFromSeparatorWidget_BitmapData_1 != null)
            {
               UnknownVarFromSeparatorWidget_BitmapData_1.dispose();
            }
            UnknownVarFromSeparatorWidget_BitmapData_1 = new BitmapData(Math.max(1,UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.width),Math.max(1,UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.height),true,0);
            UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.bitmap = UnknownVarFromSeparatorWidget_BitmapData_1;
         }
         UnknownVarFromSeparatorWidget_BitmapData_1.lock();
         UnknownVarFromSeparatorWidget_BitmapData_1.fillRect(new Rectangle(0,0,UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.width,UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.height),0);
         var _loc3_:BitmapDataAsset = _windowManager.assets.getAssetByName(_vertical ? "illumina_light_separator_vertical" : "illumina_light_separator_horizontal") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.content as BitmapData;
            if(_vertical)
            {
               _loc4_ = new Point(UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.width / 2 - 1,0);
               while(_loc4_.y < UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.height)
               {
                  UnknownVarFromSeparatorWidget_BitmapData_1.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.y += _loc3_.rectangle.height;
               }
            }
            else
            {
               _loc4_ = new Point(0,UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.height / 2 - 1);
               while(_loc4_.x < UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.width)
               {
                  UnknownVarFromSeparatorWidget_BitmapData_1.copyPixels(_loc1_,_loc3_.rectangle,_loc4_);
                  _loc4_.x += _loc3_.rectangle.width;
               }
            }
         }
         for each(var _loc2_ in _children.iterator)
         {
            if(_loc2_.visible)
            {
               UnknownVarFromSeparatorWidget_BitmapData_1.fillRect(_loc2_.rectangle,0);
            }
         }
         UnknownVarFromSeparatorWidget_BitmapData_1.unlock();
         UnknownVarFromSeparatorWidget_IBitmapWrapperController_1.invalidate();
      }
   }
}

