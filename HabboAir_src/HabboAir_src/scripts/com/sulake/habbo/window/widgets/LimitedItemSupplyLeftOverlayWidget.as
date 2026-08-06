package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class LimitedItemSupplyLeftOverlayWidget implements ILimitedItemSupplyLeftOverlayWidget
   {
      public static const TYPE:String = "limited_item_overlay_supply";
      
      private var UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _supplyLeft:int;
      
      private var _seriesSize:int;
      
      public function LimitedItemSupplyLeftOverlayWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_supply_xml").content)));
         UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1;
      }
      
      public function set supplyLeft(param1:int) : void
      {
         _supplyLeft = param1;
         var _loc3_:ITextWindow = UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1.findChildByName("items_left_count") as ITextWindow;
         _loc3_.text = param1.toString();
         var _loc2_:Boolean = false;
         UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1.findChildByName("unique_item_sold_out_bitmap").visible = _loc2_;
      }
      
      public function get supplyLeft() : int
      {
         return _supplyLeft;
      }
      
      public function set serialNumber(param1:int) : void
      {
      }
      
      public function set seriesSize(param1:int) : void
      {
         _seriesSize = param1;
         var _loc2_:ITextWindow = UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1.findChildByName("items_total_count") as ITextWindow;
         _loc2_.text = param1.toString();
      }
      
      public function get serialNumber() : int
      {
         return 0;
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
            if(UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1.dispose();
               UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromLimitedItemSupplyLeftOverlayWidget_IWindowController_1_1 == null;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}

