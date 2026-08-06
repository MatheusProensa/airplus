package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.recycler.FurniSlotItem;
   import com.sulake.habbo.catalog.recycler.IRecycler;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class InventoryMainView
   {
      private static const COUNTER_MARGIN:int = 3;
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(120,150);
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromInventoryMainView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromInventoryMainView_IFrameController_1:IFrameController;
      
      private var _categoryViewId:String;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_1:IWindowController_1;
      
      private var _subCategoryViewId:String;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_HabboInventory_1:HabboInventory;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_5:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_6:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_7:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_IWindowController_1_8:IWindowController_1;
      
      private var UnknownVarFromInventoryMainView_Dictionary_1:Dictionary;
      
      private var UnknownVarFromInventoryMainView_ITabButtonWindow_1:ITabButtonWindow;
      
      private var UnknownVarFromInventoryMainView_Boolean_1:Boolean;
      
      private var UnknownVarFromInventoryMainView_Int_1:int;
      
      public function InventoryMainView(param1:HabboInventory, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromInventoryMainView_HabboInventory_1 = param1;
         UnknownVarFromInventoryMainView_IAssetLibraryCollection_1 = param3;
         _windowManager = param2;
      }
      
      public function get isVisible() : Boolean
      {
         return !!UnknownVarFromInventoryMainView_IFrameController_1 ? UnknownVarFromInventoryMainView_IFrameController_1.visible : false;
      }
      
      public function get isActive() : Boolean
      {
         return !!UnknownVarFromInventoryMainView_IFrameController_1 ? UnknownVarFromInventoryMainView_IFrameController_1.getStateFlag(1) : false;
      }
      
      public function get emptyContainer() : IWindowController_1
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return null;
         }
         return UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("empty_container") as IWindowController_1;
      }
      
      public function get loadingContainer() : IWindowController_1
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return null;
         }
         return UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("loading_container") as IWindowController_1;
      }
      
      public function get mainContainer() : IWindowController_1
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return null;
         }
         return UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("contentArea") as IWindowController_1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromInventoryMainView_IWindowController_1_3 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_4 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_7 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_6 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_5 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_8 = null;
         UnknownVarFromInventoryMainView_HabboInventory_1 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_1 = null;
         UnknownVarFromInventoryMainView_IWindowController_1_2 = null;
         if(UnknownVarFromInventoryMainView_IFrameController_1)
         {
            UnknownVarFromInventoryMainView_IFrameController_1.dispose();
            UnknownVarFromInventoryMainView_IFrameController_1 = null;
         }
         if(_toolbar)
         {
            if(_toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
            }
            _toolbar = null;
         }
         _windowManager = null;
         UnknownVarFromInventoryMainView_IAssetLibraryCollection_1 = null;
      }
      
      private function getWindow() : IFrameController
      {
         var _loc4_:ISoundAsset = null;
         var _loc1_:XmlAsset = null;
         var _loc2_:ITabContextWindow = null;
         var _loc3_:Array = null;
         var _loc5_:ITabButtonWindow = null;
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            _loc4_ = UnknownVarFromInventoryMainView_IAssetLibraryCollection_1.getAssetByName("inventory_xml");
            _loc1_ = XmlAsset(_loc4_);
            UnknownVarFromInventoryMainView_Dictionary_1 = new Dictionary();
            UnknownVarFromInventoryMainView_IFrameController_1 = _windowManager.buildFromXML(XML(_loc1_.content)) as IFrameController;
            if(UnknownVarFromInventoryMainView_IFrameController_1 != null)
            {
               UnknownVarFromInventoryMainView_IFrameController_1.position = DEFAULT_VIEW_LOCATION;
               UnknownVarFromInventoryMainView_IFrameController_1.visible = false;
               UnknownVarFromInventoryMainView_IFrameController_1.procedure = windowEventProc;
               UnknownVarFromInventoryMainView_IFrameController_1.setParamFlag(65536,UnknownVarFromInventoryMainView_HabboInventory_1.getBoolean("inventory.allow.scaling"));
               extractWindow("furni");
               extractWindow("collectibles");
               extractWindow("pets");
               extractWindow("bots");
               extractWindow("badges");
               _loc2_ = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("tabs") as ITabContextWindow;
               _loc3_ = [];
               while(_loc2_.numTabItems > 0)
               {
                  _loc5_ = _loc2_.getTabItemAt(0);
                  _loc3_.push(_loc5_);
                  _loc2_.removeTabItem(_loc5_);
               }
               for each(_loc5_ in _loc3_)
               {
                  switch(_loc5_.name)
                  {
                     case "collectibles":
                        if(UnknownVarFromInventoryMainView_HabboInventory_1.web3tradeEnabled)
                        {
                           UnknownVarFromInventoryMainView_ITabButtonWindow_1 = _loc5_;
                           UnknownVarFromInventoryMainView_Int_1 = _loc2_.numTabItems;
                           if(UnknownVarFromInventoryMainView_Boolean_1)
                           {
                              _loc2_.addTabItem(_loc5_);
                           }
                        }
                        break;
                     case "bots":
                        if(UnknownVarFromInventoryMainView_HabboInventory_1.getBoolean("inventory.bots.enabled"))
                        {
                           _loc2_.addTabItem(_loc5_);
                        }
                        break;
                     case "rentables":
                        if(!UnknownVarFromInventoryMainView_HabboInventory_1.mergeRentFurni && UnknownVarFromInventoryMainView_HabboInventory_1.getBoolean("duckets.enabled"))
                        {
                           _loc2_.addTabItem(_loc5_);
                        }
                        break;
                     default:
                        _loc2_.addTabItem(_loc5_);
                        break;
                  }
               }
               UnknownVarFromInventoryMainView_HabboInventory_1.preparingInventoryView();
            }
            UnknownVarFromInventoryMainView_HabboInventory_1.updateUnseenItemCounts();
         }
         if(UnknownVarFromInventoryMainView_IFrameController_1.y < 0)
         {
            UnknownVarFromInventoryMainView_IFrameController_1.y = 0;
         }
         if(UnknownVarFromInventoryMainView_IFrameController_1.x < 0)
         {
            UnknownVarFromInventoryMainView_IFrameController_1.x = 0;
         }
         return UnknownVarFromInventoryMainView_IFrameController_1;
      }
      
      public function disableNonTradingTabs(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ITabButtonWindow = null;
         var _loc3_:ITabContextWindow = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("tabs") as ITabContextWindow;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.numTabItems)
         {
            _loc2_ = _loc3_.getTabItemAt(_loc4_);
            if(_loc2_.name != "collectibles" && _loc2_.name != "furni")
            {
               Util.disableSection(_loc2_,param1);
            }
            _loc4_ += 1;
         }
      }
      
      public function showCollectiblesTab(param1:Boolean) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            UnknownVarFromInventoryMainView_Boolean_1 = param1;
            return;
         }
         var _loc2_:ITabContextWindow = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("tabs") as ITabContextWindow;
         if(UnknownVarFromInventoryMainView_Boolean_1 && !param1)
         {
            _loc2_.removeTabItem(UnknownVarFromInventoryMainView_ITabButtonWindow_1);
         }
         else if(!UnknownVarFromInventoryMainView_Boolean_1 && param1)
         {
            _loc2_.addTabItemAt(UnknownVarFromInventoryMainView_ITabButtonWindow_1,UnknownVarFromInventoryMainView_Int_1);
         }
         UnknownVarFromInventoryMainView_Boolean_1 = param1;
      }
      
      public function getCategoryViewId() : String
      {
         return _categoryViewId;
      }
      
      public function getSubCategoryViewId() : String
      {
         return _subCategoryViewId;
      }
      
      public function hideInventory() : void
      {
         UnknownVarFromInventoryMainView_HabboInventory_1.closingInventoryView();
         var _loc1_:IWindowModel = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function showInventory() : void
      {
         var _loc1_:IWindowModel = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         UnknownVarFromInventoryMainView_HabboInventory_1.inventoryViewOpened(_subCategoryViewId && _subCategoryViewId.length > 0 ? _subCategoryViewId : _categoryViewId);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = true, param3:Boolean = false) : Boolean
      {
         var _loc4_:IWindowModel = getWindow();
         if(_loc4_ == null)
         {
            return false;
         }
         if(_loc4_.visible)
         {
            if(_categoryViewId == param1)
            {
               if(param2)
               {
                  if(!WindowToggle.isHiddenByOtherWindows(_loc4_))
                  {
                     hideInventory();
                     return false;
                  }
                  _loc4_.activate();
               }
            }
            else
            {
               setViewToCategory(param1);
            }
         }
         else
         {
            if(param3 && _categoryViewId != null && _categoryViewId != param1)
            {
               setViewToCategory(param1);
            }
            _loc4_.visible = true;
            _loc4_.activate();
            if(param1 != _categoryViewId || !UnknownVarFromInventoryMainView_HabboInventory_1.isInventoryCategoryInit(param1))
            {
               setViewToCategory(param1);
            }
            UnknownVarFromInventoryMainView_HabboInventory_1.inventoryViewOpened(param1);
         }
         return true;
      }
      
      public function activate() : void
      {
         var _loc1_:IWindowModel = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.activate();
      }
      
      public function toggleSubCategoryView(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:IWindowModel = getWindow();
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.visible)
         {
            if(_subCategoryViewId == param1)
            {
               if(param2)
               {
                  _loc3_.visible = false;
               }
            }
            else
            {
               setSubViewToCategory(param1);
            }
         }
         else
         {
            _loc3_.visible = true;
            if(param1 != _subCategoryViewId)
            {
               setSubViewToCategory(param1);
            }
         }
      }
      
      public function updateSubCategoryView() : void
      {
         if(_subCategoryViewId == null)
         {
            return;
         }
         setSubViewToCategory(_subCategoryViewId);
      }
      
      public function setToolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      public function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = ITabContextWindow(param2).selector.getSelected().name;
            if(_loc3_ != _categoryViewId)
            {
               resetUnseenCounters(_categoryViewId);
               UnknownVarFromInventoryMainView_HabboInventory_1.toggleInventoryPage(_loc3_);
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            if(param2.name == "header_button_close")
            {
               hideInventory();
            }
            if(param2.name == "open_catalog_btn")
            {
               UnknownVarFromInventoryMainView_HabboInventory_1.catalog.openCatalog();
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            if(param2.name == "titlebar")
            {
               UnknownVarFromInventoryMainView_IFrameController_1.height = UnknownVarFromInventoryMainView_IFrameController_1.limits.minHeight;
            }
         }
      }
      
      public function updateUnseenFurniCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_3)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_3 = createCounter("furni");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_3,param1);
      }
      
      public function updateUnseenRentedFurniCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_4)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_4 = createCounter("rentables");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_4,param1);
      }
      
      public function updateUnseenPetsCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_6)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_6 = createCounter("pets");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_6,param1);
         UnknownVarFromInventoryMainView_HabboInventory_1.petsModel.updateView();
      }
      
      public function updateUnseenBadgeCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_5)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_5 = createCounter("badges");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_5,param1);
         UnknownVarFromInventoryMainView_HabboInventory_1.badgesModel.updateView();
      }
      
      public function updateUnseenBotCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_7)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_7 = createCounter("bots");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_7,param1);
         UnknownVarFromInventoryMainView_HabboInventory_1.botsModel.updateView();
      }
      
      public function updateUnseenCollectiblesCount(param1:int) : void
      {
         if(!UnknownVarFromInventoryMainView_IFrameController_1)
         {
            return;
         }
         if(!UnknownVarFromInventoryMainView_IWindowController_1_8)
         {
            UnknownVarFromInventoryMainView_IWindowController_1_8 = createCounter("collectibles");
         }
         updateCounter(UnknownVarFromInventoryMainView_IWindowController_1_8,param1);
         UnknownVarFromInventoryMainView_HabboInventory_1.collectiblesModel.updateView();
      }
      
      public function getView(param1:String) : IWindowController_1
      {
         return UnknownVarFromInventoryMainView_Dictionary_1[param1] as IWindowController_1;
      }
      
      private function extractWindow(param1:String) : void
      {
         var _loc2_:IWindowModel = mainContainer.getChildByName(param1);
         if(_loc2_)
         {
            UnknownVarFromInventoryMainView_Dictionary_1[param1] = mainContainer.removeChild(_loc2_);
         }
      }
      
      private function resetUnseenCounters(param1:String) : void
      {
         switch(param1)
         {
            case "furni":
               UnknownVarFromInventoryMainView_HabboInventory_1.furniModel.resetUnseenItems();
               break;
            case "rentables":
               UnknownVarFromInventoryMainView_HabboInventory_1.furniModel.resetUnseenItems();
               break;
            case "pets":
               UnknownVarFromInventoryMainView_HabboInventory_1.petsModel.resetUnseenItems();
               break;
            case "badges":
               UnknownVarFromInventoryMainView_HabboInventory_1.badgesModel.resetUnseenItems();
               break;
            case "collectibles":
               UnknownVarFromInventoryMainView_HabboInventory_1.collectiblesModel.resetUnseenItems();
               break;
            case "bots":
               UnknownVarFromInventoryMainView_HabboInventory_1.botsModel.resetUnseenItems();
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         if(emptyContainer)
         {
            emptyContainer.visible = false;
         }
         if(loadingContainer)
         {
            loadingContainer.visible = false;
         }
         UnknownVarFromInventoryMainView_HabboInventory_1.checkCategoryInitilization(param1);
         if(mainContainer == null)
         {
            return;
         }
         mainContainer.removeChild(UnknownVarFromInventoryMainView_IWindowController_1_1);
         mainContainer.invalidate();
         var _loc2_:IWindowController_1 = UnknownVarFromInventoryMainView_HabboInventory_1.getCategoryWindowContainer(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.addChild(_loc2_);
         _loc2_.height = mainContainer.height;
         UnknownVarFromInventoryMainView_HabboInventory_1.updateView(param1);
         UnknownVarFromInventoryMainView_IWindowController_1_1 = _loc2_;
         _categoryViewId = param1;
         var _loc3_:ITabContextWindow = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("tabs") as ITabContextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selector.setSelected(_loc3_.selector.getSelectableByName(param1));
         emptyFurnimaticSlots();
      }
      
      private function emptyFurnimaticSlots() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FurniSlotItem = null;
         var _loc3_:IRecycler = UnknownVarFromInventoryMainView_HabboInventory_1.catalog.getRecycler();
         if(_loc3_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.numberOfSlots)
            {
               _loc1_ = _loc3_.getSlotContent(_loc2_);
               if(_loc1_ != null)
               {
                  _loc3_.releaseSlot(_loc2_);
               }
               _loc2_++;
            }
         }
      }
      
      private function enableScaling() : void
      {
         UnknownVarFromInventoryMainView_IFrameController_1.height = UnknownVarFromInventoryMainView_IFrameController_1.limits.minHeight;
         UnknownVarFromInventoryMainView_IFrameController_1.setParamFlag(65536,true);
         UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("top_content").setParamFlag(2048,true);
      }
      
      private function disableScaling() : void
      {
         UnknownVarFromInventoryMainView_IFrameController_1.height = UnknownVarFromInventoryMainView_IFrameController_1.limits.minHeight;
         UnknownVarFromInventoryMainView_IFrameController_1.setParamFlag(65536,false);
         UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("top_content").setParamFlag(2048,false);
      }
      
      private function setSubViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         UnknownVarFromInventoryMainView_HabboInventory_1.checkCategoryInitilization(param1);
         var _loc2_:IWindowController_1 = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("subContentArea") as IWindowController_1;
         while(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
         var _loc3_:IWindowController_1 = UnknownVarFromInventoryMainView_HabboInventory_1.getCategorySubWindowContainer(param1);
         if(_loc3_ != null)
         {
            disableScaling();
            _loc2_.visible = true;
            _loc3_.visible = true;
            _loc2_.addChild(_loc3_);
         }
         else
         {
            enableScaling();
            _loc2_.visible = false;
         }
         _loc2_.y = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("top_content").rectangle.bottom + 5;
         resizeToFitContents();
         if(UnknownVarFromInventoryMainView_IFrameController_1.parent != null)
         {
            if(UnknownVarFromInventoryMainView_IFrameController_1.x + UnknownVarFromInventoryMainView_IFrameController_1.width > UnknownVarFromInventoryMainView_IFrameController_1.parent.width)
            {
               UnknownVarFromInventoryMainView_IFrameController_1.x = UnknownVarFromInventoryMainView_IFrameController_1.parent.width - UnknownVarFromInventoryMainView_IFrameController_1.width;
            }
            if(UnknownVarFromInventoryMainView_IFrameController_1.y + UnknownVarFromInventoryMainView_IFrameController_1.height > UnknownVarFromInventoryMainView_IFrameController_1.parent.height)
            {
               UnknownVarFromInventoryMainView_IFrameController_1.y = (UnknownVarFromInventoryMainView_IFrameController_1.parent.height - UnknownVarFromInventoryMainView_IFrameController_1.height) * 0.5;
            }
            if(UnknownVarFromInventoryMainView_IFrameController_1.y < 0)
            {
               UnknownVarFromInventoryMainView_IFrameController_1.y = 0;
            }
         }
         UnknownVarFromInventoryMainView_IWindowController_1_2 = _loc3_;
         _subCategoryViewId = param1;
      }
      
      public function resizeToFitContents() : void
      {
         var _loc1_:IWindowController_1 = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName("subContentArea") as IWindowController_1;
         if(_loc1_.visible)
         {
            _loc1_.height = Util.getLowestPoint(_loc1_);
         }
         else
         {
            _loc1_.height = 0;
         }
         UnknownVarFromInventoryMainView_IFrameController_1.resizeToFitContent();
      }
      
      private function createCounter(param1:String) : IWindowController_1
      {
         var _loc3_:IWindowController_1 = _windowManager.createUnseenItemCounter();
         var _loc2_:IWindowController_1 = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName(param1) as IWindowController_1;
         if(_loc2_)
         {
            _loc2_.addChild(_loc3_);
            _loc3_.x = _loc2_.width - _loc3_.width - 3;
            _loc3_.y = 3;
         }
         return _loc3_;
      }
      
      private function updateCounter(param1:IWindowController_1, param2:int) : void
      {
         var _loc5_:ILabelWindow = null;
         param1.findChildByName("count").caption = param2.toString();
         param1.visible = param2 > 0;
         var _loc3_:String = "";
         switch(param1)
         {
            case UnknownVarFromInventoryMainView_IWindowController_1_7:
               _loc3_ = "bots";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_8:
               _loc3_ = "collectibles";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_6:
               _loc3_ = "pets";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_5:
               _loc3_ = "badges";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_3:
               _loc3_ = "furni";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_4:
               _loc3_ = "rentables";
               break;
            case UnknownVarFromInventoryMainView_IWindowController_1_4:
               _loc3_ = "rentables";
         }
         var _loc4_:IWindowController_1 = UnknownVarFromInventoryMainView_IFrameController_1.findChildByName(_loc3_) as IWindowController_1;
         if(_loc4_)
         {
            _loc5_ = _loc4_.getChildByTag("TITLE") as ILabelWindow;
            if(_loc5_)
            {
               if(param1.visible)
               {
                  _loc5_.margins.right = param1.width + 2 * 3;
               }
               else
               {
                  _loc5_.margins.right = _loc5_.margins.left;
               }
               _loc4_.width = _loc5_.width;
               param1.x = _loc4_.width - param1.width - 3;
            }
         }
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId != "HTIE_ICON_INVENTORY")
         {
            return;
         }
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(_categoryViewId == "pets")
            {
               toggleCategoryView("pets");
            }
            else if(_categoryViewId == "furni")
            {
               toggleCategoryView("furni");
            }
            else if(_categoryViewId == "rentables")
            {
               toggleCategoryView("rentables");
            }
            else if(_categoryViewId == "badges")
            {
               toggleCategoryView("badges");
            }
            else if(_categoryViewId == "bots")
            {
               toggleCategoryView("bots");
            }
            else if(_categoryViewId == "collectibles")
            {
               toggleCategoryView("furni");
            }
            else if(UnknownVarFromInventoryMainView_HabboInventory_1 != null)
            {
               UnknownVarFromInventoryMainView_HabboInventory_1.toggleInventoryPage("furni");
            }
         }
      }
   }
}

