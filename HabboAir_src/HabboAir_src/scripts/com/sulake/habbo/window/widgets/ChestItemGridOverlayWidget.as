package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.LimitedItemOverlayNumberBitmapGenerator;
   
   public class ChestItemGridOverlayWidget implements IChestItemGridOverlayWidget
   {
      public static const TYPE:String = "chest_overlay_grid";
      
      public static const COLOR_SILVER:String = "silver";
      
      public static const COLOR_GOLD:String = "gold";
      
      public static const COLOR_BROWN:String = "brown";
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _contentsCount:int;
      
      private var _color:String;
      
      public function ChestItemGridOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("chest_overlay_griditem_xml").content)));
         UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromChestItemGridOverlayWidget_IWidgetWindowController_1 = null;
            }
            if(UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1 = null;
            }
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
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function set contentsCount(param1:int) : void
      {
         _contentsCount = param1;
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1.findChildByName("chest_plaque_number_bitmap"));
         _loc2_.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets,_contentsCount,_loc2_.width,_loc2_.height);
      }
      
      public function get contentsCount() : int
      {
         return _contentsCount;
      }
      
      public function set color(param1:String) : void
      {
         _color = param1;
         IStaticBitmapWrapperWindow(UnknownVarFromChestItemGridOverlayWidget_IWindowController_1_1.findChildByName("chest_plaque_bitmap")).assetUri = "chest_overlay_" + param1 + "_plaque";
      }
      
      public function get color() : String
      {
         return _color;
      }
   }
}

