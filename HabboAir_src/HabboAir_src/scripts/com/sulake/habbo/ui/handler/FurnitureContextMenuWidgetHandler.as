package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.clothes.FigureSetIdsEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.GuildFurniContextMenuInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.CustomizeAvatarWithFurniMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.GuildFurniContextMenuInfoMessageParser;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxToolbarExtension;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class FurnitureContextMenuWidgetHandler implements IRoomWidgetHandler
   {
      private static const PENDING_PURCHASABLE_CLOTHING_TIMEOUT_MS:int = 5000;
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _widget:FurnitureContextMenuWidget;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1:IConnection;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1:IMessageEvent = null;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1:MysteryBoxToolbarExtension;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2:IMessageEvent = null;
      
      private var _pendingPurchasableClothingFurniName:String;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_String_1:String;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_String_2:String;
      
      private var UnknownVarFromFurnitureContextMenuWidgetHandler_Int_1:int = -1;
      
      public function FurnitureContextMenuWidgetHandler()
      {
         super();
         UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1 = new MysteryBoxToolbarExtension(this);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1 != null)
            {
               UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1.dispose();
               UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1 = null;
            }
            unsetContainer();
            if(UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 != null && UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1)
            {
               UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1);
               UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1 = null;
            }
            if(UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 != null && UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2)
            {
               UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2);
               UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2 = null;
            }
            UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 = null;
            _widget = null;
            clearPendingPurchasableClothingRequest();
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!_container ? _container.roomEngine : null;
      }
      
      private function unsetContainer() : void
      {
         if(_container != null)
         {
            _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",onMonsterPlantSeedPlantConfirmationDialogRequested);
            _container.roomEngine.events.removeEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",onPurchasableClothingConfirmationDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",onMysteryBoxOpenDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",onEffectBoxOpenDialogRequested);
            _container.roomEngine.events.removeEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",onMysteryTrophyOpenDialogRequested);
         }
         _container = null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         unsetContainer();
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(_container.roomEngine != null)
         {
            _container.roomEngine.events.addEventListener("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",onMonsterPlantSeedPlantConfirmationDialogRequested);
            _container.roomEngine.events.addEventListener("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG",onPurchasableClothingConfirmationDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG",onMysteryBoxOpenDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG",onEffectBoxOpenDialogRequested);
            _container.roomEngine.events.addEventListener("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG",onMysteryTrophyOpenDialogRequested);
         }
      }
      
      public function set widget(param1:FurnitureContextMenuWidget) : void
      {
         _widget = param1;
         if(_container.config.getBoolean("mysterybox.tracker.active"))
         {
            UnknownVarFromFurnitureContextMenuWidgetHandler_MysteryBoxToolbarExtension_1.createWindow();
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 = param1;
         if(UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 == null)
         {
            return;
         }
         if(!UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1)
         {
            UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1 = new GuildFurniContextMenuInfoMessageEvent(onGuildFurniContextMenuInfo);
            UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_1);
         }
         if(!UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2)
         {
            UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2 = new FigureSetIdsEvent(onFigureSetIds);
            UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromFurnitureContextMenuWidgetHandler_IMessageEvent_2);
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return !!_container ? _container.roomSession : null;
      }
      
      public function getFurniData(param1:IRoomObject) : IFurnitureData
      {
         var _loc2_:IFurnitureData = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = param1.getModel().getNumber("furniture_type_id");
            _loc2_ = _container.sessionDataManager.getFloorItemData(_loc3_);
         }
         return _loc2_;
      }
      
      public function redeemPurchasableClothing(param1:int, param2:String, param3:String, param4:String) : void
      {
         if(UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 == null)
         {
            return;
         }
         _pendingPurchasableClothingFurniName = param2;
         UnknownVarFromFurnitureContextMenuWidgetHandler_String_1 = param3;
         UnknownVarFromFurnitureContextMenuWidgetHandler_String_2 = param4;
         UnknownVarFromFurnitureContextMenuWidgetHandler_Int_1 = getTimer();
         UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.send(new CustomizeAvatarWithFurniMessageComposer(param1));
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWUPM_MONSTERPLANT_SEED"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetUseProductMessage = null;
         if(!param1)
         {
            return null;
         }
         var _loc3_:* = param1.type;
         if("RWUPM_MONSTERPLANT_SEED" === _loc3_)
         {
            _loc2_ = param1 as RoomWidgetUseProductMessage;
            if(_loc2_)
            {
               _container.roomSession.plantSeed(_loc2_.roomObjectId);
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_OPEN_FURNI_CONTEXT_MENU","RETWE_CLOSE_FURNI_CONTEXT_MENU"];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_widget == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = getRoomObject(_loc3_.objectId);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RETWE_OPEN_FURNI_CONTEXT_MENU":
               switch(_loc3_.contextMenu)
               {
                  case "FRIEND_FURNITURE":
                     _widget.showFriendFurnitureContextMenu(_loc2_);
                     break;
                  case "MONSTERPLANT_SEED":
                     if(_container.isOwnerOfFurniture(_loc2_))
                     {
                        _widget.showMonsterPlantSeedContextMenu(_loc2_,_loc3_.category);
                     }
                     break;
                  case "MYSTERY_BOX":
                     _widget.showMysteryBoxContextMenu(_loc2_);
                     break;
                  case "RANDOM_TELEPORT":
                     _widget.showRandomTeleportContextMenu(_loc2_,_loc3_.category);
                     break;
                  case "PURCHASABLE_CLOTHING":
                     _widget.showUsableFurnitureContextMenu(_loc2_,_loc3_.category);
               }
               break;
            case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
               _widget.hideContextMenu(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function getObjectRectangle(param1:int) : Rectangle
      {
         return _container.roomEngine.getRoomObjectBoundingRectangle(_container.roomSession.roomId,param1,10,_container.getFirstCanvasId());
      }
      
      public function getObjectScreenLocation(param1:int) : Point
      {
         return _container.roomEngine.getRoomObjectScreenLocation(_container.roomSession.roomId,param1,10,_container.getFirstCanvasId());
      }
      
      public function sendGoToHomeRoomMessage(param1:int) : void
      {
         _container.navigator.goToPrivateRoom(param1);
      }
      
      public function sendJoinToGroupMessage(param1:int) : void
      {
         UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.send(new JoinHabboGroupMessageComposer(param1));
      }
      
      private function getRoomObject(param1:int) : IRoomObject
      {
         if(_container == null)
         {
            return null;
         }
         return _container.roomEngine.getRoomObject(_container.roomSession.roomId,param1,10);
      }
      
      private function onGuildFurniContextMenuInfo(param1:GuildFurniContextMenuInfoMessageEvent) : void
      {
         var _loc2_:GuildFurniContextMenuInfoMessageParser = null;
         var _loc3_:IRoomObject = null;
         if(_widget != null)
         {
            _loc2_ = param1.getParser();
            _loc3_ = getRoomObject(_loc2_.objectId);
            if(_loc3_ != null)
            {
               _widget.showGuildFurnitureContextMenu(_loc3_,_loc2_.guildId,_loc2_.guildName,_loc2_.guildHomeRoomId,_loc2_.userIsMember,_loc2_.guildHasReadableForum);
            }
         }
      }
      
      private function onFigureSetIds(param1:FigureSetIdsEvent) : void
      {
         var _loc2_:Boolean = hasFreshPendingPurchasableClothingRequest();
         if(UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1 == null || !_loc2_)
         {
            if(!_loc2_)
            {
               clearPendingPurchasableClothingRequest();
            }
            return;
         }
         var _loc3_:Vector.<String> = param1.getParser().boundFurnitureNames;
         if(_loc3_ == null || _loc3_.indexOf(_pendingPurchasableClothingFurniName) == -1)
         {
            return;
         }
         UnknownVarFromFurnitureContextMenuWidgetHandler_IConnection_1.send(new UpdateFigureDataMessageComposer(UnknownVarFromFurnitureContextMenuWidgetHandler_String_1,UnknownVarFromFurnitureContextMenuWidgetHandler_String_2));
         clearPendingPurchasableClothingRequest();
      }
      
      private function hasFreshPendingPurchasableClothingRequest() : Boolean
      {
         if(UnknownVarFromFurnitureContextMenuWidgetHandler_Int_1 < 0 || UnknownVarFromFurnitureContextMenuWidgetHandler_String_1 == null || UnknownVarFromFurnitureContextMenuWidgetHandler_String_2 == null || _pendingPurchasableClothingFurniName == null)
         {
            return false;
         }
         return getTimer() - UnknownVarFromFurnitureContextMenuWidgetHandler_Int_1 <= 5000;
      }
      
      private function clearPendingPurchasableClothingRequest() : void
      {
         _pendingPurchasableClothingFurniName = null;
         UnknownVarFromFurnitureContextMenuWidgetHandler_String_1 = null;
         UnknownVarFromFurnitureContextMenuWidgetHandler_String_2 = null;
         UnknownVarFromFurnitureContextMenuWidgetHandler_Int_1 = -1;
      }
      
      private function onMonsterPlantSeedPlantConfirmationDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc2_:Boolean = false;
         if(_widget != null)
         {
            _loc3_ = getRoomObject(param1.objectId);
            if(_loc3_ != null)
            {
               _loc2_ = _container.isOwnerOfFurniture(_loc3_);
               if(!_loc2_)
               {
                  return;
               }
               _widget.showPlantSeedConfirmationDialog(_loc3_);
            }
         }
      }
      
      private function onPurchasableClothingConfirmationDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc2_:Boolean = false;
         if(_widget != null)
         {
            _loc3_ = getRoomObject(param1.objectId);
            if(_loc3_ != null)
            {
               _loc2_ = _container.isOwnerOfFurniture(_loc3_);
               if(!_loc2_)
               {
                  return;
               }
               _widget.showPurchasableClothingConfirmationDialog(_loc3_);
            }
         }
      }
      
      private function onEffectBoxOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc2_:Boolean = false;
         if(_widget != null)
         {
            _loc3_ = getRoomObject(param1.objectId);
            if(_loc3_ != null)
            {
               _loc2_ = _container.isOwnerOfFurniture(_loc3_);
               if(!_loc2_)
               {
                  return;
               }
               _widget.showEffectBoxOpenDialog(_loc3_);
            }
         }
      }
      
      private function onMysteryTrophyOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc2_:Boolean = false;
         if(_widget != null)
         {
            _loc3_ = getRoomObject(param1.objectId);
            if(_loc3_ != null)
            {
               _loc2_ = _container.isOwnerOfFurniture(_loc3_);
               if(!_loc2_)
               {
                  return;
               }
               _widget.showMysteryTrophyOpenDialog(_loc3_);
            }
         }
      }
      
      private function onMysteryBoxOpenDialogRequested(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:IRoomObject = null;
         if(_widget != null)
         {
            _loc2_ = getRoomObject(param1.objectId);
            if(_loc2_ != null)
            {
               _widget.showMysteryBoxOpenDialog(_loc2_);
            }
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get widget() : FurnitureContextMenuWidget
      {
         return _widget;
      }
   }
}

