package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class HoverBitmapWidget implements IHoverBitmapWidget
   {
      public static const TYPE:String = "hover_bitmap";
      
      private static const UnknownConstFromHoverBitmapWidget_String_1:String = "hover_bitmap:hover_asset";
      
      private static const NORMAL_ASSET_KEY:String = "hover_bitmap:normal_asset";
      
      private static const HOVER_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:hover_asset",null,"String");
      
      private static const NORMAL_ASSET_DEFAULT:PropertyStruct = new PropertyStruct("hover_bitmap:normal_asset",null,"String");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var _normalAsset:String;
      
      private var _hoverAsset:String;
      
      private var UnknownVarFromHoverBitmapWidget_Boolean_1:Boolean = false;
      
      public function HoverBitmapWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         _bitmap = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("hover_bitmap_xml").content as XML) as IStaticBitmapWrapperWindow;
         _bitmap.addEventListener("WME_OVER",onMouseOver);
         _bitmap.addEventListener("WME_OUT",onMouseOut);
         UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1.rootWindow = _bitmap;
         _bitmap.width = UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1.width;
         _bitmap.height = UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1.height;
         _bitmap.invalidate();
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHoverBitmapWidget_Boolean_1 = true;
         _bitmap.assetUri = _hoverAsset;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHoverBitmapWidget_Boolean_1 = false;
         _bitmap.assetUri = _normalAsset;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_bitmap != null)
            {
               _bitmap.dispose();
               _bitmap = null;
            }
            UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1.rootWindow = null;
            UnknownVarFromHoverBitmapWidget_IWidgetWindowController_1 = null;
            _windowManager = null;
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
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(NORMAL_ASSET_DEFAULT.withValue(_normalAsset));
         _loc2_.push(HOVER_ASSET_DEFAULT.withValue(_hoverAsset));
         if(_bitmap != null)
         {
            for each(var _loc1_ in _bitmap.properties)
            {
               if(_loc1_.key != "asset_uri")
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         return _loc2_;
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
               case "hover_bitmap:normal_asset":
                  normalAsset = String(_loc2_.value);
                  break;
               case "hover_bitmap:hover_asset":
                  hoverAsset = String(_loc2_.value);
                  break;
            }
         }
         if(_bitmap != null)
         {
            _bitmap.properties = param1;
            _bitmap.invalidate();
         }
      }
      
      public function get normalAsset() : String
      {
         return _normalAsset;
      }
      
      public function set normalAsset(param1:String) : void
      {
         _normalAsset = param1;
         if(!UnknownVarFromHoverBitmapWidget_Boolean_1)
         {
            _bitmap.assetUri = _normalAsset;
         }
      }
      
      public function get hoverAsset() : String
      {
         return _hoverAsset;
      }
      
      public function set hoverAsset(param1:String) : void
      {
         _hoverAsset = param1;
         if(UnknownVarFromHoverBitmapWidget_Boolean_1)
         {
            _bitmap.assetUri = _hoverAsset;
         }
      }
      
      public function get bitmapWrapper() : IStaticBitmapWrapperWindow
      {
         return _bitmap;
      }
   }
}

