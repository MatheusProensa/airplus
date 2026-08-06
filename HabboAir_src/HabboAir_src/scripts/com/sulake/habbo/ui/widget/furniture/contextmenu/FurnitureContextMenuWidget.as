package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.IHabboGroupsManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.habbo.ui.widget.furniture.effectbox.EffectBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu.GuildFurnitureContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.mysterytrophy.MysteryTrophyOpenDialogView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextMenuWidget extends RoomWidgetBase implements UnknownIHabboUiWidgetContextmenu1, IProfiler_1
   {
      private var UnknownVarFromFurnitureContextMenuWidget_Component_1:Component;
      
      private var UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1:FurnitureContextInfoView;
      
      private var _selectedObject:IRoomObject = null;
      
      private var UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1:GuildFurnitureContextMenuView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1:RandomTeleportContextMenuView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1:MonsterPlantSeedContextMenuView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1:MonsterPlantSeedConfirmationView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1:EffectBoxOpenDialogView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1:MysteryBoxContextMenuView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1:MysteryTrophyOpenDialogView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_MysteryBoxOpenDialogView_1:MysteryBoxOpenDialogView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1:FriendFurniContextMenuView;
      
      private var UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1:GenericUsableFurnitureContextMenuView;
      
      private var _catalog:IHabboCatalog;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1:PurchasableClothingConfirmationView;
      
      public function FurnitureContextMenuWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IComponent_1, param5:IHabboLocalizationManager, param6:Component, param7:IHabboGroupsManager, param8:IHabboCatalog)
      {
         super(param1,param2,param3,param5);
         UnknownVarFromFurnitureContextMenuWidget_Component_1 = param6;
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1 = new GuildFurnitureContextMenuView(this,param7,param2);
         UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1 = new RandomTeleportContextMenuView(this);
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1 = new MonsterPlantSeedContextMenuView(this);
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1 = new MysteryBoxContextMenuView(this);
         UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1 = new FriendFurniContextMenuView(this);
         UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1 = new GenericUsableFurnitureContextMenuView(this);
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1 = new MonsterPlantSeedConfirmationView(this);
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxOpenDialogView_1 = new MysteryBoxOpenDialogView(this);
         UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1 = new EffectBoxOpenDialogView(this);
         UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1 = new MysteryTrophyOpenDialogView(this);
         UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1 = new PurchasableClothingConfirmationView(this);
         _catalog = param8;
         this.handler.widget = this;
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromFurnitureContextMenuWidget_Component_1.removeUpdateReceiver(this);
         removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxOpenDialogView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxOpenDialogView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1 = null;
         UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1.dispose();
         UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1 = null;
         _catalog = null;
         super.dispose();
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get handler() : FurnitureContextMenuWidgetHandler
      {
         return _widgetHandler as FurnitureContextMenuWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!_container ? _container.roomEngine : null;
      }
      
      public function hideContextMenu(param1:IRoomObject) : void
      {
         if(_selectedObject != null && _selectedObject.getId() == param1.getId())
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
            UnknownVarFromFurnitureContextMenuWidget_Component_1.removeUpdateReceiver(this);
            _selectedObject = null;
         }
      }
      
      public function showGuildFurnitureContextMenu(param1:IRoomObject, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean) : void
      {
         _selectedObject = param1;
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1._guildId = param2;
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1._guildHomeRoomId = param4;
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1._userIsMember = param5;
         UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1._guildHasReadableForum = param6;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_GuildFurnitureContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1,param3);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showRandomTeleportContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1.objectCategory = param2;
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_RandomTeleportContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showMonsterPlantSeedContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1.objectCategory = param2;
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showPlantSeedConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(!UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1)
         {
            UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1 = new MonsterPlantSeedConfirmationView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1.open(param1.getId());
      }
      
      public function showPurchasableClothingConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(!UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1)
         {
            UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1 = new PurchasableClothingConfirmationView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_PurchasableClothingConfirmationView_1.open(param1.getId());
      }
      
      public function showEffectBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(!UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1)
         {
            UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1 = new EffectBoxOpenDialogView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_EffectBoxOpenDialogView_1.open(param1.getId());
      }
      
      public function showMysteryTrophyOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(!UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1)
         {
            UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1 = new MysteryTrophyOpenDialogView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_MysteryTrophyOpenDialogView_1.open(param1.getId());
      }
      
      private function removePlantSeedConfirmationView() : void
      {
         if(UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1 != null)
         {
            UnknownVarFromFurnitureContextMenuWidget_MonsterPlantSeedConfirmationView_1.close();
         }
      }
      
      public function showMysteryBoxContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1 == null)
         {
            UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1 = new MysteryBoxContextMenuView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1.isOwnerMode = handler.container.isOwnerOfFurniture(param1);
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1.show();
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_MysteryBoxContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showFriendFurnitureContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1 == null)
         {
            UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1 = new FriendFurniContextMenuView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1.show();
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_FriendFurniContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showUsableFurnitureContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         if(UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1 == null)
         {
            UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1 = new GenericUsableFurnitureContextMenuView(this);
         }
         UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1.show();
         UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1.objectCategory = param2;
         UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = UnknownVarFromFurnitureContextMenuWidget_GenericUsableFurnitureContextMenuView_1;
         FurnitureContextInfoView.setup(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,param1);
         UnknownVarFromFurnitureContextMenuWidget_Component_1.registerUpdateReceiver(this,10);
      }
      
      public function showMysteryBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         UnknownVarFromFurnitureContextMenuWidget_MysteryBoxOpenDialogView_1.startOpenFlow(param1);
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         if(param1)
         {
            param1.hide(false);
            if(param1 == UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1)
            {
               UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 = null;
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 && _selectedObject)
         {
            UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1.update(this.handler.getObjectRectangle(_selectedObject.getId()),this.handler.getObjectScreenLocation(_selectedObject.getId()),param1);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.category == 10)
         {
            _loc2_ = param1.objectId;
            if(_selectedObject != null && _selectedObject.getId() == _loc2_)
            {
               removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
               removePlantSeedConfirmationView();
               UnknownVarFromFurnitureContextMenuWidget_Component_1.removeUpdateReceiver(this);
               _selectedObject = null;
            }
         }
      }
      
      public function get friendList() : IHabboFriendList
      {
         return null;
      }
      
      override public function release() : void
      {
         if(_selectedObject != null)
         {
            hideContextMenu(_selectedObject);
         }
         if(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1 != null)
         {
            removeView(UnknownVarFromFurnitureContextMenuWidget_FurnitureContextInfoView_1,false);
         }
         super.release();
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
      }
   }
}

