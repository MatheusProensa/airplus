package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BotsView implements IInventoryView, UnknownIHabboAvatar1
   {
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromBotsView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromBotsView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBotsView_BotsModel_1:BotsModel;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromBotsView_IItemGridWindow_1:IItemGridWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var _avatarRenderer:IAvatarRenderManager;
      
      private var _gridItems:Map;
      
      private var UnknownVarFromBotsView_BotGridItem_1:BotGridItem;
      
      private var UnknownVarFromBotsView_Int_1:int = 0;
      
      private var UnknownVarFromBotsView_Int_2:int;
      
      private var UnknownVarFromBotsView_Boolean_1:Boolean = false;
      
      public function BotsView(param1:BotsModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IRoomEngine, param5:IAvatarRenderManager)
      {
         super();
         UnknownVarFromBotsView_BotsModel_1 = param1;
         UnknownVarFromBotsView_IAssetLibraryCollection_1 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _avatarRenderer = param5;
         _gridItems = new Map();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return UnknownVarFromBotsView_IWindowController_1_1 && UnknownVarFromBotsView_IWindowController_1_1.parent != null && UnknownVarFromBotsView_IWindowController_1_1.visible;
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         _avatarRenderer = null;
         _roomEngine = null;
         UnknownVarFromBotsView_IAssetLibraryCollection_1 = null;
         UnknownVarFromBotsView_BotsModel_1 = null;
         UnknownVarFromBotsView_IWindowController_1_1 = null;
         _disposed = true;
      }
      
      public function update() : void
      {
         if(!UnknownVarFromBotsView_Boolean_1)
         {
            return;
         }
         updateGrid();
         updatePreview(UnknownVarFromBotsView_BotGridItem_1);
         updateContainerVisibility();
      }
      
      public function removeItem(param1:int) : void
      {
         if(!UnknownVarFromBotsView_Boolean_1)
         {
            return;
         }
         var _loc2_:BotGridItem = _gridItems.remove(param1) as BotGridItem;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromBotsView_IItemGridWindow_1.removeGridItem(_loc2_.window);
         if(UnknownVarFromBotsView_BotGridItem_1 == _loc2_)
         {
            UnknownVarFromBotsView_BotGridItem_1 = null;
            selectFirst();
         }
      }
      
      public function addItem(param1:BotData) : void
      {
         if(!UnknownVarFromBotsView_Boolean_1)
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
         var _loc2_:BotGridItem = new BotGridItem(this,param1,_windowManager,UnknownVarFromBotsView_IAssetLibraryCollection_1,UnknownVarFromBotsView_BotsModel_1.isUnseen(param1.id));
         if(_loc2_ != null)
         {
            UnknownVarFromBotsView_IItemGridWindow_1.addGridItem(_loc2_.window);
            _gridItems.add(param1.id,_loc2_);
            if(UnknownVarFromBotsView_BotGridItem_1 == null)
            {
               selectFirst();
            }
         }
      }
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : void
      {
         UnknownVarFromBotsView_BotsModel_1.placeItemToRoom(param1,param2);
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromBotsView_Boolean_1)
         {
            init();
         }
         if(UnknownVarFromBotsView_IWindowController_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromBotsView_IWindowController_1_1.disposed)
         {
            return null;
         }
         return UnknownVarFromBotsView_IWindowController_1_1;
      }
      
      public function setSelectedGridItem(param1:BotGridItem) : void
      {
         if(!UnknownVarFromBotsView_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromBotsView_BotGridItem_1 != null)
         {
            UnknownVarFromBotsView_BotGridItem_1.setSelected(false);
         }
         UnknownVarFromBotsView_BotGridItem_1 = param1;
         if(UnknownVarFromBotsView_BotGridItem_1 != null)
         {
            UnknownVarFromBotsView_BotGridItem_1.setSelected(true);
         }
         updatePreview(param1);
      }
      
      public function updateState() : void
      {
         var _loc1_:int = 0;
         if(!UnknownVarFromBotsView_Boolean_1)
         {
            return;
         }
         var _loc2_:Map = UnknownVarFromBotsView_BotsModel_1.items;
         if(!UnknownVarFromBotsView_BotsModel_1.isListInitialized())
         {
            _loc1_ = 1;
         }
         else if(!_loc2_ || _loc2_.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(UnknownVarFromBotsView_Int_1 == _loc1_)
         {
            return;
         }
         UnknownVarFromBotsView_Int_1 = _loc1_;
         updateContainerVisibility();
         if(UnknownVarFromBotsView_Int_1 == 3)
         {
            updateGrid();
            updatePreview();
         }
      }
      
      public function getGridItemImage(param1:BotData) : BitmapData
      {
         var _loc2_:int = 3;
         return getItemImage(param1,_loc2_,false,"h");
      }
      
      public function getItemImage(param1:BotData, param2:int, param3:Boolean, param4:String) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc6_:IAvatarImage_2 = _avatarRenderer.createAvatarImage(param1.figure,param4,param1.gender,this);
         _loc6_.setDirection("full",param2);
         if(param3)
         {
            _loc5_ = _loc6_.getCroppedImage("full");
         }
         else
         {
            _loc5_ = _loc6_.getCroppedImage("head");
         }
         _loc6_.dispose();
         return _loc5_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc2_ in _gridItems)
         {
            if(_loc2_.data.figure == param1)
            {
               _loc2_.setImage(getGridItemImage(_loc2_.data));
            }
         }
      }
      
      private function selectFirst() : void
      {
         if(_gridItems == null || _gridItems.length == 0)
         {
            updatePreview();
            return;
         }
         setSelectedGridItem(_gridItems.getWithIndex(0));
      }
      
      public function selectById(param1:int) : void
      {
         setSelectedGridItem(_gridItems.getValue(param1));
      }
      
      private function updateGrid() : void
      {
         var _loc4_:int = 0;
         var _loc3_:BotGridItem = null;
         if(UnknownVarFromBotsView_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc1_:Array = _gridItems.getKeys();
         var _loc2_:Array = !!UnknownVarFromBotsView_BotsModel_1.items ? UnknownVarFromBotsView_BotsModel_1.items.getKeys() : [];
         UnknownVarFromBotsView_IItemGridWindow_1.lock();
         for each(_loc4_ in _loc1_)
         {
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               removeItem(_loc4_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               addItem(UnknownVarFromBotsView_BotsModel_1.items.getValue(_loc4_));
            }
            _loc3_ = _gridItems.getValue(_loc4_);
            _loc3_.setUnseen(UnknownVarFromBotsView_BotsModel_1.isUnseen(_loc4_));
         }
         UnknownVarFromBotsView_IItemGridWindow_1.unlock();
      }
      
      private function startPlacingHandler(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromBotsView_BotGridItem_1 == null)
         {
            return;
         }
         var _loc2_:BotData = UnknownVarFromBotsView_BotGridItem_1.data;
         if(_loc2_ == null)
         {
            return;
         }
         placeItemToRoom(_loc2_.id);
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
      }
      
      private function updateContainerVisibility() : void
      {
         if(UnknownVarFromBotsView_BotsModel_1.controller.currentCategoryId != "bots")
         {
            return;
         }
         var _loc1_:IWindowController_1 = UnknownVarFromBotsView_BotsModel_1.controller.view.loadingContainer;
         var _loc3_:IWindowController_1 = UnknownVarFromBotsView_BotsModel_1.controller.view.emptyContainer;
         var _loc4_:IWindowModel = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("grid");
         var _loc2_:IWindowModel = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("preview_container");
         switch(UnknownVarFromBotsView_Int_1 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = true;
               }
               _loc4_.visible = false;
               _loc2_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
               _loc4_.visible = true;
               _loc2_.visible = true;
         }
      }
      
      private function updatePreview(param1:BotGridItem = null) : void
      {
         var _loc3_:BitmapData = null;
         var _loc11_:String = null;
         var _loc13_:String = null;
         var _loc10_:Boolean = false;
         var _loc4_:BotData = null;
         var _loc5_:BitmapData = null;
         if(UnknownVarFromBotsView_IWindowController_1_1 == null)
         {
            return;
         }
         UnknownVarFromBotsView_Int_2 = -1;
         if(param1 == null || param1.data == null)
         {
            _loc3_ = new BitmapData(1,1);
            _loc11_ = "";
            _loc13_ = "";
            _loc10_ = false;
         }
         else
         {
            _loc4_ = param1.data;
            _loc11_ = _loc4_.name;
            _loc13_ = _loc4_.motto;
            _loc3_ = getItemImage(_loc4_,4,true,"h");
            _loc10_ = true;
         }
         var _loc9_:IBitmapWrapperController = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("preview_image") as IBitmapWrapperController;
         if(_loc9_ != null)
         {
            _loc5_ = new BitmapData(_loc9_.width,_loc9_.height);
            _loc5_.fillRect(_loc5_.rect,0);
            _loc5_.copyPixels(_loc3_,_loc3_.rect,new Point(_loc5_.width / 2 - _loc3_.width / 2,_loc5_.height / 2 - _loc3_.height / 2));
            _loc9_.bitmap = _loc5_;
         }
         _loc3_.dispose();
         var _loc6_:ITextWindow = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("bot_name") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc11_;
         }
         _loc6_ = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("bot_description") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc13_;
         }
         var _loc8_:Boolean = false;
         var _loc12_:Boolean = false;
         if(UnknownVarFromBotsView_BotsModel_1.roomSession != null)
         {
            _loc8_ = UnknownVarFromBotsView_BotsModel_1.roomSession.areBotsAllowed;
            _loc12_ = UnknownVarFromBotsView_BotsModel_1.roomSession.isRoomOwner;
         }
         var _loc2_:String = "";
         if(!_loc12_)
         {
            if(_loc8_)
            {
               _loc2_ = "${inventory.bots.allowed}";
            }
            else
            {
               _loc2_ = "${inventory.bots.forbidden}";
            }
         }
         _loc6_ = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("preview_info") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.caption = _loc2_;
         }
         var _loc7_:UnknownICoreWindowComponents4 = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("place_button") as UnknownICoreWindowComponents4;
         if(_loc7_ != null)
         {
            if(_loc10_ && (_loc12_ || _loc8_))
            {
               _loc7_.enable();
            }
            else
            {
               _loc7_.disable();
            }
         }
      }
      
      private function addUnseenItemSymbols() : void
      {
      }
      
      private function init() : void
      {
         var _loc1_:UnknownICoreWindowComponents4 = null;
         UnknownVarFromBotsView_IWindowController_1_1 = UnknownVarFromBotsView_BotsModel_1.controller.view.getView("bots");
         UnknownVarFromBotsView_IWindowController_1_1.visible = false;
         UnknownVarFromBotsView_IWindowController_1_1.procedure = windowEventHandler;
         addUnseenItemSymbols();
         UnknownVarFromBotsView_IItemGridWindow_1 = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("grid") as IItemGridWindow;
         _loc1_ = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("place_button") as UnknownICoreWindowComponents4;
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",startPlacingHandler);
         }
         var _loc2_:IBitmapWrapperController = UnknownVarFromBotsView_IWindowController_1_1.findChildByName("preview_image") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_DOWN",startPlacingHandler);
         }
         updatePreview();
         updateState();
         selectFirst();
         UnknownVarFromBotsView_Boolean_1 = true;
      }
   }
}

