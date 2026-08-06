package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftableProductsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipesAvailableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftSecretComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftableProductsComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipeComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipesAvailableComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
   import com.sulake.habbo.communication.messages.parser.crafting.FurnitureProductItem;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class CraftingWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var UnknownVarFromCraftingWidgetHandler_CraftingWidget_1:CraftingWidget;
      
      private var UnknownVarFromCraftingWidgetHandler_RoomDesktop_1:RoomDesktop;
      
      private var UnknownVarFromCraftingWidgetHandler_IMessageEvent_1:IMessageEvent;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromCraftingWidgetHandler_Int_1:int;
      
      private var UnknownVarFromCraftingWidgetHandler_Boolean_1:Boolean;
      
      private var _inventoryDirty:Boolean;
      
      private var _craftingInProgress:Boolean;
      
      private var UnknownVarFromCraftingWidgetHandler_IProductData_1:IProductData;
      
      private var UnknownVarFromCraftingWidgetHandler_String_1:String;
      
      public function CraftingWidgetHandler(param1:RoomDesktop)
      {
         super();
         UnknownVarFromCraftingWidgetHandler_RoomDesktop_1 = param1;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1 = null;
         _container = null;
         UnknownVarFromCraftingWidgetHandler_RoomDesktop_1 = null;
         UnknownVarFromCraftingWidgetHandler_IProductData_1 = null;
         UnknownVarFromCraftingWidgetHandler_String_1 = null;
         _disposed = true;
      }
      
      private function addMessageEvents() : void
      {
         if(!_container || !_container.connection)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CraftableProductsMessageEvent(onCraftableProductsMessage));
         _messageEvents.push(new CraftingRecipeMessageEvent(onCraftingRecipeMessage));
         _messageEvents.push(new CraftingResultMessageEvent(onCraftingResultMessage));
         _messageEvents.push(new CraftingRecipesAvailableMessageEvent(onCraftingRecipesAvailableMessage));
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.addMessageEvent(_loc1_);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!_container || !_container.connection || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         removeInventoryUpdateEvent();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.removeEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
         _messageEvents = null;
      }
      
      public function initializeData() : void
      {
         if(UnknownVarFromCraftingWidgetHandler_Boolean_1)
         {
            return;
         }
         UnknownVarFromCraftingWidgetHandler_Boolean_1 = true;
         if(_container.inventory.checkCategoryInitilization("furni"))
         {
            getCraftableProducts();
         }
      }
      
      private function onFurniListParsed(param1:HabboInventoryFurniListParsedEvent) : void
      {
         if(UnknownVarFromCraftingWidgetHandler_Boolean_1 && param1.category == "furni")
         {
            getCraftableProducts();
         }
      }
      
      private function getCraftableProducts() : void
      {
         _container.connection.send(new GetCraftableProductsComposer(UnknownVarFromCraftingWidgetHandler_Int_1));
      }
      
      private function onCraftableProductsMessage(param1:CraftableProductsMessageEvent) : void
      {
         UnknownVarFromCraftingWidgetHandler_Boolean_1 = false;
         if(!UnknownVarFromCraftingWidgetHandler_CraftingWidget_1)
         {
            return;
         }
         if(!param1.getParser().hasData())
         {
            UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.hide();
            return;
         }
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.showWidget();
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.showCraftingCategories(param1.getParser().recipeProductItems,param1.getParser().usableInventoryFurniClasses,_container.roomEngine,_container.sessionDataManager);
         _inventoryDirty = false;
      }
      
      public function getCraftingRecipe(param1:String, param2:String) : void
      {
         UnknownVarFromCraftingWidgetHandler_IProductData_1 = _container.sessionDataManager.getProductData(param2);
         UnknownVarFromCraftingWidgetHandler_String_1 = param1;
         _container.connection.send(new GetCraftingRecipeComposer(param1));
      }
      
      private function onCraftingRecipeMessage(param1:CraftingRecipeMessageEvent) : void
      {
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.showCraftingRecipe(param1.getParser().ingredients);
      }
      
      public function getCraftingRecipesAvailable(param1:Vector.<int>) : void
      {
         _container.connection.send(new GetCraftingRecipesAvailableComposer(UnknownVarFromCraftingWidgetHandler_Int_1,param1));
      }
      
      private function onCraftingRecipesAvailableMessage(param1:CraftingRecipesAvailableMessageEvent) : void
      {
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.infoCtrl.craftingSecretRecipesAvailable(param1.getParser().count,param1.getParser().recipeComplete);
      }
      
      public function doCraftingWithRecipe() : void
      {
         if(!UnknownVarFromCraftingWidgetHandler_IProductData_1 || !UnknownVarFromCraftingWidgetHandler_String_1)
         {
            return;
         }
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.infoCtrl.setState(1000);
         registerForFurniListInvalidate();
         _container.connection.send(new CraftComposer(UnknownVarFromCraftingWidgetHandler_Int_1,UnknownVarFromCraftingWidgetHandler_String_1));
      }
      
      public function doCraftingWithMixer() : void
      {
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.infoCtrl.setState(1000);
         var _loc1_:Vector.<int> = UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.getSelectedIngredients();
         registerForFurniListInvalidate();
         _container.connection.send(new CraftSecretComposer(UnknownVarFromCraftingWidgetHandler_Int_1,_loc1_));
      }
      
      private function onCraftingResultMessage(param1:CraftingResultMessageEvent) : void
      {
         var _loc2_:FurnitureProductItem = null;
         var _loc3_:IFurnitureData = null;
         _craftingInProgress = false;
         if(!param1.getParser().success)
         {
            UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.clearMixerItems();
            _inventoryDirty = false;
            removeInventoryUpdateEvent();
            UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.setInfoState(1);
         }
         else
         {
            UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.clearMixerItems();
            _loc2_ = param1.getParser().productData;
            _loc3_ = _container.sessionDataManager.getFloorItemDataByName(_loc2_.furnitureClassName);
            if(!_loc3_)
            {
               return;
            }
            UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.setInfoState(999,_loc3_);
         }
      }
      
      private function registerForFurniListInvalidate() : void
      {
         _inventoryDirty = true;
         if(UnknownVarFromCraftingWidgetHandler_IMessageEvent_1 == null)
         {
            UnknownVarFromCraftingWidgetHandler_IMessageEvent_1 = new FurniListInvalidateEvent(onFurniListInvalidate);
            _container.connection.addMessageEvent(UnknownVarFromCraftingWidgetHandler_IMessageEvent_1);
         }
      }
      
      private function onFurniListInvalidate(param1:FurniListInvalidateEvent) : void
      {
         _container.connection.send(new RequestFurniInventoryComposer());
         _container.connection.send(new GetCraftableProductsComposer(UnknownVarFromCraftingWidgetHandler_Int_1));
         removeInventoryUpdateEvent();
      }
      
      public function removeInventoryUpdateEvent() : void
      {
         if(UnknownVarFromCraftingWidgetHandler_IMessageEvent_1)
         {
            _container.connection.removeMessageEvent(UnknownVarFromCraftingWidgetHandler_IMessageEvent_1);
            UnknownVarFromCraftingWidgetHandler_IMessageEvent_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_CRAFTING";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         addMessageEvents();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.addEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set widget(param1:CraftingWidget) : void
      {
         UnknownVarFromCraftingWidgetHandler_CraftingWidget_1 = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_OPEN_WIDGET","RETWE_CLOSE_WIDGET"];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container.roomEngine == null || UnknownVarFromCraftingWidgetHandler_CraftingWidget_1 == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.objectId,_loc3_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.window != null)
               {
                  return;
               }
               if(_loc2_ != null)
               {
                  UnknownVarFromCraftingWidgetHandler_Int_1 = _loc2_.getId();
                  initializeData();
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               UnknownVarFromCraftingWidgetHandler_Int_1 = -1;
               UnknownVarFromCraftingWidgetHandler_CraftingWidget_1.hide();
         }
      }
      
      public function get isOwner() : Boolean
      {
         var _loc1_:int = _container.roomEngine.activeRoomId;
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc1_,UnknownVarFromCraftingWidgetHandler_Int_1,10);
         return _loc2_ != null && _container.isOwnerOfFurniture(_loc2_);
      }
      
      public function get craftingInProgress() : Boolean
      {
         return _craftingInProgress;
      }
      
      public function set craftingInProgress(param1:Boolean) : void
      {
         _craftingInProgress = param1;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return _inventoryDirty;
      }
      
      public function update() : void
      {
      }
   }
}

