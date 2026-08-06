package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
   
   public class LimitedItemPreviewOverlayWidget implements ILimitedItemPreviewOverlayWidget
   {
      public static const TYPE:String = "limited_item_overlay_preview";
      
      private var UnknownVarFromLimitedItemPreviewOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _serialNumber:int;
      
      private var _seriesSize:int;
      
      public function LimitedItemPreviewOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromLimitedItemPreviewOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_preview_xml").content)));
         UnknownVarFromLimitedItemPreviewOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1;
      }
      
      public function set serialNumber(param1:int) : void
      {
         _serialNumber = param1;
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1.findChildByName("unique_item_serial_number_bitmap"));
         _loc2_.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets,serialNumber,_loc2_.width,_loc2_.height);
      }
      
      public function set seriesSize(param1:int) : void
      {
         _seriesSize = param1;
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1.findChildByName("unique_item_edition_size_bitmap"));
         _loc2_.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets,param1,_loc2_.width,_loc2_.height);
      }
      
      public function get serialNumber() : int
      {
         return _serialNumber;
      }
      
      public function get seriesSize() : int
      {
         return _seriesSize;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromLimitedItemPreviewOverlayWidget_IWindowController_1_1 == null;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

