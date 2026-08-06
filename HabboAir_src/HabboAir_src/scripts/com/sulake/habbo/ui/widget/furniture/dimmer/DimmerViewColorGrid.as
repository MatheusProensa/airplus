package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class DimmerViewColorGrid
   {
      private var UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1:IItemGridWindow;
      
      private var UnknownVarFromDimmerViewColorGrid_DimmerView_1:DimmerView;
      
      private var _colorCellXML:XML;
      
      private var _colorCellFrame:BitmapData;
      
      private var UnknownVarFromDimmerViewColorGrid_BitmapData_1:BitmapData;
      
      private var UnknownVarFromDimmerViewColorGrid_BitmapData_2:BitmapData;
      
      private var UnknownVarFromDimmerViewColorGrid_IWindowController_1_1:IWindowController_1;
      
      public function DimmerViewColorGrid(param1:DimmerView, param2:IItemGridWindow, param3:IHabboWindowManagerComponent, param4:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromDimmerViewColorGrid_DimmerView_1 = param1;
         UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1 = param2;
         storeAssets(param4);
         populate(param3);
      }
      
      public function dispose() : void
      {
         UnknownVarFromDimmerViewColorGrid_DimmerView_1 = null;
         UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1 = null;
         _colorCellXML = null;
         _colorCellFrame = null;
         UnknownVarFromDimmerViewColorGrid_BitmapData_1 = null;
         UnknownVarFromDimmerViewColorGrid_BitmapData_2 = null;
      }
      
      public function setSelectedColorIndex(param1:int) : void
      {
         if(UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1 == null)
         {
            return;
         }
         if(param1 < 0 || param1 >= UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1.numGridItems)
         {
            return;
         }
         select(UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1.getGridItemAt(param1) as IWindowController_1);
      }
      
      private function populate(param1:IHabboWindowManagerComponent) : void
      {
         if(UnknownVarFromDimmerViewColorGrid_DimmerView_1 == null || UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1 == null)
         {
            return;
         }
         populateColourGrid(param1);
      }
      
      private function select(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowModel = null;
         if(UnknownVarFromDimmerViewColorGrid_IWindowController_1_1 != null)
         {
            _loc2_ = UnknownVarFromDimmerViewColorGrid_IWindowController_1_1.getChildByName("chosen");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         UnknownVarFromDimmerViewColorGrid_IWindowController_1_1 = param1;
         _loc2_ = UnknownVarFromDimmerViewColorGrid_IWindowController_1_1.getChildByName("chosen");
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function populateColourGrid(param1:IHabboWindowManagerComponent) : void
      {
         var _loc4_:IWindowController_1 = null;
         var _loc8_:IBitmapWrapperController = null;
         var _loc14_:IBitmapWrapperController = null;
         var _loc11_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc7_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc13_:ColorTransform = null;
         var _loc6_:BitmapData = null;
         var _loc9_:IBitmapWrapperController = null;
         UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1.destroyGridItems();
         UnknownVarFromDimmerViewColorGrid_IWindowController_1_1 = null;
         for each(var _loc10_ in colors)
         {
            _loc4_ = param1.buildFromXML(_colorCellXML) as IWindowController_1;
            _loc4_.addEventListener("WME_CLICK",onClick);
            _loc4_.background = true;
            _loc4_.color = 4294967295;
            _loc4_.width = _colorCellFrame.width;
            _loc4_.height = _colorCellFrame.height;
            UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1.addGridItem(_loc4_);
            _loc8_ = _loc4_.findChildByTag("BG_BORDER") as IBitmapWrapperController;
            if(_loc8_ != null)
            {
               _loc8_.bitmap = new BitmapData(_colorCellFrame.width,_colorCellFrame.height,true,0);
               _loc8_.bitmap.copyPixels(_colorCellFrame,_colorCellFrame.rect,new Point(0,0));
            }
            _loc14_ = _loc4_.findChildByTag("COLOR_IMAGE") as IBitmapWrapperController;
            if(_loc14_ != null)
            {
               _loc14_.bitmap = new BitmapData(UnknownVarFromDimmerViewColorGrid_BitmapData_1.width,UnknownVarFromDimmerViewColorGrid_BitmapData_1.height,true,0);
               _loc11_ = uint(_loc10_ >> 16 & 0xFF);
               _loc3_ = uint(_loc10_ >> 8 & 0xFF);
               _loc2_ = uint(_loc10_ >> 0 & 0xFF);
               _loc7_ = _loc11_ / 255 * 1;
               _loc12_ = _loc3_ / 255 * 1;
               _loc5_ = _loc2_ / 255 * 1;
               _loc13_ = new ColorTransform(_loc7_,_loc12_,_loc5_);
               _loc6_ = UnknownVarFromDimmerViewColorGrid_BitmapData_1.clone();
               _loc6_.colorTransform(_loc6_.rect,_loc13_);
               _loc14_.bitmap.copyPixels(_loc6_,_loc6_.rect,new Point(0,0));
            }
            _loc9_ = _loc4_.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperController;
            if(_loc9_ != null)
            {
               _loc9_.bitmap = new BitmapData(UnknownVarFromDimmerViewColorGrid_BitmapData_2.width,UnknownVarFromDimmerViewColorGrid_BitmapData_2.height,true,16777215);
               _loc9_.bitmap.copyPixels(UnknownVarFromDimmerViewColorGrid_BitmapData_2,UnknownVarFromDimmerViewColorGrid_BitmapData_2.rect,new Point(0,0),null,null,true);
               _loc9_.visible = false;
            }
         }
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = UnknownVarFromDimmerViewColorGrid_IItemGridWindow_1.getGridItemIndex(param1.target as IWindowModel);
         setSelectedColorIndex(_loc2_);
         UnknownVarFromDimmerViewColorGrid_DimmerView_1.selectedColorIndex = _loc2_;
      }
      
      private function storeAssets(param1:IAssetLibraryCollection) : void
      {
         var _loc2_:XmlAsset = null;
         var _loc3_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = XmlAsset(param1.getAssetByName("dimmer_color_chooser_cell"));
         _colorCellXML = XML(_loc2_.content);
         _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_frame"));
         _colorCellFrame = BitmapData(_loc3_.content);
         _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_button"));
         UnknownVarFromDimmerViewColorGrid_BitmapData_1 = BitmapData(_loc3_.content);
         _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_selected"));
         UnknownVarFromDimmerViewColorGrid_BitmapData_2 = BitmapData(_loc3_.content);
      }
      
      private function get colors() : Array
      {
         if(UnknownVarFromDimmerViewColorGrid_DimmerView_1 == null)
         {
            return [];
         }
         return UnknownVarFromDimmerViewColorGrid_DimmerView_1.colors;
      }
   }
}

