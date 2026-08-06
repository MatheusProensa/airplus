package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class ColourGridCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _colours:Array;
      
      private var _colourGrid:IItemGridWindow;
      
      private var _colourChooserLayout:XML;
      
      private var UnknownVarFromColourGridCatalogWidget_BitmapData_1:BitmapData;
      
      private var UnknownVarFromColourGridCatalogWidget_BitmapData_2:BitmapData;
      
      private var _colourChosen:BitmapData;
      
      private var UnknownVarFromColourGridCatalogWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromColourGridCatalogWidget_String_1:String = "";
      
      private var _colourGridCache:Dictionary = new Dictionary();
      
      public function ColourGridCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(!_colourGrid.disposed)
         {
            _colourGrid.destroyGridItems();
            _colourGrid.dispose();
         }
         _colourGrid = null;
         _colourChooserLayout = null;
         UnknownVarFromColourGridCatalogWidget_IWindowController_1_1 = null;
         events.removeEventListener("COLOUR_ARRAY",onAvailableColours);
         events.removeEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("colourGridWidget");
         var _loc2_:* = _window.tags.indexOf("FIXED") > -1;
         if(!_loc2_)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         _colourGrid = _window.findChildByName("colourGrid") as IItemGridWindow;
         _colourGrid.width = window.width - 6;
         _colourGrid.height = window.height - 6;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("color_chooser_cell") as XmlAsset;
         _colourChooserLayout = _loc1_.content as XML;
         events.addEventListener("COLOUR_ARRAY",onAvailableColours);
         events.addEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         return true;
      }
      
      private function onAvailableColours(param1:CatalogWidgetColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push([_loc4_]);
         }
         var _loc5_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset;
         UnknownVarFromColourGridCatalogWidget_BitmapData_1 = _loc5_.content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         UnknownVarFromColourGridCatalogWidget_BitmapData_2 = _loc3_.content as BitmapData;
         UnknownVarFromColourGridCatalogWidget_String_1 = param1.backgroundAssetName + "\t" + param1.colourAssetName;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(param1.index) as IWindowController_1);
      }
      
      private function onAvailableMultiColours(param1:CatalogWidgetMultiColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push(_loc4_.slice());
         }
         var _loc5_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset;
         UnknownVarFromColourGridCatalogWidget_BitmapData_1 = _loc5_.content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         UnknownVarFromColourGridCatalogWidget_BitmapData_2 = _loc3_.content as BitmapData;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(0) as IWindowController_1);
      }
      
      private function select(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowModel = null;
         Logger.log("[ColourGridCatalogWidget] Select: " + param1);
         if(UnknownVarFromColourGridCatalogWidget_IWindowController_1_1 != null)
         {
            _loc2_ = UnknownVarFromColourGridCatalogWidget_IWindowController_1_1.getChildByName("chosen");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         UnknownVarFromColourGridCatalogWidget_IWindowController_1_1 = param1;
         if(UnknownVarFromColourGridCatalogWidget_IWindowController_1_1 != null)
         {
            _loc2_ = UnknownVarFromColourGridCatalogWidget_IWindowController_1_1.getChildByName("chosen");
         }
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function populateColourGrid() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc3_:IWindowController_1 = null;
         var _loc1_:IBitmapWrapperController = null;
         Logger.log("[ColourGridCatalogWidget] Display colors: " + [_colours.length,_colourGrid.numGridItems]);
         _colourGrid.removeGridItems();
         UnknownVarFromColourGridCatalogWidget_IWindowController_1_1 = null;
         _loc2_ = 0;
         while(_loc2_ < _colours.length)
         {
            _loc4_ = _colours[_loc2_];
            if(_loc4_.length > 0)
            {
               _loc3_ = createColorContainer(_loc4_,_loc2_);
               _colourGrid.addGridItem(_loc3_);
               _loc1_ = _loc3_.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperController;
               if(_loc1_ != null)
               {
                  _loc1_.bitmap = new BitmapData(_colourChosen.width,_colourChosen.height,true,16777215);
                  _loc1_.bitmap.copyPixels(_colourChosen,_colourChosen.rect,new Point(0,0),null,null,true);
                  _loc1_.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      private function createColorContainer(param1:Array, param2:int) : IWindowController_1
      {
         var _loc10_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:String = coloursCacheKey(param1,param2);
         var _loc6_:IWindowController_1 = _colourGridCache[_loc12_];
         if(_loc6_ != null)
         {
            return _loc6_;
         }
         _loc6_ = page.viewer.catalog.windowManager.buildFromXML(_colourChooserLayout) as IWindowController_1;
         _loc6_.addEventListener("WME_CLICK",onClick);
         _loc6_.background = true;
         _loc6_.color = 4294967295;
         _loc6_.width = UnknownVarFromColourGridCatalogWidget_BitmapData_1.width;
         _loc6_.height = UnknownVarFromColourGridCatalogWidget_BitmapData_1.height;
         var _loc9_:IBitmapWrapperController = _loc6_.findChildByTag("BG_BORDER") as IBitmapWrapperController;
         if(_loc9_ != null)
         {
            _loc9_.bitmap = new BitmapData(UnknownVarFromColourGridCatalogWidget_BitmapData_1.width,UnknownVarFromColourGridCatalogWidget_BitmapData_1.height,true,0);
            _loc9_.bitmap.copyPixels(UnknownVarFromColourGridCatalogWidget_BitmapData_1,UnknownVarFromColourGridCatalogWidget_BitmapData_1.rect,new Point(0,0));
         }
         var _loc14_:IBitmapWrapperController = _loc6_.findChildByTag("COLOR_IMAGE") as IBitmapWrapperController;
         if(_loc14_ != null)
         {
            _loc14_.bitmap = new BitmapData(UnknownVarFromColourGridCatalogWidget_BitmapData_2.width,UnknownVarFromColourGridCatalogWidget_BitmapData_2.height,true,0);
            _loc10_ = 255;
            _loc4_ = 255;
            _loc3_ = 255;
            _loc7_ = null;
            _loc5_ = null;
            _loc11_ = int(param1[0]);
            if(_loc11_ >= 0)
            {
               _loc10_ = uint(_loc11_ >> 16 & 0xFF);
               _loc4_ = uint(_loc11_ >> 8 & 0xFF);
               _loc3_ = uint(_loc11_ >> 0 & 0xFF);
            }
            _loc7_ = UnknownVarFromColourGridCatalogWidget_BitmapData_2.clone();
            _loc7_.colorTransform(_loc7_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            if(param1.length > 1)
            {
               _loc8_ = int(param1[1]);
               if(_loc8_ >= 0)
               {
                  _loc10_ = uint(_loc8_ >> 16 & 0xFF);
                  _loc4_ = uint(_loc8_ >> 8 & 0xFF);
                  _loc3_ = uint(_loc8_ >> 0 & 0xFF);
               }
               _loc5_ = UnknownVarFromColourGridCatalogWidget_BitmapData_2.clone();
               _loc5_.colorTransform(_loc5_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            }
            _loc14_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            _loc7_.dispose();
            if(_loc5_ != null)
            {
               _loc13_ = _loc5_.width / 2;
               _loc14_.bitmap.copyPixels(_loc5_,new Rectangle(_loc13_,0,_loc5_.width - _loc13_,_loc5_.height),new Point(_loc5_.width / 2,0));
               _loc5_.dispose();
            }
         }
         _colourGridCache[_loc12_] = _loc6_;
         return _loc6_;
      }
      
      private function coloursCacheKey(param1:Array, param2:int) : String
      {
         var _loc4_:String = UnknownVarFromColourGridCatalogWidget_String_1;
         _loc4_ = _loc4_ + "\t";
         _loc4_ = _loc4_ + param2;
         for each(var _loc3_ in param1)
         {
            _loc4_ += "\t";
            _loc4_ = _loc4_ + _loc3_;
         }
         return _loc4_;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         select(param1.target as IWindowController_1);
         var _loc2_:int = _colourGrid.getGridItemIndex(param1.target as IWindowModel);
         events.dispatchEvent(new CatalogWidgetColourIndexEvent(_loc2_));
      }
   }
}

