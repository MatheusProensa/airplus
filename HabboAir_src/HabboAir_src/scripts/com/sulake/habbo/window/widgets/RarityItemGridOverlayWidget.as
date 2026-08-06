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
   
   public class RarityItemGridOverlayWidget implements IRarityItemGridOverlayWidget
   {
      public static const TYPE:String = "rarity_item_overlay_grid";
      
      private var UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _rarityLevel:int;
      
      private var UnknownVarFromRarityItemGridOverlayWidget_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      public function RarityItemGridOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_griditem_xml").content)));
         UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         _rarityLevel = param1;
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1.findChildByName("rarity_item_overlay_plaque_number_bitmap"));
         _loc2_.bitmap = LimitedItemOverlayNumberBitmapGenerator.createBitmap(_windowManager.assets,rarityLevel,_loc2_.width,_loc2_.height);
      }
      
      public function get rarityLevel() : int
      {
         return _rarityLevel;
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
            if(UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromRarityItemGridOverlayWidget_IWidgetWindowController_1 = null;
            }
            if(UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromRarityItemGridOverlayWidget_IWindowController_1_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

