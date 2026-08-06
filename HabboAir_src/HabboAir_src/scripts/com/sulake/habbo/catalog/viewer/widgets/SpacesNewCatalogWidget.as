package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IComponentInterfaceQueue, ICatalogWidget, IItemGrid
   {
      private var _groupNames:Array = ["wallpaper","floor","landscape"];
      
      private var UnknownVarFromSpacesNewCatalogWidget_Array_1:Array = [];
      
      private var _selectedGroup:int = 0;
      
      private var UnknownVarFromSpacesNewCatalogWidget_Array_2:Array = [0,0,0];
      
      private var UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1:ISelectorWindow;
      
      private var _categories:Array = ["group.walls","group.floors","group.views"];
      
      public function SpacesNewCatalogWidget(param1:IWindowController_1, param2:ISessionDataManager, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         for each(var _loc2_ in UnknownVarFromSpacesNewCatalogWidget_Array_1)
         {
            for each(var _loc1_ in _loc2_)
            {
               _loc1_.dispose();
            }
         }
         UnknownVarFromSpacesNewCatalogWidget_Array_1 = null;
      }
      
      override public function init() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowModel = null;
         Logger.log("Init Item Group Catalog Widget (Spaces New)");
         createOfferGroups();
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1 = _window.findChildByName("groups") as ISelectorWindow;
         if(UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1.numSelectables)
            {
               _loc1_ = UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1.getSelectableAt(_loc2_);
               if(_loc1_ is ISelectableWindow)
               {
                  _loc1_.addEventListener("WE_SELECTED",onSelectGroup);
               }
               _loc2_++;
            }
         }
         switchCategory(_categories[_selectedGroup]);
         updateRoomPreview();
         return true;
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc3_:int = int(UnknownVarFromSpacesNewCatalogWidget_Array_2[_selectedGroup]);
         var _loc2_:UnknownIHabboCatalog1 = UnknownVarFromSpacesNewCatalogWidget_Array_1[_selectedGroup][_loc3_];
         this.select(_loc2_.gridItem,false);
      }
      
      public function selectIndex(param1:int) : void
      {
         var _loc2_:UnknownIHabboCatalog1 = null;
         if(param1 > -1 && param1 < _itemGrid.numGridItems)
         {
            _loc2_ = UnknownVarFromSpacesNewCatalogWidget_Array_1[_selectedGroup][param1];
            this.select(_loc2_.gridItem,false);
         }
      }
      
      override public function select(param1:IProductGridItem, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.select(param1,false);
         var _loc3_:UnknownIHabboCatalog1 = (param1 as ProductContainer).offer;
         if(_loc3_ == null)
         {
            return;
         }
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc3_.product.extraParam));
         UnknownVarFromSpacesNewCatalogWidget_Array_2[_selectedGroup] = (UnknownVarFromSpacesNewCatalogWidget_Array_1[_selectedGroup] as Vector.<UnknownIHabboCatalog1>).indexOf(_loc3_);
         updateRoomPreview();
      }
      
      private function updateRoomPreview() : void
      {
         var _loc5_:int = int(UnknownVarFromSpacesNewCatalogWidget_Array_2[0]);
         var _loc6_:int = int(UnknownVarFromSpacesNewCatalogWidget_Array_2[1]);
         var _loc3_:int = int(UnknownVarFromSpacesNewCatalogWidget_Array_2[2]);
         var _loc2_:UnknownIHabboCatalog1 = UnknownVarFromSpacesNewCatalogWidget_Array_1[0].length > _loc5_ ? UnknownVarFromSpacesNewCatalogWidget_Array_1[0][_loc5_] : null;
         var _loc4_:UnknownIHabboCatalog1 = UnknownVarFromSpacesNewCatalogWidget_Array_1[1].length > _loc6_ ? UnknownVarFromSpacesNewCatalogWidget_Array_1[1][_loc6_] : null;
         var _loc1_:UnknownIHabboCatalog1 = UnknownVarFromSpacesNewCatalogWidget_Array_1[2].length > _loc3_ ? UnknownVarFromSpacesNewCatalogWidget_Array_1[2][_loc3_] : null;
         if(!_loc4_ || !_loc2_ || !_loc1_)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc4_.product.extraParam,_loc2_.product.extraParam,_loc1_.product.extraParam,64));
      }
      
      private function createOfferGroups() : Boolean
      {
         var _loc2_:IProduct = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         for each(var _loc1_ in page.offers)
         {
            if(!(_loc1_.pricingModel == "pricing_model_single" || _loc1_.pricingModel == "pricing_model_multi"))
            {
               continue;
            }
            _loc2_ = _loc1_.product;
            if(_loc2_ == null)
            {
               continue;
            }
            _loc3_ = _loc2_.productClassId;
            if(!(_loc2_.productType == "i" || _loc2_.productType == "s"))
            {
               continue;
            }
            if(_loc2_.furnitureData == null)
            {
               continue;
            }
            _loc4_ = _loc2_.furnitureData.className;
            _loc5_ = int(_groupNames.indexOf(_loc4_));
            if(_groupNames.indexOf(_loc4_) == -1)
            {
               _groupNames.push(_loc4_);
            }
            while(UnknownVarFromSpacesNewCatalogWidget_Array_1.length < _groupNames.length)
            {
               UnknownVarFromSpacesNewCatalogWidget_Array_1.push(new Vector.<UnknownIHabboCatalog1>(0));
            }
            switch(_loc4_)
            {
               case "floor":
                  (UnknownVarFromSpacesNewCatalogWidget_Array_1[_loc5_] as Vector.<UnknownIHabboCatalog1>).push(_loc1_);
                  break;
               case "wallpaper":
                  (UnknownVarFromSpacesNewCatalogWidget_Array_1[_loc5_] as Vector.<UnknownIHabboCatalog1>).push(_loc1_);
                  break;
               case "landscape":
                  (UnknownVarFromSpacesNewCatalogWidget_Array_1[_loc5_] as Vector.<UnknownIHabboCatalog1>).push(_loc1_);
                  break;
               default:
                  Logger.log("[Spaces Catalog Widget] : " + _loc4_);
                  break;
            }
         }
         page.replaceOffers(new Vector.<UnknownIHabboCatalog1>(0),false);
         return true;
      }
      
      private function onSelectGroup(param1:WindowEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ISelectableWindow = param1.target as ISelectableWindow;
         if(_loc3_)
         {
            _loc2_ = UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1.getSelectableIndex(_loc3_);
            Logger.log("select: " + [_loc3_.name,_loc2_]);
            switchCategory(_loc3_.name);
         }
      }
      
      private function switchCategory(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1)
         {
            return;
         }
         UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1.setSelected(UnknownVarFromSpacesNewCatalogWidget_ISelectorWindow_1.getSelectableByName(param1));
         var _loc5_:int = -1;
         switch(param1)
         {
            case "group.walls":
               _loc5_ = 0;
               break;
            case "group.floors":
               _loc5_ = 1;
               break;
            case "group.views":
               _loc5_ = 2;
               break;
            default:
               _loc5_ = -1;
         }
         if(_loc5_ > -1)
         {
            if(UnknownVarFromItemGridCatalogWidget_IProductGridItem_1 != null)
            {
               UnknownVarFromItemGridCatalogWidget_IProductGridItem_1.deactivate();
            }
            UnknownVarFromItemGridCatalogWidget_IProductGridItem_1 = null;
            _selectedGroup = _loc5_;
            if(_itemGrid)
            {
               _itemGrid.destroyGridItems();
            }
            _loc2_ = UnknownVarFromSpacesNewCatalogWidget_Array_1[_selectedGroup] == null ? new Vector.<UnknownIHabboCatalog1>(0) : UnknownVarFromSpacesNewCatalogWidget_Array_1[_selectedGroup];
            page.replaceOffers(_loc2_,false);
            resetTimer();
            _loc3_ = populateItemGrid();
            loadItemGridGraphics(null,_loc3_);
            if(UnknownVarFromItemGridCatalogWidget_Timer_1)
            {
               UnknownVarFromItemGridCatalogWidget_Timer_1.start();
            }
            _loc4_ = int(UnknownVarFromSpacesNewCatalogWidget_Array_2[_selectedGroup]);
            selectIndex(_loc4_);
         }
      }
   }
}

