package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class LimitedItemGridOverlayWidget implements ILimitedItemGridOverlayWidget, IProfiler_1
   {
      public static const TYPE:String = "limited_item_overlay_grid";
      
      private const SHINE_INTERVAL_MS:uint = 10000;
      
      private const SHINE_LENGTH_MS:uint = 250;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1:BitmapData;
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _serialNumber:int;
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_Uint_1:uint = getTimer();
      
      private var UnknownVarFromLimitedItemGridOverlayWidget_Uint_2:uint = UnknownVarFromLimitedItemGridOverlayWidget_Uint_1;
      
      private var _animated:Boolean = false;
      
      public function LimitedItemGridOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1 = BitmapData(_windowManager.assets.getAssetByName("unique_item_label_plaque_metal").content).clone();
         UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_griditem_xml").content)));
         UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1 = IBitmapWrapperController(UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1.findChildByName("unique_item_overlay_plaque_background_bitmap"));
         UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.bitmap = UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1;
         UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(_animated)
            {
               _windowManager.removeUpdateReceiver(this);
            }
            if(UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromLimitedItemGridOverlayWidget_IWidgetWindowController_1 = null;
            }
            if(UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set serialNumber(param1:int) : void
      {
         _serialNumber = param1;
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromLimitedItemGridOverlayWidget_IWindowController_1_1.findChildByName("unique_item_overlay_plaque_number_bitmap"));
         _loc2_.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets,serialNumber,_loc2_.width,_loc2_.height);
      }
      
      public function set seriesSize(param1:int) : void
      {
      }
      
      public function get serialNumber() : int
      {
         return _serialNumber;
      }
      
      public function get seriesSize() : int
      {
         return 0;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get animated() : Boolean
      {
         return _animated;
      }
      
      public function set animated(param1:Boolean) : void
      {
         _animated = param1;
         if(_animated)
         {
            _windowManager.registerUpdateReceiver(this,5);
         }
         else
         {
            _windowManager.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(!disposed)
         {
            UnknownVarFromLimitedItemGridOverlayWidget_Uint_1 += param1;
            if(UnknownVarFromLimitedItemGridOverlayWidget_Uint_1 - UnknownVarFromLimitedItemGridOverlayWidget_Uint_2 > 10000)
            {
               _loc2_ = new BitmapData(UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.width,UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.height,false);
               _loc3_ = (UnknownVarFromLimitedItemGridOverlayWidget_Uint_1 - UnknownVarFromLimitedItemGridOverlayWidget_Uint_2 - 10000) / 250;
               if(_loc3_ < 1)
               {
                  _loc4_ = (UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1.height - UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.height) * _loc3_;
                  _loc2_.copyPixels(UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1,new Rectangle(0,_loc4_,UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.width,UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.height),new Point(0,0));
                  UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.bitmap = _loc2_;
               }
               else
               {
                  UnknownVarFromLimitedItemGridOverlayWidget_IBitmapWrapperController_1.bitmap = UnknownVarFromLimitedItemGridOverlayWidget_BitmapData_1;
                  UnknownVarFromLimitedItemGridOverlayWidget_Uint_2 = UnknownVarFromLimitedItemGridOverlayWidget_Uint_1;
               }
            }
         }
      }
   }
}

