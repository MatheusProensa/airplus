package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetsView implements IInventoryView, UnknownIHabboRoom1
   {
      private static const UnknownConstFromPetsView_Int_1:int = -1;
      
      private static const UnknownConstFromPetsView_Int_2:int = -1;
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromPetsView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromPetsView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromPetsView_PetsModel_1:PetsModel;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromPetsView_IItemGridWindow_1:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _gridItems:Map;
      
      private var UnknownVarFromPetsView_PetsGridItem_1:PetsGridItem;
      
      private var UnknownVarFromPetsView_Int_1:int = 0;
      
      private var UnknownVarFromPetsView_Int_2:int;
      
      private var UnknownVarFromPetsView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromPetsView_Int_3:int = -1;
      
      private var UnknownVarFromPetsView_Array_1:Array = [-1];
      
      private var _ignoreTypeFilterEvents:Boolean = false;
      
      private var UnknownVarFromPetsView_Int_4:int = -1;
      
      private var UnknownVarFromPetsView_Array_2:Array = [-1];
      
      private var _ignoreRarityFilterEvents:Boolean = false;
      
      public function PetsView(param1:PetsModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IRoomEngine)
      {
         super();
         UnknownVarFromPetsView_PetsModel_1 = param1;
         UnknownVarFromPetsView_IAssetLibraryCollection_1 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _gridItems = new Map();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return UnknownVarFromPetsView_IWindowController_1_1 && UnknownVarFromPetsView_IWindowController_1_1.parent != null && UnknownVarFromPetsView_IWindowController_1_1.visible;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            UnknownVarFromPetsView_PetsModel_1 = null;
            UnknownVarFromPetsView_IWindowController_1_1 = null;
            _disposed = true;
         }
      }
      
      public function update() : void
      {
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            return;
         }
         updateGrid();
         updatePreview(UnknownVarFromPetsView_PetsGridItem_1);
         updateContainerVisibility();
      }
      
      public function removePet(param1:int) : void
      {
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            return;
         }
         var _loc2_:PetsGridItem = _gridItems.remove(param1) as PetsGridItem;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromPetsView_IItemGridWindow_1.removeGridItem(_loc2_.window);
         if(UnknownVarFromPetsView_PetsGridItem_1 == _loc2_)
         {
            UnknownVarFromPetsView_PetsGridItem_1 = null;
            selectFirst();
         }
      }
      
      public function addPet(param1:PetData) : void
      {
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(_gridItems.getValue(param1.id) != null)
         {
            return;
         }
         var _loc2_:PetsGridItem = new PetsGridItem(this,param1,_windowManager,UnknownVarFromPetsView_IAssetLibraryCollection_1,UnknownVarFromPetsView_PetsModel_1.isUnseen(param1.id));
         if(_loc2_ != null)
         {
            UnknownVarFromPetsView_IItemGridWindow_1.addGridItem(_loc2_.window);
            _gridItems.add(param1.id,_loc2_);
            if(UnknownVarFromPetsView_PetsGridItem_1 == null)
            {
               selectFirst();
            }
         }
      }
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : void
      {
         UnknownVarFromPetsView_PetsModel_1.placePetToRoom(param1,param2);
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            init();
         }
         if(UnknownVarFromPetsView_IWindowController_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromPetsView_IWindowController_1_1.disposed)
         {
            return null;
         }
         return UnknownVarFromPetsView_IWindowController_1_1;
      }
      
      public function setSelectedGridItem(param1:PetsGridItem) : void
      {
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromPetsView_PetsGridItem_1 != null)
         {
            UnknownVarFromPetsView_PetsGridItem_1.setSelected(false);
         }
         UnknownVarFromPetsView_PetsGridItem_1 = param1;
         if(UnknownVarFromPetsView_PetsGridItem_1 != null)
         {
            UnknownVarFromPetsView_PetsGridItem_1.setSelected(true);
         }
         updatePreview(param1);
      }
      
      public function updateState() : void
      {
         var _loc2_:int = 0;
         if(!UnknownVarFromPetsView_Boolean_1)
         {
            return;
         }
         var _loc1_:Map = UnknownVarFromPetsView_PetsModel_1.pets;
         if(!UnknownVarFromPetsView_PetsModel_1.isListInitialized())
         {
            _loc2_ = 1;
         }
         else if(!_loc1_ || _loc1_.length == 0)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         if(UnknownVarFromPetsView_Int_1 == _loc2_)
         {
            return;
         }
         UnknownVarFromPetsView_Int_1 = _loc2_;
         updateContainerVisibility();
         if(UnknownVarFromPetsView_Int_1 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getPetImage(param1:PetData, param2:int, param3:Boolean, param4:PetsGridItem = null, param5:int = 64, param6:String = null) : BitmapData
      {
         var _loc9_:int = 0;
         var _loc10_:PetFigureData = param1.figureData;
         var _loc7_:BitmapData = null;
         var _loc8_:uint = parseInt(_loc10_.color,16);
         var _loc11_:uint = 0;
         var _loc13_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _loc10_.customPartCount * 3)
         {
            _loc13_.push(new PetCustomPart(_loc10_.customParts[_loc9_],_loc10_.customParts[_loc9_ + 1],_loc10_.customParts[_loc9_ + 2]));
            _loc9_ += 3;
         }
         var _loc12_:UnknownHabboRoom1 = _roomEngine.getPetImage(_loc10_.typeId,_loc10_.paletteId,_loc8_,new Vector3d(param2 * 45),param5,this,param3,_loc11_,_loc13_,param6);
         if(_loc12_ != null)
         {
            _loc7_ = _loc12_.data;
            if(param4 != null)
            {
               param4.imageDownloadId = _loc12_.id;
            }
            else if(param3)
            {
               UnknownVarFromPetsView_Int_2 = _loc12_.id;
            }
         }
         if(_loc7_ == null)
         {
            _loc7_ = new BitmapData(30,30,false,4289374890);
         }
         return _loc7_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == UnknownVarFromPetsView_Int_2)
         {
            updatePreview(UnknownVarFromPetsView_PetsGridItem_1);
            return;
         }
         for each(var _loc3_ in _gridItems)
         {
            if(_loc3_.imageDownloadId == param1)
            {
               _loc3_.setPetImage(param2);
               return;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function selectFirst() : void
      {
         var _loc1_:Array = getVisiblePetIds();
         if(_loc1_.length == 0)
         {
            updatePreview();
            return;
         }
         setSelectedGridItem(_gridItems.getValue(_loc1_[0]));
      }
      
      public function selectById(param1:int) : void
      {
         setSelectedGridItem(_gridItems.getValue(param1));
      }
      
      private function updateGrid() : void
      {
         var _loc6_:int = 0;
         var _loc5_:PetsGridItem = null;
         if(UnknownVarFromPetsView_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = !!UnknownVarFromPetsView_PetsModel_1.pets ? UnknownVarFromPetsView_PetsModel_1.pets.getKeys() : [];
         UnknownVarFromPetsView_IItemGridWindow_1.lock();
         for each(_loc6_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc6_) == -1)
            {
               removePet(_loc6_);
            }
         }
         for each(_loc6_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc6_) == -1)
            {
               addPet(UnknownVarFromPetsView_PetsModel_1.pets.getValue(_loc6_));
            }
            _loc5_ = _gridItems.getValue(_loc6_);
            _loc5_.setUnseen(UnknownVarFromPetsView_PetsModel_1.isUnseen(_loc6_));
         }
         updateFilterOptions();
         var _loc3_:Array = getVisiblePetIds(_loc2_);
         UnknownVarFromPetsView_IItemGridWindow_1.removeGridItems();
         for each(_loc6_ in _loc3_)
         {
            UnknownVarFromPetsView_IItemGridWindow_1.addGridItem(PetsGridItem(_gridItems.getValue(_loc6_)).window);
         }
         UnknownVarFromPetsView_IItemGridWindow_1.unlock();
         var _loc4_:int = int(UnknownVarFromPetsView_PetsGridItem_1 != null && UnknownVarFromPetsView_PetsGridItem_1.pet != null ? UnknownVarFromPetsView_PetsGridItem_1.pet.id : -1);
         if(_loc4_ == -1 || _loc3_.indexOf(_loc4_) == -1)
         {
            if(UnknownVarFromPetsView_PetsGridItem_1 != null)
            {
               UnknownVarFromPetsView_PetsGridItem_1.setSelected(false);
               UnknownVarFromPetsView_PetsGridItem_1 = null;
            }
            selectFirst();
         }
      }
      
      private function startPlacingHandler(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromPetsView_PetsGridItem_1 == null)
         {
            return;
         }
         var _loc2_:PetData = UnknownVarFromPetsView_PetsGridItem_1.pet;
         if(_loc2_ == null)
         {
            return;
         }
         placePetToRoom(_loc2_.id);
      }
      
      private function updateContainerVisibility() : void
      {
         if(UnknownVarFromPetsView_PetsModel_1.controller.currentCategoryId != "pets")
         {
            return;
         }
         var _loc2_:IWindowController_1 = UnknownVarFromPetsView_PetsModel_1.controller.view.loadingContainer;
         var _loc5_:IWindowController_1 = UnknownVarFromPetsView_PetsModel_1.controller.view.emptyContainer;
         var _loc4_:IWindowModel = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("options_container");
         var _loc1_:IWindowModel = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter.rarity");
         var _loc6_:IWindowModel = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("grid");
         var _loc3_:IWindowModel = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_container");
         switch(UnknownVarFromPetsView_Int_1 - 1)
         {
            case 0:
               if(_loc2_)
               {
                  _loc2_.visible = true;
               }
               if(_loc5_)
               {
                  _loc5_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               _loc6_.visible = false;
               _loc3_.visible = false;
               break;
            case 1:
               if(_loc2_)
               {
                  _loc2_.visible = false;
               }
               if(_loc5_)
               {
                  _loc5_.visible = true;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               _loc6_.visible = false;
               _loc3_.visible = false;
               break;
            case 2:
               if(_loc2_)
               {
                  _loc2_.visible = false;
               }
               if(_loc5_)
               {
                  _loc5_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = true;
               }
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               _loc6_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function updatePreview(param1:PetsGridItem = null) : void
      {
         var _loc15_:BitmapData = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         var _loc11_:Boolean = false;
         var _loc16_:PetData = null;
         var _loc3_:BitmapData = null;
         if(UnknownVarFromPetsView_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc5_:int = 64;
         var _loc17_:int = 4;
         var _loc14_:Boolean = true;
         var _loc4_:String = null;
         UnknownVarFromPetsView_Int_2 = -1;
         if(param1 == null || param1.pet == null)
         {
            _loc15_ = new BitmapData(1,1);
            _loc8_ = "";
            _loc7_ = "";
            _loc11_ = false;
         }
         else
         {
            _loc16_ = param1.pet;
            _loc8_ = _loc16_.name;
            _loc7_ = getPetTypeLabel(_loc16_.typeId);
            if(_loc16_.typeId == 16)
            {
               _loc17_ = 2;
               _loc14_ = true;
               if(_loc16_.level >= 7)
               {
                  _loc4_ = "std";
               }
               else
               {
                  _loc4_ = "grw" + _loc16_.level;
               }
            }
            _loc15_ = getPetImage(_loc16_,_loc17_,_loc14_,null,_loc5_,_loc4_);
            _loc11_ = true;
         }
         var _loc10_:IBitmapWrapperController = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_image") as IBitmapWrapperController;
         if(_loc10_ != null)
         {
            _loc3_ = new BitmapData(_loc10_.width,_loc10_.height);
            _loc3_.fillRect(_loc3_.rect,0);
            _loc3_.copyPixels(_loc15_,_loc15_.rect,new Point(_loc3_.width / 2 - _loc15_.width / 2,_loc3_.height / 2 - _loc15_.height / 2));
            _loc10_.bitmap = _loc3_;
         }
         _loc15_.dispose();
         var _loc6_:ITextWindow = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_text") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc8_;
         }
         _loc6_ = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_description") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc7_;
         }
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         if(UnknownVarFromPetsView_PetsModel_1.roomSession != null)
         {
            _loc12_ = UnknownVarFromPetsView_PetsModel_1.roomSession.arePetsAllowed;
            _loc13_ = UnknownVarFromPetsView_PetsModel_1.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc13_)
         {
            if(_loc12_)
            {
               _loc2_ = "${inventory.pets.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.pets.forbidden}";
            }
         }
         _loc6_ = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_info") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc9_:UnknownICoreWindowComponents4 = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("place_button") as UnknownICoreWindowComponents4;
         if(_loc9_ != null)
         {
            if(_loc11_ && (_loc13_ || _loc12_))
            {
               _loc9_.enable();
            }
            else
            {
               _loc9_.disable();
            }
         }
      }
      
      private function init() : void
      {
         var _loc1_:UnknownICoreWindowComponents4 = null;
         UnknownVarFromPetsView_IWindowController_1_1 = UnknownVarFromPetsView_PetsModel_1.controller.view.getView("pets");
         UnknownVarFromPetsView_IWindowController_1_1.visible = false;
         UnknownVarFromPetsView_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromPetsView_IItemGridWindow_1 = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("grid") as IItemGridWindow;
         UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter").caption = "";
         UnknownVarFromPetsView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
         updateFilterOptions();
         _loc1_ = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("place_button") as UnknownICoreWindowComponents4;
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",startPlacingHandler);
         }
         var _loc2_:IBitmapWrapperController = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("preview_image") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_DOWN",startPlacingHandler);
         }
         updatePreview();
         updateState();
         UnknownVarFromPetsView_Boolean_1 = true;
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:WindowKeyboardEvent = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            var _loc6_:* = param2.name;
            if("clear_filter_button" === _loc6_)
            {
               UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter").caption = "";
               param2.visible = false;
               update();
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc5_ = param1 as WindowKeyboardEvent;
            _loc6_ = param2.name;
            if("filter" === _loc6_)
            {
               UnknownVarFromPetsView_IWindowController_1_1.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc5_.keyCode == 27)
               {
                  param2.caption = "";
                  UnknownVarFromPetsView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
                  update();
               }
               else if(_loc5_.keyCode == 13)
               {
                  update();
               }
            }
         }
         else if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "filter.options":
                  if(!_ignoreTypeFilterEvents)
                  {
                     _loc3_ = getSelectedTypeFilter(param2 as IDropBaseController_1);
                     if(_loc3_ != UnknownVarFromPetsView_Int_3)
                     {
                        UnknownVarFromPetsView_Int_3 = _loc3_;
                        update();
                     }
                  }
                  break;
               case "filter.rarity":
                  if(!_ignoreRarityFilterEvents)
                  {
                     _loc4_ = getSelectedRarityFilter(param2 as IDropBaseController_1);
                     if(_loc4_ != UnknownVarFromPetsView_Int_4)
                     {
                        UnknownVarFromPetsView_Int_4 = _loc4_;
                        update();
                     }
                     break;
                  }
            }
         }
      }
      
      private function updateFilterOptions() : void
      {
         var _loc2_:int = 0;
         var _loc3_:IDropBaseController_1 = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
         if(_loc3_ == null)
         {
            return;
         }
         UnknownVarFromPetsView_Array_1 = getAvailableTypeFilterIds();
         if(UnknownVarFromPetsView_Array_1.indexOf(UnknownVarFromPetsView_Int_3) == -1)
         {
            UnknownVarFromPetsView_Int_3 = -1;
         }
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromPetsView_PetsModel_1.controller.localization.getLocalization("inventory.pets.filter.type.all","All types"));
         _loc2_ = 1;
         while(_loc2_ < UnknownVarFromPetsView_Array_1.length)
         {
            _loc1_.push(getPetTypeLabel(int(UnknownVarFromPetsView_Array_1[_loc2_])));
            _loc2_++;
         }
         _ignoreTypeFilterEvents = true;
         try
         {
            _loc3_.populate(_loc1_);
            _loc3_.selection = Math.max(0,UnknownVarFromPetsView_Array_1.indexOf(UnknownVarFromPetsView_Int_3));
         }
         finally
         {
            _ignoreTypeFilterEvents = false;
         }
         updateRarityFilterOptions();
      }
      
      private function updateRarityFilterOptions() : void
      {
         var _loc2_:int = 0;
         var _loc3_:IDropBaseController_1 = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter.rarity") as IDropBaseController_1;
         if(_loc3_ == null)
         {
            return;
         }
         UnknownVarFromPetsView_Array_2 = getAvailableRarityFilterIds();
         if(UnknownVarFromPetsView_Array_2.indexOf(UnknownVarFromPetsView_Int_4) == -1)
         {
            UnknownVarFromPetsView_Int_4 = -1;
         }
         var _loc1_:Array = [];
         for each(var _loc4_ in UnknownVarFromPetsView_Array_2)
         {
            _loc1_.push(getRarityFilterLabel(_loc4_));
         }
         _ignoreRarityFilterEvents = true;
         try
         {
            _loc2_ = isRarityFilterEnabled() ? UnknownVarFromPetsView_Int_4 : -1;
            _loc3_.populate(_loc1_);
            _loc3_.selection = Math.max(0,UnknownVarFromPetsView_Array_2.indexOf(_loc2_));
         }
         finally
         {
            _ignoreRarityFilterEvents = false;
         }
         if(isRarityFilterEnabled())
         {
            _loc3_.enable();
         }
         else
         {
            _loc3_.disable();
         }
      }
      
      private function getAvailableTypeFilterIds() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Map = UnknownVarFromPetsView_PetsModel_1.pets;
         if(_loc2_ != null)
         {
            for each(var _loc3_ in _loc2_)
            {
               if(_loc1_.indexOf(_loc3_.typeId) == -1)
               {
                  _loc1_.push(_loc3_.typeId);
               }
            }
         }
         _loc1_.sort(16);
         _loc1_.unshift(-1);
         return _loc1_;
      }
      
      private function getAvailableRarityFilterIds() : Array
      {
         var _loc1_:Array = [-1];
         var _loc2_:Map = UnknownVarFromPetsView_PetsModel_1.pets;
         if(_loc2_ != null)
         {
            for each(var _loc3_ in _loc2_)
            {
               if(!(_loc3_.typeId != 16 || _loc3_.rarityLevel < 0))
               {
                  if(_loc1_.indexOf(_loc3_.rarityLevel) == -1)
                  {
                     _loc1_.push(_loc3_.rarityLevel);
                  }
               }
            }
         }
         _loc1_.sort(16);
         if(_loc1_.indexOf(-1) > 0)
         {
            _loc1_.splice(_loc1_.indexOf(-1),1);
            _loc1_.unshift(-1);
         }
         return _loc1_;
      }
      
      private function getVisiblePetIds(param1:Array = null) : Array
      {
         var _loc5_:PetData = null;
         var _loc2_:Array = [];
         var _loc3_:Array = param1 ?? (UnknownVarFromPetsView_PetsModel_1.pets != null ? UnknownVarFromPetsView_PetsModel_1.pets.getKeys() : []);
         for each(var _loc4_ in _loc3_)
         {
            _loc5_ = UnknownVarFromPetsView_PetsModel_1.pets.getValue(_loc4_);
            if(passesFilter(_loc5_))
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      private function passesFilter(param1:PetData) : Boolean
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(param1 == null)
         {
            return false;
         }
         if(UnknownVarFromPetsView_Int_3 != -1 && param1.typeId != UnknownVarFromPetsView_Int_3)
         {
            return false;
         }
         if(isRarityFilterEnabled() && UnknownVarFromPetsView_Int_4 != -1 && param1.rarityLevel != UnknownVarFromPetsView_Int_4)
         {
            return false;
         }
         var _loc3_:String = getSearchTerm();
         if(_loc3_.length > 0)
         {
            _loc2_ = param1.name != null ? param1.name.toLowerCase() : "";
            _loc4_ = getPetTypeLabel(param1.typeId).toLowerCase();
            if(_loc2_.indexOf(_loc3_) == -1 && _loc4_.indexOf(_loc3_) == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getSearchTerm() : String
      {
         var _loc1_:ITextWindow = UnknownVarFromPetsView_IWindowController_1_1.findChildByName("filter") as ITextWindow;
         return _loc1_ != null ? _loc1_.caption.toLowerCase() : "";
      }
      
      private function getSelectedTypeFilter(param1:IDropBaseController_1) : int
      {
         if(param1 == null || UnknownVarFromPetsView_Array_1 == null || UnknownVarFromPetsView_Array_1.length == 0)
         {
            return -1;
         }
         var _loc2_:int = param1.selection;
         if(_loc2_ < 0 || _loc2_ >= UnknownVarFromPetsView_Array_1.length)
         {
            _loc2_ = 0;
         }
         return int(UnknownVarFromPetsView_Array_1[_loc2_]);
      }
      
      private function getSelectedRarityFilter(param1:IDropBaseController_1) : int
      {
         if(param1 == null || UnknownVarFromPetsView_Array_2 == null || UnknownVarFromPetsView_Array_2.length == 0)
         {
            return -1;
         }
         var _loc2_:int = param1.selection;
         if(_loc2_ < 0 || _loc2_ >= UnknownVarFromPetsView_Array_2.length)
         {
            _loc2_ = 0;
         }
         return int(UnknownVarFromPetsView_Array_2[_loc2_]);
      }
      
      private function isRarityFilterEnabled() : Boolean
      {
         return UnknownVarFromPetsView_Int_3 == 16;
      }
      
      private function getRarityFilterLabel(param1:int) : String
      {
         if(param1 == -1)
         {
            return UnknownVarFromPetsView_PetsModel_1.controller.localization.getLocalization("inventory.pets.filter.rarity.all");
         }
         return String(param1);
      }
      
      private function getPetTypeLabel(param1:int) : String
      {
         return UnknownVarFromPetsView_PetsModel_1.controller.localization.getLocalization("pet.type." + param1);
      }
   }
}

