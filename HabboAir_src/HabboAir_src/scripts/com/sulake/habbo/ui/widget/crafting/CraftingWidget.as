package com.sulake.habbo.ui.widget.crafting
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.FurnitureProductItem;
   import com.sulake.habbo.communication.messages.parser.crafting.OutgoingIngredient;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.CraftingWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInfoController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInventoryListController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingMixerController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingRecipeListController;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class CraftingWidget extends RoomWidgetBase
   {
      public static const MODE_NONE:int = 0;
      
      public static const MODE_SECRET_RECIPE:int = 1;
      
      public static const MODE_PUBLIC_RECIPE:int = 2;
      
      private var _roomUI:RoomUI;
      
      private var UnknownVarFromCraftingWidget_CraftingFurnitureItem_1:CraftingFurnitureItem;
      
      private var UnknownVarFromCraftingWidget_IModalDialog_1:IModalDialog;
      
      private var _itemTemplate:IWindowController_1;
      
      private var _inventoryCtrl:CraftingInventoryListController;
      
      private var _recipeCtrl:CraftingRecipeListController;
      
      private var _mixerCtrl:CraftingMixerController;
      
      private var _infoCtrl:CraftingInfoController;
      
      private var _craftingMode:int = 0;
      
      public function CraftingWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:RoomUI)
      {
         super(param1,param2,assets,localizations);
         _roomUI = param3;
         _inventoryCtrl = new CraftingInventoryListController(this);
         _recipeCtrl = new CraftingRecipeListController(this);
         _mixerCtrl = new CraftingMixerController(this);
         _infoCtrl = new CraftingInfoController(this);
         _assets = param3.assets;
         this.handler.widget = this;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide();
         _roomUI = null;
         if(_inventoryCtrl)
         {
            _inventoryCtrl.dispose();
            _inventoryCtrl = null;
         }
         if(_recipeCtrl)
         {
            _recipeCtrl.dispose();
            _recipeCtrl = null;
         }
         if(_mixerCtrl)
         {
            _mixerCtrl.dispose();
            _mixerCtrl = null;
         }
         if(_infoCtrl)
         {
            _infoCtrl.dispose();
            _infoCtrl = null;
         }
         if(_itemTemplate)
         {
            _itemTemplate.dispose();
            _itemTemplate = null;
         }
         super.dispose();
      }
      
      public function hide() : void
      {
         handler.removeInventoryUpdateEvent();
         _mixerCtrl.clearItems();
         _inventoryCtrl.clearItems();
         _recipeCtrl.clearItems();
         if(craftingInProgress)
         {
            _infoCtrl.cancelCrafting();
         }
         _craftingMode = 0;
         if(UnknownVarFromCraftingWidget_IModalDialog_1 != null)
         {
            UnknownVarFromCraftingWidget_IModalDialog_1.dispose();
            UnknownVarFromCraftingWidget_IModalDialog_1 = null;
         }
      }
      
      private function createMainWindow() : void
      {
         if(window != null)
         {
            return;
         }
         UnknownVarFromCraftingWidget_IModalDialog_1 = windowManager.buildModalDialogFromXML(XML(assets.getAssetByName("craftingwidget_xml").content));
         if(!UnknownVarFromCraftingWidget_IModalDialog_1 || !UnknownVarFromCraftingWidget_IModalDialog_1.rootWindow)
         {
            return;
         }
         var _loc2_:IWindowModel = window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
         var _loc1_:IItemGridWindow = window.findChildByName("itemgrid_products") as IItemGridWindow;
         _itemTemplate = _loc1_.getGridItemAt(0) as IWindowController_1;
         _loc1_.removeGridItem(_itemTemplate);
         window.procedure = onInput;
         window.center();
      }
      
      public function populateInventoryItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         _inventoryCtrl.populateInventoryItems(param1);
      }
      
      public function populateRecipeItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         _recipeCtrl.populateRecipeItems(param1);
      }
      
      public function setInfoState(param1:int, ... rest) : void
      {
         if(_infoCtrl)
         {
            _infoCtrl.setState(param1,rest);
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function setInfoText(param1:String) : void
      {
         var _loc2_:ITextWindow = !!window ? window.findChildByName("header_mixer") as ITextWindow : null;
         if(_loc2_)
         {
            _loc2_.text = param1;
         }
      }
      
      public function showWidget() : void
      {
         if(window)
         {
            return;
         }
         createMainWindow();
         setInfoText("");
         setInfoState(0);
      }
      
      public function showCraftingCategories(param1:Vector.<FurnitureProductItem>, param2:Vector.<String>, param3:IRoomEngine, param4:ISessionDataManager) : void
      {
         var _loc9_:* = undefined;
         var _loc6_:* = null;
         var _loc10_:IFurnitureData = null;
         var _loc12_:IFurnitureData = null;
         var _loc8_:Boolean = false;
         var _loc11_:CraftingFurnitureItem = null;
         var _loc5_:Array = null;
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(_loc6_ in param2)
         {
            _loc8_ = false;
            _loc10_ = param4.getFloorItemDataByName(_loc6_);
            if(!_loc10_)
            {
               _loc10_ = param4.getWallItemDataByName(_loc6_);
               _loc8_ = true;
               if(!_loc10_)
               {
                  continue;
               }
            }
            _loc11_ = new CraftingFurnitureItem(null,null,_loc10_);
            _loc5_ = handler.container.inventory.getNonRentedInventoryIds("furni",_loc11_.typeId,_loc8_);
            if(_loc5_ && _loc5_.length > 0)
            {
               _loc11_.inventoryIds = Vector.<int>(_loc5_);
            }
            _loc9_.push(_loc11_);
         }
         populateInventoryItems(_loc9_);
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(var _loc7_ in param1)
         {
            _loc10_ = param4.getFloorItemDataByName(_loc7_.furnitureClassName);
            _loc12_ = param4.getWallItemDataByName(_loc7_.furnitureClassName);
            if(_loc10_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc10_));
            }
            else if(_loc12_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc12_));
            }
         }
         populateRecipeItems(_loc9_);
      }
      
      public function showCraftableProduct(param1:CraftingFurnitureItem) : void
      {
         UnknownVarFromCraftingWidget_CraftingFurnitureItem_1 = param1;
         if(!UnknownVarFromCraftingWidget_CraftingFurnitureItem_1)
         {
            return;
         }
         setInfoText(!!UnknownVarFromCraftingWidget_CraftingFurnitureItem_1.furnitureData ? UnknownVarFromCraftingWidget_CraftingFurnitureItem_1.furnitureData.localizedName : "");
         handler.getCraftingRecipe(UnknownVarFromCraftingWidget_CraftingFurnitureItem_1.recipeCode,UnknownVarFromCraftingWidget_CraftingFurnitureItem_1.productCode);
      }
      
      public function showCraftingRecipe(param1:Vector.<OutgoingIngredient>) : void
      {
         showCraftableProductView();
         _recipeCtrl.showRecipe(UnknownVarFromCraftingWidget_CraftingFurnitureItem_1,param1);
      }
      
      public function clearMixerItems() : void
      {
         if(_mixerCtrl)
         {
            _mixerCtrl.clearItems();
         }
      }
      
      public function mixerContentChanged(param1:Vector.<int>) : void
      {
         if(param1.length > 0)
         {
            setInfoState(1000);
            handler.getCraftingRecipesAvailable(param1);
         }
         else
         {
            setInfoState(1);
         }
      }
      
      public function showSecretRecipeView() : void
      {
         if(_craftingMode != 1)
         {
            clearMixerItems();
         }
         _craftingMode = 1;
         setInfoText("");
         setInfoState(1);
      }
      
      public function showCraftableProductView() : void
      {
         if(_craftingMode != 2)
         {
            clearMixerItems();
         }
         _craftingMode = 2;
         setInfoState(6);
      }
      
      public function doCrafting() : void
      {
         switch(_craftingMode - 1)
         {
            case 0:
               handler.doCraftingWithMixer();
               break;
            case 1:
               handler.doCraftingWithRecipe();
         }
      }
      
      public function getSelectedIngredients() : Vector.<int>
      {
         return _mixerCtrl.collectSelectedFurnitureIds();
      }
      
      public function get inSecretRecipeMode() : Boolean
      {
         return _craftingMode == 1;
      }
      
      public function get craftingInProgress() : Boolean
      {
         return handler.craftingInProgress;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return handler.inventoryDirty;
      }
      
      public function get itemTemplate() : IWindowController_1
      {
         return _itemTemplate;
      }
      
      public function get handler() : CraftingWidgetHandler
      {
         return _widgetHandler as CraftingWidgetHandler;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return handler.container.sessionDataManager;
      }
      
      public function get inventoryCtrl() : CraftingInventoryListController
      {
         return _inventoryCtrl;
      }
      
      public function get recipeCtrl() : CraftingRecipeListController
      {
         return _recipeCtrl;
      }
      
      public function get mixerCtrl() : CraftingMixerController
      {
         return _mixerCtrl;
      }
      
      public function get infoCtrl() : CraftingInfoController
      {
         return _infoCtrl;
      }
      
      public function get window() : IWindowController_1
      {
         return !!UnknownVarFromCraftingWidget_IModalDialog_1 ? UnknownVarFromCraftingWidget_IModalDialog_1.rootWindow as IWindowController_1 : null;
      }
   }
}

