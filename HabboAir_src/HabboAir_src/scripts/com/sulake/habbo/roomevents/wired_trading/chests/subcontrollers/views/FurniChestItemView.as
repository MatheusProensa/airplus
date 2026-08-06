package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestStorage;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.IChestStorage;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   
   public class FurniChestItemView implements IComponentInterfaceQueue, IFurniChestItemView
   {
      public static var NOT_HOVERED_COLOR:uint = 13355979;
      
      public static var UnknownVarFromFurniChestItemView_Uint_1:uint = 14079702;
      
      private var _disposed:Boolean;
      
      private var _storages:Vector.<ChestStorage>;
      
      private var UnknownVarFromFurniChestItemView_FurniChestView_1:FurniChestView;
      
      private var _active:Boolean = false;
      
      private var UnknownVarFromFurniChestItemView_Boolean_1:Boolean = false;
      
      private var _window:IRegionWindow;
      
      public function FurniChestItemView(param1:IRegionWindow)
      {
         super();
         _window = param1.clone() as IRegionWindow;
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public static function initChestBasedIconUI(param1:IFurniChestItemView, param2:IChestStorage) : void
      {
         var _loc5_:ILimitedItemGridOverlayWidget = null;
         var _loc7_:int = 0;
         var _loc4_:IRarityItemGridOverlayWidget = null;
         if(param2 == null)
         {
            param1.ltdBackgroundBitmap.visible = false;
            param1.ltdOverlayWidget.visible = false;
            param1.rarityOverlayWidget.visible = false;
            param1.furniIcon.visible = false;
            return;
         }
         param1.furniIcon.visible = true;
         var _loc6_:IStuffData = param2.stuffData;
         var _loc8_:* = _loc6_.uniqueSerialNumber > 0;
         param1.ltdBackgroundBitmap.visible = _loc8_;
         param1.ltdOverlayWidget.visible = _loc8_;
         if(_loc8_)
         {
            _loc5_ = param1.ltdOverlayWidget.widget as ILimitedItemGridOverlayWidget;
            _loc5_.serialNumber = _loc6_.uniqueSerialNumber;
            _loc5_.seriesSize = _loc6_.uniqueSeriesSize;
         }
         var _loc3_:* = param2.specialType == 19;
         param1.rarityOverlayWidget.visible = _loc3_;
         if(_loc3_)
         {
            _loc7_ = _loc6_.rarityLevel;
            _loc4_ = param1.rarityOverlayWidget.widget as IRarityItemGridOverlayWidget;
            _loc4_.rarityLevel = _loc7_;
         }
         var _loc9_:IProductIconWidget = param1.furniIcon.widget as IProductIconWidget;
         _loc9_.productInfo = new ChestItemTypeRenderableWrapper(param2.type);
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function initialize(param1:FurniChestView, param2:Vector.<ChestStorage>) : void
      {
         UnknownVarFromFurniChestItemView_FurniChestView_1 = param1;
         _storages = param2;
         initializeUI();
      }
      
      public function get numItems() : int
      {
         return _storages.length == 0 ? 0 : _storages.length;
      }
      
      public function peek() : ChestStorage
      {
         return _storages.length == 0 ? null : _storages[0];
      }
      
      public function remove(param1:ChestStorage) : void
      {
         var _loc2_:int = int(_storages.indexOf(param1));
         if(_loc2_ != -1)
         {
            _storages.removeAt(_loc2_);
         }
         updateUI();
      }
      
      public function add(param1:ChestStorage) : void
      {
         _storages.push(param1);
         updateUI();
      }
      
      private function initializeUI() : void
      {
         var _loc1_:ChestStorage = peek();
         if(_loc1_ == null)
         {
            return;
         }
         initChestBasedIconUI(this,_loc1_);
         updateUI();
         updateColoring();
      }
      
      public function updateUI() : void
      {
         if(numItems > 1)
         {
            numberContainer.visible = true;
            furniQuantity.text = String(numItems);
         }
         else
         {
            numberContainer.visible = false;
         }
      }
      
      public function updateColoring() : void
      {
         focusOutline.visible = _active;
         border.color = UnknownVarFromFurniChestItemView_Boolean_1 ? UnknownVarFromFurniChestItemView_Uint_1 : NOT_HOVERED_COLOR;
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromFurniChestItemView_Boolean_1 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromFurniChestItemView_Boolean_1 = true;
         updateColoring();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFurniChestItemView_FurniChestView_1 != null)
         {
            UnknownVarFromFurniChestItemView_FurniChestView_1.selectItemView(this);
         }
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      public function recycle() : void
      {
         _storages = null;
         _active = false;
         UnknownVarFromFurniChestItemView_Boolean_1 = false;
         UnknownVarFromFurniChestItemView_FurniChestView_1 = null;
      }
      
      public function get chestBasedItemSample() : IChestStorage
      {
         return peek();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _storages = null;
         _window.dispose();
         _window = null;
         _active = false;
         UnknownVarFromFurniChestItemView_Boolean_1 = false;
         UnknownVarFromFurniChestItemView_FurniChestView_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get border() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("border") as UnknownICoreWindowComponents6;
      }
      
      private function get focusOutline() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("outline_focus") as IStaticBitmapWrapperWindow;
      }
      
      public function get ltdBackgroundBitmap() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("unique_item_background_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      public function get furniIcon() : IWidgetWindowController
      {
         return _window.findChildByName("furni_icon") as IWidgetWindowController;
      }
      
      private function get numberContainer() : IWindowController_1
      {
         return _window.findChildByName("number_container") as IWindowController_1;
      }
      
      private function get furniQuantity() : ITextWindow
      {
         return _window.findChildByName("furni_quantity") as ITextWindow;
      }
      
      public function get ltdOverlayWidget() : IWidgetWindowController
      {
         return _window.findChildByName("unique_item_overlay_container") as IWidgetWindowController;
      }
      
      public function get rarityOverlayWidget() : IWidgetWindowController
      {
         return _window.findChildByName("rarity_item_overlay_container") as IWidgetWindowController;
      }
   }
}

