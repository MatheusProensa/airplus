package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.catalog.recycler.DealPrizeContainer;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.catalog.recycler.PrizeContainer;
   import com.sulake.habbo.catalog.recycler.PrizeLevelContainer;
   import com.sulake.habbo.catalog.recycler.RecycleRewardDisplayWrapper;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import flash.events.TimerEvent;
   
   public class RecyclerPrizesCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid
   {
      private static const STAR_LEVELS:Array = ["bronze","silver","gold","diamond","ruby","pink","green","grey"];
      
      private var _prizes:Array;
      
      private var _itemList:IItemListWindow;
      
      private var _gridItemLayout:XML;
      
      private var _levelItemLayout:XML;
      
      private var UnknownVarFromRecyclerPrizesCatalogWidget_IProductGridItem_1:IProductGridItem;
      
      public function RecyclerPrizesCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _prizes = null;
         _itemList = null;
         _gridItemLayout = null;
         _levelItemLayout = null;
         UnknownVarFromRecyclerPrizesCatalogWidget_IProductGridItem_1 = null;
      }
      
      override public function init() : Boolean
      {
         var _loc2_:XmlAsset = null;
         if(!super.init())
         {
            return false;
         }
         _itemList = _window.findChildByName("itemList") as IItemListWindow;
         _loc2_ = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc2_.content as XML;
         _loc2_ = page.viewer.catalog.assets.getAssetByName("recyclerPrizesWidgetLevelItem") as XmlAsset;
         _levelItemLayout = _loc2_.content as XML;
         var _loc1_:Array = recycler.getPrizeTable(onPrizesReceived);
         if(_loc1_ != null)
         {
            onPrizesReceived(_loc1_);
         }
         return true;
      }
      
      private function onPrizesReceived(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         _prizes = param1;
         populateItemGrid();
         if(_prizes.length > 0 && _prizes[0].prizes.length > 0)
         {
            select(_prizes[0].prizes[0] as IProductGridItem,false);
         }
      }
      
      private function populateItemGrid(param1:TimerEvent = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _prizes.length)
         {
            createLevelItem(_prizes[_loc2_]);
            _loc2_++;
         }
      }
      
      private function createLevelItem(param1:PrizeLevelContainer) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PrizeContainer = null;
         var _loc3_:IWindowController_1 = page.viewer.catalog.windowManager.buildFromXML(_levelItemLayout) as IWindowController_1;
         _itemList.addListItem(_loc3_);
         var _loc4_:IWindowModel = _loc3_.findChildByName("level_title");
         _loc4_.caption = page.viewer.catalog.localization.getLocalization("recycler.prizes.category." + param1.prizeLevelId);
         _loc4_ = _loc3_.findChildByName("level_chances");
         if(param1.prizeLevelId == 1)
         {
            _loc4_.visible = false;
         }
         else
         {
            _loc4_.visible = true;
            _loc4_.caption = page.viewer.catalog.localization.getLocalizationWithParams("recycler.prizes.odds","","odds","1:" + param1.probabilityDenominator);
         }
         _loc3_.findChildByName("level_splitter").visible = param1.prizeLevelId > 1;
         IStaticBitmapWrapperWindow(_loc3_.findChildByName("star_icon")).assetUri = "star_small_" + STAR_LEVELS[param1.prizeLevelId - 1];
         var _loc2_:IItemGridWindow = _loc3_.findChildByName("itemGrid") as IItemGridWindow;
         _loc5_ = 0;
         while(_loc5_ < param1.prizes.length)
         {
            _loc6_ = param1.prizes[_loc5_];
            createPrizeItem(_loc6_,_loc2_);
            _loc5_++;
         }
      }
      
      private function createPrizeItem(param1:PrizeContainer, param2:IItemGridWindow) : void
      {
         if(param1 == null || param2 == null || Boolean(param2.disposed))
         {
            return;
         }
         var _loc3_:IWindowController_1 = page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowController_1;
         _loc3_.findChildByName("clubLevelIcon").visible = false;
         param1.view = _loc3_;
         param1.grid = this;
         param1.setIcon(page.viewer.roomEngine);
         param2.addGridItem(_loc3_);
         param2.height = param2.scrollableRegion.height;
         if(param1 is DealPrizeContainer)
         {
            param2.width = param2.scrollableRegion.width;
         }
      }
      
      public function select(param1:IProductGridItem, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromRecyclerPrizesCatalogWidget_IProductGridItem_1 != null)
         {
            UnknownVarFromRecyclerPrizesCatalogWidget_IProductGridItem_1.deactivate();
         }
         UnknownVarFromRecyclerPrizesCatalogWidget_IProductGridItem_1 = param1;
         param1.activate();
         var _loc3_:IWindowController_1 = window.findChildByName("productView") as IWindowController_1;
         var _loc5_:PrizeContainer = param1 as PrizeContainer;
         var _loc4_:String = "";
         viewProduct(page.viewer.roomEngine,_loc3_,_loc5_.productItemType,_loc5_.productItemTypeId,_loc5_.title,_loc4_);
      }
      
      public function viewProduct(param1:IRoomEngine, param2:IWindowController_1, param3:String, param4:int, param5:String, param6:String) : void
      {
         var _loc7_:IWidgetWindowController = param2.findChildByName("product_viewer") as IWidgetWindowController;
         var _loc8_:IProductImageWidget = _loc7_.widget as IProductImageWidget;
         _loc8_.productInfo = new RecycleRewardDisplayWrapper(param3,param4);
         param2.findChildByName("ctlg_product_name").caption = param5;
         param2.findChildByName("ctlg_description").caption = !!param6 ? param6 : "";
      }
      
      public function startDragAndDrop(param1:IProductGridItem) : Boolean
      {
         return false;
      }
      
      private function get recycler() : IRecycler
      {
         return page.viewer.catalog.getRecycler();
      }
   }
}

