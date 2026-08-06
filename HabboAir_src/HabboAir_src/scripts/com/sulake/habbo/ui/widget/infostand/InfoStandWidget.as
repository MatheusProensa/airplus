package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceRoomItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceWallItemMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectPlaceEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class InfoStandWidget extends RoomWidgetBase
   {
      private static const PLACEMENT_PAGE_ID:int = -1;
      
      private const USER_VIEW:String = "infostand_user_view";
      
      private const UnknownConstFromInfoStandWidget_String_1:String = "infostand_furni_view";
      
      private const PET_VIEW:String = "infostand_pet_view";
      
      private const BOT_VIEW:String = "infostand_bot_view";
      
      private const RENTABLE_BOT_VIEW:String = "infostand_rentable_bot_view";
      
      private const UnknownConstFromInfoStandWidget_String_2:String = "infostand_jukebox_view";
      
      private const CRACKABLE_FURNI_VIEW:String = "infostand_crackable_furni_view";
      
      private const SONGDISK_VIEW:String = "infostand_songdisk_view";
      
      private var _furniView:InfoStandFurniView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandUserView_1:InfoStandUserView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandPetView_1:InfoStandPetView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandBotView_1:InfoStandBotView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1:InfoStandRentableBotView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1:InfoStandJukeboxView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1:InfoStandCrackableFurniView;
      
      private var UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1:InfoStandSongDiskView;
      
      private var UnknownVarFromInfoStandWidget_Array_1:Array;
      
      private var _userData:InfoStandUserData;
      
      private var _furniData:InfoStandFurniData;
      
      private var _petData:InfoStandPetData;
      
      private var _rentableBotData:InfoStandRentableBotData;
      
      private var UnknownVarFromInfoStandWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromInfoStandWidget_Timer_1:Timer;
      
      private var _config:IComponent_1;
      
      private const UPDATE_INTERVAL_MS:int = 3000;
      
      public function InfoStandWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1, param6:IHabboCatalog)
      {
         super(param1,param2,param3,param4);
         _config = param5;
         _furniView = new InfoStandFurniView(this,"infostand_furni_view",param6);
         UnknownVarFromInfoStandWidget_InfoStandUserView_1 = new InfoStandUserView(this,"infostand_user_view");
         UnknownVarFromInfoStandWidget_InfoStandPetView_1 = new InfoStandPetView(this,"infostand_pet_view",param6);
         UnknownVarFromInfoStandWidget_InfoStandBotView_1 = new InfoStandBotView(this,"infostand_bot_view");
         UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1 = new InfoStandRentableBotView(this,"infostand_rentable_bot_view",param6);
         UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1 = new InfoStandJukeboxView(this,"infostand_jukebox_view",param6);
         UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1 = new InfoStandCrackableFurniView(this,"infostand_crackable_furni_view",param6);
         UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1 = new InfoStandSongDiskView(this,"infostand_songdisk_view",param6);
         _userData = new InfoStandUserData();
         _furniData = new InfoStandFurniData();
         _petData = new InfoStandPetData();
         _rentableBotData = new InfoStandRentableBotData();
         UnknownVarFromInfoStandWidget_Timer_1 = new Timer(3000);
         UnknownVarFromInfoStandWidget_Timer_1.addEventListener("timer",onUpdateTimer);
         mainContainer.visible = false;
         this.handler.widget = this;
      }
      
      public function get handler() : InfoStandWidgetHandler
      {
         return _widgetHandler as InfoStandWidgetHandler;
      }
      
      public function get furniView() : InfoStandFurniView
      {
         return _furniView;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return mainContainer;
      }
      
      public function get config() : IComponent_1
      {
         return _config;
      }
      
      public function get mainContainer() : IWindowController_1
      {
         if(UnknownVarFromInfoStandWidget_IWindowController_1_1 == null)
         {
            UnknownVarFromInfoStandWidget_IWindowController_1_1 = windowManager.createWindow("infostand_main_container","",4,0,0,new Rectangle(0,0,50,100)) as IWindowController_1;
            UnknownVarFromInfoStandWidget_IWindowController_1_1.tags.push("room_widget_infostand");
            UnknownVarFromInfoStandWidget_IWindowController_1_1.background = true;
            UnknownVarFromInfoStandWidget_IWindowController_1_1.color = 0;
         }
         return UnknownVarFromInfoStandWidget_IWindowController_1_1;
      }
      
      public function favouriteGroupUpdated(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc6_:String = null;
         if(!userData || userData.userRoomId != param1)
         {
            return;
         }
         if(!mainContainer)
         {
            return;
         }
         var _loc5_:IWindowModel = mainContainer.findChildByName("infostand_user_view");
         if(!_loc5_ || !_loc5_.visible)
         {
            return;
         }
         UnknownVarFromInfoStandWidget_InfoStandUserView_1.clearGroupBadge();
         if(param2 != -1)
         {
            _loc6_ = handler.container.sessionDataManager.getGroupBadgeId(param2);
            userData.groupId = param2;
            userData.groupBadgeId = _loc6_;
            userData.groupName = param4;
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.setGroupBadge(_loc6_);
         }
      }
      
      public function getXmlWindow(param1:String) : IWindowModel
      {
         var _loc4_:ISoundAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IWindowModel = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            Logger.log("[InfoStandWidget] Missing window XML: " + param1);
         }
         return _loc3_;
      }
      
      public function setRelationshipStatus(param1:int, param2:Map) : void
      {
         if(_userData.userId == param1)
         {
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.setRelationshipStatuses(param2);
         }
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
         UnknownVarFromInfoStandWidget_Timer_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandUserView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandUserView_1 = null;
         if(_furniView)
         {
            _furniView.dispose();
         }
         _furniView = null;
         if(UnknownVarFromInfoStandWidget_InfoStandBotView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandBotView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandBotView_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandPetView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandPetView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandPetView_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1 = null;
         if(UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1)
         {
            UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1.dispose();
         }
         UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.addEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWROUE_OBJECT_PLACED",onRoomObjectPlaced);
         param1.addEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.addEventListener("RWUIUE_PEER",onUserInfo);
         param1.addEventListener("RWUIUE_BOT",onBotInfo);
         param1.addEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",onRentableBotInfo);
         param1.addEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.addEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.addEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.addEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.addEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.addEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.addEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.removeEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWROUE_OBJECT_PLACED",onRoomObjectPlaced);
         param1.removeEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.removeEventListener("RWUIUE_PEER",onUserInfo);
         param1.removeEventListener("RWUIUE_BOT",onBotInfo);
         param1.removeEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.removeEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.removeEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.removeEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.removeEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.removeEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.removeEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.removeEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
      }
      
      public function get rentableBotData() : InfoStandRentableBotData
      {
         return _rentableBotData;
      }
      
      public function get userData() : InfoStandUserData
      {
         return _userData;
      }
      
      public function get furniData() : InfoStandFurniData
      {
         return _furniData;
      }
      
      public function get petData() : InfoStandPetData
      {
         return _petData;
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromInfoStandWidget_InfoStandPetView_1 == null)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE",UnknownVarFromInfoStandWidget_InfoStandPetView_1.getCurrentPetId()));
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var _loc2_:Boolean = UnknownVarFromInfoStandWidget_InfoStandUserView_1 != null && UnknownVarFromInfoStandWidget_InfoStandUserView_1.window != null && Boolean(UnknownVarFromInfoStandWidget_InfoStandUserView_1.window.visible) && _userData.userId == param1.webID;
         var _loc4_:Array = userData.badges;
         var _loc5_:Array = userData.selectedBadges;
         var _loc6_:Boolean = shouldPreserveDisplayedBadges(_loc2_,_loc4_,_loc5_,param1.badges,param1.selectedBadges);
         var _loc3_:Boolean = shouldPlayGlowForUserInfo(_loc2_,_loc4_,_loc5_,param1.badges,param1.selectedBadges);
         userData.setData(param1);
         if(_loc6_)
         {
            userData.badges = _loc4_;
            userData.selectedBadges = _loc5_;
         }
         if(handler.container.sessionDataManager.isBlocked(param1.webID))
         {
            return;
         }
         UnknownVarFromInfoStandWidget_InfoStandUserView_1.update(param1,_loc3_,_loc6_);
         selectView("infostand_user_view");
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         UnknownVarFromInfoStandWidget_InfoStandBotView_1.update(param1);
         selectView("infostand_bot_view");
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function onRentableBotInfo(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         rentableBotData.setData(param1);
         UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1.update(param1);
         selectView("infostand_rentable_bot_view");
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         furniData.setData(param1);
         if(param1.extraParam == "RWEIEP_JUKEBOX")
         {
            UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1.update(param1);
            selectView("infostand_jukebox_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_SONGDISK") != -1)
         {
            UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1.update(param1);
            selectView("infostand_songdisk_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_CRACKABLE_FURNI") != -1)
         {
            UnknownVarFromInfoStandWidget_InfoStandCrackableFurniView_1.update(param1);
            selectView("infostand_crackable_furni_view");
         }
         else
         {
            _furniView.update(param1);
            selectView("infostand_furni_view");
         }
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         petData.setData(param1);
         userData.petRespectLeft = param1.petRespectLeft;
         UnknownVarFromInfoStandWidget_InfoStandPetView_1.update(petData);
         selectView("infostand_pet_view");
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.start();
         }
      }
      
      private function onPetFigureUpdate(param1:RoomWidgetPetFigureUpdateEvent) : void
      {
         UnknownVarFromInfoStandWidget_InfoStandPetView_1.updateImage(param1.petId,param1.image);
      }
      
      private function onPetCommands(param1:RoomWidgetPetCommandsUpdateEvent) : void
      {
         var _loc2_:Array = param1.allCommands;
         var _loc3_:Array = param1.enabledCommands;
         if(petData.type == 0 && !_config.getBoolean("nest.breeding.dog.enabled") || petData.type == 1 && !_config.getBoolean("nest.breeding.cat.enabled") || petData.type == 5 && !_config.getBoolean("nest.breeding.pig.enabled"))
         {
            if(_loc2_.indexOf(46) != -1)
            {
               _loc2_.splice(_loc2_.indexOf(46),1);
            }
            if(_loc3_.indexOf(46) != -1)
            {
               _loc3_.splice(_loc3_.indexOf(46),1);
            }
         }
         UnknownVarFromInfoStandWidget_InfoStandPetView_1.updateEnabledTrainingCommands(param1.id,new CommandConfiguration(param1.allCommands,param1.enabledCommands));
      }
      
      private function onOpenPetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         UnknownVarFromInfoStandWidget_InfoStandPetView_1.openTrainView();
      }
      
      private function onClosePetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         UnknownVarFromInfoStandWidget_InfoStandPetView_1.closeTrainView();
      }
      
      public function updateUserData(param1:int, param2:String, param3:int, param4:String, param5:Boolean, param6:int = -1) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         userData.badgesRank = param6;
         if(userData.isBot())
         {
            UnknownVarFromInfoStandWidget_InfoStandBotView_1.setFigure(param2);
         }
         else
         {
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.setFigure(param2);
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.setMotto(param4,param5);
            if(handler.isActivityDisplayEnabled)
            {
               UnknownVarFromInfoStandWidget_InfoStandUserView_1.achievementScore = param3;
            }
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.badgesRank = param6;
         }
      }
      
      public function refreshBadges(param1:int, param2:Array = null) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         param2 = param2 == null ? [] : param2;
         if(areSelectedBadgesEqual(userData.selectedBadges,param2))
         {
            return;
         }
         var _loc3_:Array = getBadgeCodesFromSelectedBadges(param2);
         userData.badges = _loc3_ == null ? [] : _loc3_;
         userData.selectedBadges = param2;
         if(userData.isBot())
         {
            UnknownVarFromInfoStandWidget_InfoStandBotView_1.updateBadges(userData.badges);
         }
         else
         {
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.updateBadges(userData.badges,userData.selectedBadges,true);
         }
      }
      
      public function refreshBadge(param1:String) : void
      {
         var _loc2_:SelectedBadgeData = null;
         var _loc3_:int = userData.getBadgeSlot(param1);
         if(_loc3_ >= 0)
         {
            _loc2_ = userData.getSelectedBadge(_loc3_);
            if(userData.isBot())
            {
               UnknownVarFromInfoStandWidget_InfoStandBotView_1.setBadge(_loc3_,param1);
            }
            else
            {
               UnknownVarFromInfoStandWidget_InfoStandUserView_1.setBadge(_loc3_,param1,_loc2_);
            }
            return;
         }
         if(param1 == userData.groupBadgeId)
         {
            UnknownVarFromInfoStandWidget_InfoStandUserView_1.setGroupBadge(param1);
         }
      }
      
      private function onRoomObjectPlaced(param1:RoomWidgetRoomObjectPlaceEvent) : void
      {
         if(param1.placementSource == "info_stand")
         {
            if(!param1.placedInRoom)
            {
               return;
            }
            switch(param1.category - 10)
            {
               case 0:
                  if(!param1.placedOnFloor)
                  {
                     return;
                  }
                  handler.container.connection.send(new BuildersClubPlaceRoomItemMessageComposer(-1,furniData.bcOfferId,furniData.extraParam,param1.x,param1.y,param1.direction));
                  break;
               case 10:
                  if(!param1.placedOnWall)
                  {
                     return;
                  }
                  handler.container.connection.send(new BuildersClubPlaceWallItemMessageComposer(-1,furniData.bcOfferId,furniData.extraParam,param1.wallLocation));
                  break;
            }
            requestItemToMover();
         }
      }
      
      public function requestItemToMover() : void
      {
         var _loc1_:IRoomEngine = handler.container.roomEngine;
         _loc1_.initializeRoomObjectInsert("info_stand",-furniData.bcOfferId,furniData.category,furniData.classId,furniData.extraParam,null,-1,-1,null,true);
      }
      
      private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param1.id,param1.category);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:* = false;
         switch(param1.type)
         {
            case "RWROUE_FURNI_REMOVED":
               _loc2_ = param1.id == _furniData.id;
               break;
            case "RWROUE_USER_REMOVED":
               if(UnknownVarFromInfoStandWidget_InfoStandUserView_1 != null && UnknownVarFromInfoStandWidget_InfoStandUserView_1.window != null && Boolean(UnknownVarFromInfoStandWidget_InfoStandUserView_1.window.visible))
               {
                  _loc2_ = param1.id == _userData.userRoomId;
                  break;
               }
               if(UnknownVarFromInfoStandWidget_InfoStandPetView_1 != null && UnknownVarFromInfoStandWidget_InfoStandPetView_1.window != null && Boolean(UnknownVarFromInfoStandWidget_InfoStandPetView_1.window.visible))
               {
                  _loc2_ = param1.id == _petData.roomIndex;
                  break;
               }
               if(UnknownVarFromInfoStandWidget_InfoStandBotView_1 != null && UnknownVarFromInfoStandWidget_InfoStandBotView_1.window != null && Boolean(UnknownVarFromInfoStandWidget_InfoStandBotView_1.window.visible))
               {
                  _loc2_ = param1.id == _userData.userRoomId;
                  break;
               }
               if(UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1 != null && UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1.window != null && Boolean(UnknownVarFromInfoStandWidget_InfoStandRentableBotView_1.window.visible))
               {
                  _loc2_ = param1.id == _rentableBotData.userRoomId;
               }
               break;
         }
         if(_loc2_)
         {
            close();
         }
      }
      
      private function onSongUpdate(param1:RoomWidgetSongUpdateEvent) : void
      {
         UnknownVarFromInfoStandWidget_InfoStandJukeboxView_1.updateSongInfo(param1);
         UnknownVarFromInfoStandWidget_InfoStandSongDiskView_1.updateSongInfo(param1);
      }
      
      public function close() : void
      {
         hideChildren();
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function onClose(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         close();
         if(UnknownVarFromInfoStandWidget_Timer_1)
         {
            UnknownVarFromInfoStandWidget_Timer_1.stop();
         }
      }
      
      private function hideChildren() : void
      {
         var _loc1_:int = 0;
         if(UnknownVarFromInfoStandWidget_IWindowController_1_1 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < UnknownVarFromInfoStandWidget_IWindowController_1_1.numChildren)
            {
               UnknownVarFromInfoStandWidget_IWindowController_1_1.getChildAt(_loc1_).visible = false;
               _loc1_++;
            }
         }
      }
      
      public function isFurniViewVisible() : Boolean
      {
         var _loc1_:IWindowModel = null;
         if(UnknownVarFromInfoStandWidget_IWindowController_1_1 != null)
         {
            _loc1_ = UnknownVarFromInfoStandWidget_IWindowController_1_1.getChildByName("infostand_furni_view") as IWindowModel;
            if(_loc1_ != null)
            {
               return _loc1_.visible;
            }
         }
         return false;
      }
      
      private function selectView(param1:String) : void
      {
         hideChildren();
         if(windowManager.LilithCustomsInstance.InfoStandDisabled)
         {
            return;
         }
         var _loc2_:IWindowModel = mainContainer.getChildByName(param1) as IWindowModel;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.visible = true;
         mainContainer.width = _loc2_.width;
         mainContainer.height = _loc2_.height;
      }
      
      public function refreshContainer() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mainContainer.numChildren)
         {
            _loc2_ = mainContainer.getChildAt(_loc1_);
            if(_loc2_.visible)
            {
               mainContainer.width = _loc2_.width;
               mainContainer.height = _loc2_.height;
            }
            _loc1_++;
         }
      }
      
      override public function release() : void
      {
         close();
         super.release();
      }
      
      private function getBadgeCodesFromSelectedBadges(param1:Array) : Array
      {
         param1 = param1 == null ? [] : param1;
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(!(_loc3_ == null || _loc3_.slotIndex < 0))
            {
               _loc2_[_loc3_.slotIndex] = _loc3_.badgeCode;
            }
         }
         return _loc2_;
      }
      
      private function shouldPreserveDisplayedBadges(param1:Boolean, param2:Array, param3:Array, param4:Array, param5:Array) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(hasSelectedBadges(param3) && !hasSelectedBadges(param5))
         {
            return true;
         }
         return areDisplayedBadgesEqual(param2,param3,param4,param5);
      }
      
      private function shouldPlayGlowForUserInfo(param1:Boolean, param2:Array, param3:Array, param4:Array, param5:Array) : Boolean
      {
         if(!param1)
         {
            return true;
         }
         if(hasSelectedBadges(param3) && !hasSelectedBadges(param5))
         {
            return false;
         }
         return !areDisplayedBadgesEqual(param2,param3,param4,param5);
      }
      
      private function areDisplayedBadgesEqual(param1:Array, param2:Array, param3:Array, param4:Array) : Boolean
      {
         var _loc6_:Boolean = hasSelectedBadges(param2);
         var _loc5_:Boolean = hasSelectedBadges(param4);
         if(_loc6_ || _loc5_)
         {
            return _loc6_ && _loc5_ && areSelectedBadgesEqual(param2,param4);
         }
         return areBadgeCodesEqual(param1,param3);
      }
      
      private function hasSelectedBadges(param1:Array) : Boolean
      {
         return param1 != null && param1.length > 0;
      }
      
      private function areBadgeCodesEqual(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         param1 = param1 == null ? [] : param1;
         param2 = param2 == null ? [] : param2;
         if(param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] !== param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function areSelectedBadgesEqual(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         param1 = param1 == null ? [] : param1;
         param2 = param2 == null ? [] : param2;
         if(param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            if(!areSelectedBadgeEntriesEqual(getSelectedBadgeBySlot(param1,_loc3_),getSelectedBadgeBySlot(param2,_loc3_)))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function areSelectedBadgeEntriesEqual(param1:SelectedBadgeData, param2:SelectedBadgeData) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1 == null || param2 == null)
         {
            return false;
         }
         return param1.slotIndex == param2.slotIndex && param1.badgeCode == param2.badgeCode && param1.ownerCount == param2.ownerCount && param1.badgeRarityId == param2.badgeRarityId;
      }
      
      private function getSelectedBadgeBySlot(param1:Array, param2:int) : SelectedBadgeData
      {
         param1 = param1 == null ? [] : param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_ != null && _loc3_.slotIndex == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

