package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.communication.messages.incoming.room.pets.RarityCategoryData;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.SelectedBadgeData;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.DropCarryItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemToPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GiveSupplementToPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.PetSelectedMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
   import com.sulake.habbo.friendlist.UnknownIHabboFriendlist1;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.object.data.UnknownHabboRoomObjectData1;
   import com.sulake.habbo.session.IPetInfo;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.sound.IHabboSoundBase_2;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.UnknownIHabboSound1;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.BreedingRarityCategoryData;
   import com.sulake.habbo.ui.widget.events.ConfirmPetBreedingPetData;
   import com.sulake.habbo.ui.widget.events.PetBreedingResultEventData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetConfirmPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetBreedingResultEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.infostand.InfoStandFurniData;
   import com.sulake.habbo.ui.widget.infostand.InfoStandWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeImageMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.FurniId;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class InfoStandWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _cachedPetImages:Map = new Map();
      
      private var UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1:UnknownIHabboSound1;
      
      private var UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1:InfoStandWidget;
      
      private var UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2:IMessageEvent;
      
      public function InfoStandWidgetHandler(param1:UnknownIHabboSound1)
      {
         super();
         UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 = param1;
         if(UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 != null)
         {
            UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.events.addEventListener("NPE_SONG_CHANGED",onNowPlayingChanged);
            UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         }
      }
      
      public function set widget(param1:InfoStandWidget) : void
      {
         UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1 = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_INFOSTAND";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null)
         {
            if(_container.roomSessionManager != null)
            {
               _container.roomSessionManager.events.removeEventListener("RSUBE_FIGURE",onFigureUpdate);
               _container.roomSessionManager.events.removeEventListener("RSPIUE_PET_INFO",onPetInfo);
               _container.roomSessionManager.events.removeEventListener("RSPIUE_ENABLED_PET_COMMANDS",onPetCommands);
               _container.roomSessionManager.events.removeEventListener("rsfgue_favourite_group_update",onFavouriteGroupUpdated);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING_RESULT",onPetBreedingResult);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_PET_BREEDING",onPetBreedingEvent);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING",onConfirmPetBreedingEvent);
               _container.roomSessionManager.events.removeEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT",onConfirmPetBreedingResultEvent);
            }
            if(_container.connection != null)
            {
               if(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1 != null)
               {
                  _container.connection.removeMessageEvent(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1);
                  UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1.dispose();
                  UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1 = null;
               }
               if(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2 != null)
               {
                  _container.connection.removeMessageEvent(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2);
                  UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2.dispose();
                  UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2 = null;
               }
            }
         }
         _container = param1;
         if(param1 == null)
         {
            return;
         }
         if(_container.roomSessionManager != null)
         {
            _container.roomSessionManager.events.addEventListener("RSUBE_FIGURE",onFigureUpdate);
            _container.roomSessionManager.events.addEventListener("RSPIUE_PET_INFO",onPetInfo);
            _container.roomSessionManager.events.addEventListener("RSPIUE_ENABLED_PET_COMMANDS",onPetCommands);
            _container.roomSessionManager.events.addEventListener("rsfgue_favourite_group_update",onFavouriteGroupUpdated);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING_RESULT",onPetBreedingResult);
            _container.roomSessionManager.events.addEventListener("RSPFUE_PET_BREEDING",onPetBreedingEvent);
            _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING",onConfirmPetBreedingEvent);
            _container.roomSessionManager.events.addEventListener("RSPFUE_CONFIRM_PET_BREEDING_RESULT",onConfirmPetBreedingResultEvent);
         }
         if(_container.connection)
         {
            UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1 = new HabboGroupDetailsMessageEvent(onGroupDetails);
            _container.connection.addMessageEvent(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_1);
            UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2 = new RelationshipStatusInfoEvent(onRelationshipStatusEvent);
            _container.connection.addMessageEvent(UnknownVarFromInfoStandWidgetHandler_IMessageEvent_2);
         }
      }
      
      private function onGroupDetails(param1:HabboGroupDetailsMessageEvent) : void
      {
         var _loc2_:HabboGroupDetailsData = param1.data;
         if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniData.groupId == _loc2_.groupId)
         {
            UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniView.groupBadgeId = _loc2_.badgeCode;
            UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniView.groupName = _loc2_.groupName;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BitmapData = null;
         if(_cachedPetImages != null)
         {
            _loc1_ = _cachedPetImages.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = _cachedPetImages.getWithIndex(_loc1_);
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
               _loc2_ = null;
               _loc1_--;
            }
            _cachedPetImages.dispose();
            _cachedPetImages = null;
         }
         if(UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 != null)
         {
            UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.events.removeEventListener("NPE_SONG_CHANGED",onNowPlayingChanged);
            UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 = null;
         }
         _disposed = true;
         container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWROM_GET_OBJECT_INFO");
         _loc1_.push("RWROM_GET_OBJECT_NAME");
         _loc1_.push("RWUAM_SEND_FRIEND_REQUEST");
         _loc1_.push("RWUAM_RESPECT_USER");
         _loc1_.push("RWUAM_REPLENISH_RESPECT_USER");
         _loc1_.push("RWUAM_WIRED_INSPECT");
         _loc1_.push("RWUAM_WIRED_INSPECT_PET");
         _loc1_.push("RWUAM_WIRED_INSPECT_BOT");
         _loc1_.push("RWUAM_OPEN_PROFILE");
         _loc1_.push("RWUAM_WHISPER_USER");
         _loc1_.push("RWUAM_IGNORE_USER");
         _loc1_.push("RWUAM_UNIGNORE_USER");
         _loc1_.push("RWUAM_KICK_USER");
         _loc1_.push("RWUAM_BAN_USER_DAY");
         _loc1_.push("RWUAM_BAN_USER_HOUR");
         _loc1_.push("RWUAM_BAN_USER_PERM");
         _loc1_.push("RWUAM_MUTE_USER_2MIN");
         _loc1_.push("RWUAM_MUTE_USER_5MIN");
         _loc1_.push("RWUAM_MUTE_USER_10MIN");
         _loc1_.push("RWUAM_GIVE_RIGHTS");
         _loc1_.push("RWUAM_TAKE_RIGHTS");
         _loc1_.push("RWUAM_START_TRADING");
         _loc1_.push("RWUAM_OPEN_HOME_PAGE");
         _loc1_.push("RWUAM_PASS_CARRY_ITEM");
         _loc1_.push("RWUAM_GIVE_CARRY_ITEM_TO_PET");
         _loc1_.push("RWUAM_DROP_CARRY_ITEM");
         _loc1_.push("RWFAM_MOVE");
         _loc1_.push("RWFUAM_ROTATE");
         _loc1_.push("RWFAM_PICKUP");
         _loc1_.push("RWFAM_EJECT");
         _loc1_.push("RWFAM_USE");
         _loc1_.push("RWFAM_SAVE_STUFF_DATA");
         _loc1_.push("RWFAM_WIRED_INSPECT");
         _loc1_.push("RWRTSM_ROOM_TAG_SEARCH");
         _loc1_.push("RWGOI_MESSAGE_GET_BADGE_DETAILS");
         _loc1_.push("RWGOI_MESSAGE_GET_BADGE_IMAGE");
         _loc1_.push("RWUAM_REPORT");
         _loc1_.push("RWUAM_PICKUP_PET");
         _loc1_.push("RWUAM_MOUNT_PET");
         _loc1_.push("RWUAM_TOGGLE_PET_RIDING_PERMISSION");
         _loc1_.push("RWUAM_TOGGLE_PET_BREEDING_PERMISSION");
         _loc1_.push("RWUAM_DISMOUNT_PET");
         _loc1_.push("RWUAM_SADDLE_OFF");
         _loc1_.push("RWUAM_TRAIN_PET");
         _loc1_.push("RWPCM_PET_COMMAND");
         _loc1_.push("RWPCM_REQUEST_PET_COMMANDS");
         _loc1_.push(" RWUAM_RESPECT_PET");
         _loc1_.push("RWUAM_REQUEST_PET_UPDATE");
         _loc1_.push("RWVM_CHANGE_MOTTO_MESSAGE");
         _loc1_.push("RWOPEM_OPEN_USER_PROFILE");
         _loc1_.push("RWPOM_OPEN_PRESENT");
         _loc1_.push("RWUAM_GIVE_LIGHT_TO_PET");
         _loc1_.push("RWUAM_GIVE_WATER_TO_PET");
         _loc1_.push("RWUAM_TREAT_PET");
         _loc1_.push("RWUAM_REPORT_CFH_OTHER");
         _loc1_.push("RWUAM_AMBASSADOR_ALERT_USER");
         _loc1_.push("RWUAM_AMBASSADOR_KICK_USER");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_2MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_10MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_15MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_60MIN");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_18HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_36HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_MUTE_72HOUR");
         _loc1_.push("RWUAM_AMBASSADOR_UNMUTE");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:IUserData = null;
         var _loc23_:int = 0;
         var _loc18_:int = 0;
         var _loc8_:String = null;
         var _loc6_:RoomWidgetChatInputContentUpdateEvent = null;
         var _loc3_:IUserData = null;
         _loc8_ = null;
         var _loc7_:String = null;
         var _loc25_:Map = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc13_:String = null;
         var _loc12_:String = null;
         var _loc28_:RoomWidgetRoomTagSearchMessage = null;
         var _loc21_:RoomWidgetGetBadgeDetailsMessage = null;
         var _loc16_:RoomWidgetGetBadgeImageMessage = null;
         var _loc24_:RoomWidgetPetCommandMessage = null;
         var _loc9_:RoomWidgetPetCommandMessage = null;
         var _loc26_:RoomWidgetChangeMottoMessage = null;
         var _loc17_:RoomWidgetOpenProfileMessage = null;
         var _loc10_:RoomWidgetPresentOpenMessage = null;
         var _loc11_:InfoStandFurniData = null;
         if(param1 == null)
         {
            return null;
         }
         if(_container == null)
         {
            return null;
         }
         var _loc22_:int = 0;
         var _loc15_:RoomWidgetUserActionMessage = param1 as RoomWidgetUserActionMessage;
         if(_loc15_ != null)
         {
            _loc22_ = _loc15_.userId;
            if(param1.type == "RWUAM_REQUEST_PET_UPDATE" || param1.type == " RWUAM_RESPECT_PET" || param1.type == "RWUAM_PICKUP_PET" || param1.type == "RWUAM_WIRED_INSPECT_PET" || param1.type == "RWUAM_MOUNT_PET" || param1.type == "RWUAM_TOGGLE_PET_RIDING_PERMISSION" || param1.type == "RWUAM_TOGGLE_PET_BREEDING_PERMISSION" || param1.type == "RWUAM_DISMOUNT_PET" || param1.type == "RWUAM_SADDLE_OFF" || param1.type == "RWUAM_GIVE_CARRY_ITEM_TO_PET" || param1.type == "RWUAM_GIVE_WATER_TO_PET" || param1.type == "RWUAM_GIVE_LIGHT_TO_PET" || param1.type == "RWUAM_TREAT_PET")
            {
               _loc2_ = _container.roomSession.userDataManager.getPetUserData(_loc22_);
            }
            else if(param1.type == "RWUAM_WIRED_INSPECT_BOT")
            {
               _loc2_ = _container.roomSession.userDataManager.getRentableBotUserData(_loc22_);
            }
            else
            {
               _loc2_ = _container.roomSession.userDataManager.getUserData(_loc22_);
            }
            if(_loc2_ == null)
            {
               return null;
            }
         }
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc27_:RoomWidgetFurniActionMessage = param1 as RoomWidgetFurniActionMessage;
         if(_loc27_ != null)
         {
            _loc19_ = _loc27_.furniId;
            _loc20_ = _loc27_.furniCategory;
         }
         switch(param1.type)
         {
            case "RWROM_GET_OBJECT_INFO":
               return handleGetObjectInfoMessage(param1 as RoomWidgetRoomObjectMessage);
            case "RWROM_GET_OBJECT_NAME":
               return handleGetObjectNameMessage(param1 as RoomWidgetRoomObjectMessage);
            case "RWUAM_SEND_FRIEND_REQUEST":
               _container.friendList.askForAFriend(_loc22_,_loc2_.name);
               break;
            case "RWUAM_RESPECT_USER":
               _container.sessionDataManager.giveRespect(_loc22_);
               break;
            case "RWUAM_REPLENISH_RESPECT_USER":
               _loc23_ = _container.catalog.getPurse().getActivityPointsForType(0);
               _loc18_ = container.config.getInteger("respect.replenish_cost_duckets",50);
               if(_loc23_ < _loc18_)
               {
                  container.windowManager.alert("${respect.replenish.not_enough_duckets.title}",_container.localization.getLocalizationWithParams("respect.replenish.not_enough_duckets.title","","amount",_loc18_),0,null);
               }
               else
               {
                  container.windowManager.confirm("${respect.replenish.title}",_container.localization.getLocalizationWithParams("respect.replenish.desc","","amount",_loc18_),0,onRespectReplenishClicked);
               }
               break;
            case "RWUAM_WIRED_INSPECT":
            case "RWUAM_WIRED_INSPECT_BOT":
            case "RWUAM_WIRED_INSPECT_PET":
               _loc8_ = "wiredmenu/open/inspection/1/" + _loc2_.roomObjectId;
               (_container.roomEngine as Component).context.createLinkEvent(_loc8_);
               break;
            case "RWUAM_OPEN_PROFILE":
               _container.connection.send(new GetExtendedProfileMessageComposer(_loc2_.webID));
               break;
            case " RWUAM_RESPECT_PET":
               _container.sessionDataManager.givePetRespect(_loc22_);
               break;
            case "RWUAM_WHISPER_USER":
               _loc6_ = new RoomWidgetChatInputContentUpdateEvent("whisper",_loc2_.name);
               _container.events.dispatchEvent(_loc6_);
               break;
            case "RWUAM_IGNORE_USER":
               _container.sessionDataManager.ignoreUser(_loc2_.webID);
               break;
            case "RWUAM_UNIGNORE_USER":
               _container.sessionDataManager.unignoreUser(_loc2_.webID);
               break;
            case "RWUAM_KICK_USER":
               _container.roomSession.kickUser(_loc2_.webID);
               break;
            case "RWUAM_BAN_USER_DAY":
            case "RWUAM_BAN_USER_HOUR":
            case "RWUAM_BAN_USER_PERM":
               _container.roomSession.banUserWithDuration(_loc2_.webID,param1.type);
               break;
            case "RWUAM_MUTE_USER_2MIN":
               _container.roomSession.muteUser(_loc2_.webID,2);
               break;
            case "RWUAM_MUTE_USER_5MIN":
               _container.roomSession.muteUser(_loc2_.webID,5);
               break;
            case "RWUAM_MUTE_USER_10MIN":
               _container.roomSession.muteUser(_loc2_.webID,10);
               break;
            case "RWUAM_GIVE_RIGHTS":
               _container.roomSession.assignRights(_loc2_.webID);
               break;
            case "RWUAM_TAKE_RIGHTS":
               _container.roomSession.removeRights(_loc2_.webID);
               break;
            case "RWUAM_START_TRADING":
               _loc3_ = _container.roomSession.userDataManager.getUserData(_loc15_.userId);
               _container.inventory.setupTrading(_loc3_.roomObjectId,_loc3_.name);
               break;
            case "RWUAM_OPEN_HOME_PAGE":
               _container.sessionDataManager.openHabboHomePage(_loc2_.webID,_loc2_.name);
               break;
            case "RWUAM_PICKUP_PET":
               _container.roomSession.pickUpPet(_loc22_);
               break;
            case "RWUAM_MOUNT_PET":
               _container.roomSession.mountPet(_loc22_);
               break;
            case "RWUAM_TOGGLE_PET_RIDING_PERMISSION":
               _container.roomSession.togglePetRidingPermission(_loc22_);
               break;
            case "RWUAM_TOGGLE_PET_BREEDING_PERMISSION":
               _container.roomSession.togglePetBreedingPermission(_loc22_);
               break;
            case "RWUAM_DISMOUNT_PET":
               _container.roomSession.dismountPet(_loc22_);
               break;
            case "RWUAM_SADDLE_OFF":
               _container.roomSession.removeSaddleFromPet(_loc22_);
               break;
            case "RWUAM_PASS_CARRY_ITEM":
               _container.connection.send(new PassCarryItemMessageComposer(_loc22_));
               break;
            case "RWUAM_GIVE_CARRY_ITEM_TO_PET":
               _container.connection.send(new PassCarryItemToPetMessageComposer(_loc22_));
               break;
            case "RWUAM_GIVE_WATER_TO_PET":
               _container.connection.send(new GiveSupplementToPetMessageComposer(_loc22_,0));
               break;
            case "RWUAM_GIVE_LIGHT_TO_PET":
               _container.connection.send(new GiveSupplementToPetMessageComposer(_loc22_,1));
               break;
            case "RWUAM_TREAT_PET":
               _container.connection.send(new RespectPetMessageComposer(_loc22_));
               break;
            case "RWUAM_DROP_CARRY_ITEM":
               _container.connection.send(new DropCarryItemMessageComposer());
               break;
            case "RWFUAM_ROTATE":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_ROTATE_POSITIVE");
               break;
            case "RWFAM_MOVE":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_MOVE");
               break;
            case "RWFAM_PICKUP":
               pickupObjectWithConfirmation(_loc19_,_loc20_);
               break;
            case "RWFAM_EJECT":
               _container.roomEngine.modifyRoomObject(_loc19_,_loc20_,"OBJECT_EJECT");
               break;
            case "RWFAM_USE":
               _container.roomEngine.useRoomObjectInActiveRoom(_loc19_,_loc20_);
               break;
            case "RWFAM_WIRED_INSPECT":
               _loc8_ = "wiredmenu/open/inspection/0/";
               if(_loc20_ == 10)
               {
                  _loc8_ += String(_loc19_);
               }
               else
               {
                  if(_loc20_ != 20)
                  {
                     break;
                  }
                  _loc8_ += String(-_loc19_);
               }
               (_container.roomEngine as Component).context.createLinkEvent(_loc8_);
               break;
            case "RWFAM_SAVE_STUFF_DATA":
               _loc7_ = _loc27_.objectData;
               if(_loc7_ != null)
               {
                  _loc25_ = new Map();
                  _loc4_ = _loc7_.split("\t");
                  if(_loc4_ != null)
                  {
                     for each(var _loc14_ in _loc4_)
                     {
                        _loc5_ = _loc14_.split("=",2);
                        if(_loc5_ != null && _loc5_.length == 2)
                        {
                           _loc13_ = _loc5_[0];
                           _loc12_ = _loc5_[1];
                           _loc25_.add(_loc13_,_loc12_);
                        }
                     }
                  }
                  _container.roomEngine.modifyRoomObjectDataWithMap(_loc19_,_loc20_,"OBJECT_SAVE_STUFF_DATA",_loc25_);
                  if(!_loc25_.disposed)
                  {
                     _loc25_.dispose();
                  }
               }
               break;
            case "RWUAM_REQUEST_PET_UPDATE":
               if(_container.roomSession != null && _container.roomSession.userDataManager != null)
               {
                  _container.roomSession.userDataManager.requestPetInfo(_loc22_);
               }
               break;
            case "RWRTSM_ROOM_TAG_SEARCH":
               _loc28_ = param1 as RoomWidgetRoomTagSearchMessage;
               if(_loc28_ == null)
               {
                  return null;
               }
               _container.navigator.performTagSearch(_loc28_.tag);
               break;
            case "RWGOI_MESSAGE_GET_BADGE_DETAILS":
               _loc21_ = param1 as RoomWidgetGetBadgeDetailsMessage;
               if(_loc21_ == null)
               {
                  return null;
               }
               _container.habboGroupsManager.showGroupBadgeInfo(_loc21_.own,_loc21_.groupId);
               break;
            case "RWGOI_MESSAGE_GET_BADGE_IMAGE":
               _loc16_ = param1 as RoomWidgetGetBadgeImageMessage;
               if(_loc16_ == null)
               {
                  return null;
               }
               if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1 != null)
               {
                  UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.refreshBadge(_loc16_.badgeId);
               }
               break;
            case "RWUAM_REPORT":
               if(!(_container == null || _container.habboHelp == null))
               {
                  if(_loc2_ != null)
                  {
                     _container.habboHelp.reportUser(_loc22_,-1,null);
                  }
               }
               break;
            case "RWUAM_REPORT_CFH_OTHER":
               _container.habboHelp.reportUser(_loc22_,124,null);
               break;
            case "RWPCM_REQUEST_PET_COMMANDS":
               _loc24_ = param1 as RoomWidgetPetCommandMessage;
               _container.roomSession.requestPetCommands(_loc24_.petId);
               break;
            case "RWPCM_PET_COMMAND":
               _loc9_ = param1 as RoomWidgetPetCommandMessage;
               _container.roomSession.sendChatMessage(_loc9_.value);
               break;
            case "RWVM_CHANGE_MOTTO_MESSAGE":
               _loc26_ = param1 as RoomWidgetChangeMottoMessage;
               _container.roomSession.sendChangeMottoMessage(_loc26_.motto);
               break;
            case "RWOPEM_OPEN_USER_PROFILE":
               _loc17_ = param1 as RoomWidgetOpenProfileMessage;
               if(_container.habboTracking)
               {
                  _container.habboTracking.trackGoogle("extendedProfile",_loc17_.trackingLocation);
               }
               _container.connection.send(new GetExtendedProfileMessageComposer(_loc17_.userId));
               break;
            case "RWPOM_OPEN_PRESENT":
               _loc10_ = param1 as RoomWidgetPresentOpenMessage;
               if(_loc10_ != null && UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1 != null)
               {
                  _loc11_ = UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniData;
                  if(_loc11_ != null && _loc11_.id == _loc10_.objectId)
                  {
                     if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.isFurniViewVisible())
                     {
                        UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.close();
                     }
                  }
               }
               break;
            case "RWUAM_AMBASSADOR_ALERT_USER":
               _container.roomSession.ambassadorAlert(_loc2_.webID);
               break;
            case "RWUAM_AMBASSADOR_KICK_USER":
               _container.roomSession.kickUser(_loc2_.webID);
               break;
            case "RWUAM_AMBASSADOR_MUTE_2MIN":
               _container.roomSession.muteUser(_loc2_.webID,2);
               break;
            case "RWUAM_AMBASSADOR_MUTE_10MIN":
               _container.roomSession.muteUser(_loc2_.webID,10);
               break;
            case "RWUAM_AMBASSADOR_MUTE_15MIN":
               _container.roomSession.muteUser(_loc2_.webID,15);
               break;
            case "RWUAM_AMBASSADOR_MUTE_60MIN":
               _container.roomSession.muteUser(_loc2_.webID,60);
               break;
            case "RWUAM_AMBASSADOR_MUTE_18HOUR":
               _container.roomSession.muteUser(_loc2_.webID,1080);
               break;
            case "RWUAM_AMBASSADOR_MUTE_36HOUR":
               _container.roomSession.muteUser(_loc2_.webID,2160);
               break;
            case "RWUAM_AMBASSADOR_MUTE_72HOUR":
               _container.roomSession.muteUser(_loc2_.webID,4320);
               break;
            case "RWUAM_AMBASSADOR_UNMUTE":
               _container.roomSession.unmuteUser(_loc2_.webID);
         }
         return null;
      }
      
      private function onRespectReplenishClicked(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _container.sessionDataManager.replenishRespect();
         }
      }
      
      private function pickupObjectWithConfirmation(param1:int, param2:int) : void
      {
         var furniId:int = param1;
         var furniCategory:int = param2;
         if(_container != null)
         {
            if(FurniId.isBuilderClubId(furniId) && _container.catalog.buildersClubEnabled)
            {
               if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniData.availableForBuildersClub)
               {
                  _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
               }
               else
               {
                  _container.windowManager.confirm("${generic.alert.title}","${room.confirm.not_in_warehouse}",0,function(param1:UnknownICoreWindowUtils2, param2:WindowEvent):void
                  {
                     param1.dispose();
                     if(param2.type == "WE_OK")
                     {
                        _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
                     }
                  });
               }
            }
            else
            {
               _container.roomEngine.modifyRoomObject(furniId,furniCategory,"OBJECT_PICKUP");
            }
         }
      }
      
      private function handleGetObjectNameMessage(param1:RoomWidgetRoomObjectMessage) : RoomWidgetUpdateEvent
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc4_:String = null;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc7_:IFurnitureData = null;
         var _loc2_:IUserData = null;
         var _loc11_:int = _container.roomSession.roomId;
         var _loc5_:String = null;
         switch(param1.category)
         {
            case 10:
            case 20:
               if(_container.events == null || _container.roomEngine == null)
               {
                  return null;
               }
               _loc3_ = _container.roomEngine.getRoomObject(_loc11_,param1.id,param1.category);
               _loc4_ = _loc3_.getType();
               if(_loc4_.indexOf("poster") == 0)
               {
                  _loc12_ = int(_loc4_.replace("poster",""));
                  _loc5_ = "${poster_" + _loc12_ + "_name}";
                  _loc6_ = _loc3_.getId();
                  _loc9_ = -1;
               }
               else
               {
                  _loc10_ = _loc3_.getModel().getNumber("furniture_type_id");
                  if(param1.category == 10)
                  {
                     _loc7_ = _container.sessionDataManager.getFloorItemData(_loc10_);
                  }
                  else if(param1.category == 20)
                  {
                     _loc7_ = _container.sessionDataManager.getWallItemData(_loc10_);
                  }
                  if(_loc7_ == null)
                  {
                     return null;
                  }
                  _loc5_ = _loc7_.localizedName;
                  _loc6_ = _loc3_.getId();
                  _loc9_ = _loc7_.id;
               }
               break;
            case 100:
               if(_container.roomSession == null || _container.sessionDataManager == null || _container.events == null || _container.roomEngine == null || _container.friendList == null)
               {
                  return null;
               }
               _loc2_ = _container.roomSession.userDataManager.getUserDataByIndex(param1.id);
               if(_loc2_ == null)
               {
                  return null;
               }
               _loc5_ = _loc2_.name;
               _loc8_ = _loc2_.type;
               _loc6_ = _loc2_.roomObjectId;
               _loc9_ = _loc2_.webID;
               break;
         }
         if(_loc5_ != null)
         {
            _container.events.dispatchEvent(new RoomWidgetRoomObjectNameEvent(_loc9_,param1.category,_loc5_,_loc8_,_loc6_));
         }
         return null;
      }
      
      private function handleGetObjectInfoMessage(param1:RoomWidgetRoomObjectMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:IUserData = null;
         var _loc3_:int = _container.roomSession.roomId;
         _container.windowManager.LilithCustomsInstance.HandleClickedObject(param1);
         switch(param1.category)
         {
            case 10:
            case 20:
               handleGetFurniInfoMessage(param1,_loc3_);
               break;
            case 100:
               if(_container.roomSession == null || _container.sessionDataManager == null || _container.events == null || _container.roomEngine == null || _container.friendList == null)
               {
                  return null;
               }
               _loc2_ = _container.roomSession.userDataManager.getUserDataByIndex(param1.id);
               if(_loc2_ == null)
               {
                  return null;
               }
               switch(_loc2_.type - 1)
               {
                  case 0:
                     handleGetUserInfoMessage(_loc3_,param1.id,param1.category,_loc2_);
                     break;
                  case 1:
                     handleGetPetInfoMessage(_loc2_.webID);
                     break;
                  case 2:
                     handleGetBotInfoMessage(_loc3_,param1.id,param1.category,_loc2_);
                     break;
                  case 3:
                     handleGetRentableBotInfoMessage(_loc3_,param1.id,param1.category,_loc2_);
               }
               if(_container.userDefinedRoomEvents != null)
               {
                  _container.userDefinedRoomEvents.userSelected(param1.id);
               }
               break;
         }
         return null;
      }
      
      private function handleGetPetInfoMessage(param1:int) : void
      {
         var _loc2_:Boolean = container.config.getBoolean("petSelect.enabled");
         if(_loc2_)
         {
            _container.connection.send(new PetSelectedMessageComposer(param1));
         }
         _container.roomSession.userDataManager.requestPetInfo(param1);
      }
      
      private function handleGetBotInfoMessage(param1:int, param2:int, param3:int, param4:IUserData) : void
      {
         var _loc7_:String = "RWUIUE_BOT";
         var _loc6_:RoomWidgetUserInfoUpdateEvent = new RoomWidgetUserInfoUpdateEvent(_loc7_);
         _loc6_.name = param4.name;
         _loc6_.motto = param4.custom;
         _loc6_.webID = param4.webID;
         _loc6_.userRoomId = param2;
         _loc6_.userType = param4.type;
         var _loc8_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc8_ != null)
         {
            _loc6_.carryItem = _loc8_.getModel().getNumber("figure_carry_object");
         }
         _loc6_.amIOwner = _container.roomSession.isRoomOwner;
         _loc6_.isGuildRoom = _container.roomSession.isGuildRoom;
         _loc6_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc6_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc6_.canBeKicked = _container.roomSession.isRoomOwner;
         var _loc5_:Array = [];
         _loc5_.push("BOT");
         _loc6_.badges = _loc5_;
         _loc6_.figure = param4.figure;
         _container.events.dispatchEvent(_loc6_);
      }
      
      private function handleGetRentableBotInfoMessage(param1:int, param2:int, param3:int, param4:IUserData) : void
      {
         var _loc6_:RoomWidgetRentableBotInfoUpdateEvent = new RoomWidgetRentableBotInfoUpdateEvent();
         _loc6_.name = param4.name;
         _loc6_.motto = param4.custom;
         _loc6_.webID = param4.webID;
         _loc6_.userRoomId = param2;
         _loc6_.ownerId = param4.ownerId;
         _loc6_.ownerName = param4.ownerName;
         _loc6_.botSkills = param4.botSkills;
         var _loc7_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc7_ != null)
         {
            _loc6_.carryItem = _loc7_.getModel().getNumber("figure_carry_object");
         }
         _loc6_.amIOwner = _container.roomSession.isRoomOwner;
         _loc6_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc6_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         var _loc5_:Array = [];
         _loc5_.push("BOT");
         _loc6_.badges = _loc5_;
         _loc6_.figure = param4.figure;
         _container.events.dispatchEvent(_loc6_);
      }
      
      private function handleGetUserInfoMessage(param1:int, param2:int, param3:int, param4:IUserData) : void
      {
         var _loc7_:String = null;
         var _loc5_:RoomWidgetUserInfoUpdateEvent = null;
         var _loc6_:UnknownIHabboFriendlist1 = null;
         var _loc10_:Number = NaN;
         var _loc11_:* = false;
         var _loc12_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         _loc7_ = "RWUIUE_OWN_USER";
         if(param4.webID != _container.sessionDataManager.userId)
         {
            _loc7_ = "RWUIUE_PEER";
         }
         _loc5_ = new RoomWidgetUserInfoUpdateEvent(_loc7_);
         _loc5_.isSpectatorMode = _container.roomSession.isSpectatorMode;
         _loc5_.name = param4.name;
         _loc5_.motto = param4.custom;
         if(isActivityDisplayEnabled)
         {
            _loc5_.achievementScore = param4.achievementScore;
         }
         _loc5_.badgesRank = param4.badgesRank;
         _loc5_.webID = param4.webID;
         _loc5_.userRoomId = param2;
         _loc5_.userType = 1;
         var _loc13_:IRoomObject = _container.roomEngine.getRoomObject(param1,param2,param3);
         if(_loc13_ != null)
         {
            _loc5_.carryItem = _loc13_.getModel().getNumber("figure_carry_object");
         }
         if(_loc7_ == "RWUIUE_OWN_USER")
         {
            _loc5_.realName = _container.sessionDataManager.realName;
            _loc5_.allowNameChange = _container.sessionDataManager.nameChangeAllowed;
         }
         _loc5_.amIOwner = _container.roomSession.isRoomOwner;
         _loc5_.isGuildRoom = _container.roomSession.isGuildRoom;
         _loc5_.myRoomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc5_.amIAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc5_.amIAnAmbassador = _container.sessionDataManager.isAmbassador;
         if(_loc7_ == "RWUIUE_PEER")
         {
            _loc5_.isBlocked = _container.sessionDataManager.isBlocked(param4.webID);
            _loc5_.canBeAskedAsFriend = _container.friendList.canBeAskedForAFriend(param4.webID);
            _loc6_ = _container.friendList.getFriend(param4.webID);
            if(_loc6_ != null)
            {
               _loc5_.realName = _loc6_.realName;
               _loc5_.isFriend = true;
            }
            if(_loc13_ != null)
            {
               _loc10_ = _loc13_.getModel().getNumber("figure_flat_control");
               if(!isNaN(_loc10_))
               {
                  _loc5_.targetRoomControllerLevel = _loc10_;
               }
               _loc5_.canBeMuted = determineCanBeMuted(_loc5_);
               _loc5_.canBeKicked = determineCanBeKicked(_loc5_);
               _loc5_.canBeBanned = determineCanBeBanned(_loc5_);
               Logger.log("Set moderation levels to " + _loc5_.name + "Muted: " + _loc5_.canBeMuted + ", Kicked: " + _loc5_.canBeKicked + ", Banned: " + _loc5_.canBeBanned);
            }
            _loc5_.isIgnored = _container.sessionDataManager.isIgnored(param4.webID);
            _loc5_.respectLeft = _container.sessionDataManager.respectLeft;
            _loc5_.respectReplenishesLeft = _container.sessionDataManager.respectReplenishesLeft;
            _loc11_ = !_container.sessionDataManager.systemShutDown;
            _loc12_ = _container.roomSession.tradeMode;
            if(!_loc11_)
            {
               _loc5_.canTrade = false;
            }
            else
            {
               switch(_loc12_ - 1)
               {
                  case 0:
                     _loc8_ = _loc5_.myRoomControllerLevel != 0 && _loc5_.myRoomControllerLevel != 2;
                     _loc9_ = _loc5_.targetRoomControllerLevel != 0 && _loc5_.targetRoomControllerLevel != 2;
                     _loc5_.canTrade = _loc8_ || _loc9_;
                     break;
                  case 1:
                     _loc5_.canTrade = true;
                     break;
                  default:
                     _loc5_.canTrade = false;
               }
            }
            _loc5_.canTradeReason = 0;
            if(!_loc11_)
            {
               _loc5_.canTradeReason = 2;
            }
            if(_loc12_ != 2)
            {
               _loc5_.canTradeReason = 3;
            }
         }
         _loc5_.groupId = int(param4.groupID);
         _loc5_.groupBadgeId = _container.sessionDataManager.getGroupBadgeId(int(param4.groupID));
         _loc5_.groupName = param4.groupName;
         _container.roomSession.userDataManager.requestUserSelectedBadges(param4.webID);
         var _loc14_:Array = _container.roomSession.userDataManager.getUserSelectedBadges(param4.webID);
         _loc5_.selectedBadges = _loc14_;
         _loc5_.badges = getBadgeCodesFromSelectedBadges(_loc14_);
         _loc5_.figure = param4.figure;
         _container.events.dispatchEvent(_loc5_);
         _container.habboGroupsManager.updateVisibleExtendedProfile(param4.webID);
         _container.connection.send(new GetRelationshipStatusInfoMessageComposer(param4.webID));
      }
      
      private function determineCanBeMuted(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:RoomModerationSettings):Boolean
         {
            return checkUserWithRightsModerationLevel(param1,param2.whoCanMute);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function determineCanBeKicked(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:RoomModerationSettings):Boolean
         {
            if(param2.whoCanKick == 2)
            {
               return true;
            }
            return checkUserWithRightsModerationLevel(param1,param2.whoCanKick);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function determineCanBeBanned(param1:RoomWidgetUserInfoUpdateEvent) : Boolean
      {
         var userInfo:RoomWidgetUserInfoUpdateEvent = param1;
         var settingsFunction:Function = function(param1:RoomWidgetUserInfoUpdateEvent, param2:RoomModerationSettings):Boolean
         {
            return checkUserWithRightsModerationLevel(param1,param2.whoCanBan);
         };
         return determineModerationLevel(userInfo,settingsFunction);
      }
      
      private function checkUserWithRightsModerationLevel(param1:RoomWidgetUserInfoUpdateEvent, param2:int) : Boolean
      {
         var _loc3_:Boolean = param1.myRoomControllerLevel == 1 || param1.myRoomControllerLevel >= 4;
         var _loc4_:Boolean = param1.isGuildRoom && param1.myRoomControllerLevel >= 3;
         switch(param2 - 1)
         {
            case 0:
               return _loc3_;
            case 3:
               return _loc4_;
            case 4:
               return _loc3_ || _loc4_;
            default:
               return param1.myRoomControllerLevel >= 4;
         }
      }
      
      private function determineModerationLevel(param1:RoomWidgetUserInfoUpdateEvent, param2:Function) : Boolean
      {
         if(!_container.roomSession.isPrivateRoom)
         {
            return false;
         }
         var _loc4_:Boolean = false;
         var _loc3_:RoomModerationSettings = _container.roomSession.roomModerationSettings;
         if(_loc3_ != null)
         {
            _loc4_ = param2(param1,_loc3_);
         }
         return _loc4_ && param1.targetRoomControllerLevel < 4;
      }
      
      private function handleGetFurniInfoMessage(param1:RoomWidgetRoomObjectMessage, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc12_:IFurnitureData = null;
         var _loc17_:int = 0;
         var _loc4_:String = null;
         var _loc22_:String = null;
         var _loc7_:String = null;
         var _loc5_:IHabboSoundBase_2 = null;
         var _loc19_:String = null;
         var _loc18_:ISongInfo = null;
         if(_container.events == null || _container.roomEngine == null)
         {
            return;
         }
         if(param1.id < 0)
         {
            return;
         }
         var _loc20_:RoomWidgetFurniInfoUpdateEvent = new RoomWidgetFurniInfoUpdateEvent("RWFIUE_FURNI");
         _loc20_.id = param1.id;
         _loc20_.category = param1.category;
         var _loc9_:IRoomObject = _container.roomEngine.getRoomObject(param2,param1.id,param1.category);
         if(!_loc9_)
         {
            return;
         }
         var _loc14_:IRoomObjectModel = _loc9_.getModel();
         if(_loc14_.getString("RWEIEP_INFOSTAND_EXTRA_PARAM") != null)
         {
            _loc20_.extraParam = _loc14_.getString("RWEIEP_INFOSTAND_EXTRA_PARAM");
         }
         var _loc16_:int = _loc14_.getNumber("furniture_data_format");
         var _loc10_:IStuffData = UnknownHabboRoomObjectData1.getStuffDataWrapperForType(_loc16_);
         _loc10_.initializeFromRoomObjectModel(_loc14_);
         _loc20_.stuffData = _loc10_;
         var _loc11_:String = _loc9_.getType();
         if(_loc11_.indexOf("poster") == 0)
         {
            _loc8_ = int(_loc11_.replace("poster",""));
            _loc20_.name = "${poster_" + _loc8_ + "_name}";
            _loc20_.description = "${poster_" + _loc8_ + "_desc}";
         }
         else
         {
            _loc15_ = _loc14_.getNumber("furniture_type_id");
            if(param1.category == 10)
            {
               _loc12_ = _container.sessionDataManager.getFloorItemData(_loc15_);
            }
            else if(param1.category == 20)
            {
               _loc12_ = _container.sessionDataManager.getWallItemData(_loc15_);
            }
            if(_loc12_ != null)
            {
               _loc20_.name = _loc12_.localizedName;
               _loc20_.isNft = _loc12_.className.indexOf("nft_") == 0;
               _loc20_.description = _loc12_.description;
               _loc20_.purchaseOfferId = _loc12_.purchaseOfferId;
               _loc20_.bcOfferId = _loc12_.bcOfferId;
               _loc20_.tradeable = _loc12_.tradeable;
               _loc20_.purchaseCouldBeUsedForBuyout = _loc12_.purchaseCouldBeUsedForBuyout;
               _loc20_.rentOfferId = _loc12_.rentOfferId;
               _loc20_.rentCouldBeUsedForBuyout = _loc12_.rentCouldBeUsedForBuyout;
               _loc20_.availableForBuildersClub = _loc12_.availableForBuildersClub;
               _loc20_.classId = _loc15_;
            }
         }
         if(_container.userDefinedRoomEvents != null)
         {
            if(param1.category == 10)
            {
               _container.userDefinedRoomEvents.stuffSelected(_loc9_.getId());
            }
            else if(param1.category == 20)
            {
               _container.userDefinedRoomEvents.stuffSelected(-_loc9_.getId());
            }
         }
         if(_loc11_.indexOf("post_it") > -1)
         {
            _loc20_.isStickie = true;
         }
         var _loc3_:int = _loc14_.getNumber("furniture_expiry_time");
         var _loc21_:int = _loc14_.getNumber("furniture_expirty_timestamp");
         _loc20_.expiration = _loc3_ < 0 ? _loc3_ : Math.max(0,_loc3_ - (getTimer() - _loc21_) / 1000);
         var _loc13_:UnknownHabboRoom1 = _container.roomEngine.getRoomObjectImage(param2,param1.id,param1.category,new Vector3d(180),64,null);
         if(_loc13_.data == null || _loc13_.data.width > 140 || _loc13_.data.height > 200)
         {
            _loc13_ = _container.roomEngine.getRoomObjectImage(param2,param1.id,param1.category,new Vector3d(180),1,null);
         }
         _loc20_.image = _loc13_.data;
         _loc20_.isWallItem = param1.category == 20;
         _loc20_.isRoomOwner = _container.roomSession.isRoomOwner;
         _loc20_.roomControllerLevel = _container.roomSession.roomControllerLevel;
         _loc20_.isAnyRoomController = _container.sessionDataManager.isAnyRoomController;
         _loc20_.ownerId = _loc14_.getNumber("furniture_owner_id");
         _loc20_.ownerName = _loc14_.getString("furniture_owner_name");
         _loc20_.usagePolicy = _loc14_.getNumber("furniture_usage_policy");
         var _loc6_:int = _loc14_.getNumber("furniture_guild_customized_guild_id");
         if(_loc6_ != 0)
         {
            _loc20_.groupId = _loc6_;
            container.connection.send(new GetHabboGroupDetailsMessageComposer(_loc6_,false));
         }
         if(_container.isOwnerOfFurniture(_loc9_))
         {
            _loc20_.isOwner = true;
         }
         _container.events.dispatchEvent(_loc20_);
         if(_loc20_.extraParam != null && _loc20_.extraParam.length > 0)
         {
            _loc17_ = -1;
            _loc4_ = "";
            _loc22_ = "";
            _loc7_ = "";
            if(_loc20_.extraParam == "RWEIEP_JUKEBOX")
            {
               _loc5_ = UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.getRoomItemPlaylist();
               if(_loc5_ != null)
               {
                  _loc17_ = _loc5_.nowPlayingSongId;
                  _loc7_ = "RWSUE_PLAYING_CHANGED";
               }
            }
            else if(_loc20_.extraParam.indexOf("RWEIEP_SONGDISK") == 0)
            {
               _loc19_ = _loc20_.extraParam.substr("RWEIEP_SONGDISK".length);
               _loc17_ = parseInt(_loc19_);
               _loc7_ = "RWSUE_DATA_RECEIVED";
            }
            if(_loc17_ != -1)
            {
               _loc18_ = UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.getSongInfo(_loc17_);
               if(_loc18_ != null)
               {
                  _loc4_ = _loc18_.name;
                  _loc22_ = _loc18_.creator;
               }
               _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_loc7_,_loc17_,_loc4_,_loc22_));
            }
         }
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSUBE_BADGES"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomSessionUserBadgesEvent = null;
         var _loc3_:* = param1.type;
         if("RSUBE_BADGES" === _loc3_)
         {
            _loc2_ = param1 as RoomSessionUserBadgesEvent;
            if(_loc2_ != null && UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1 != null)
            {
               UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.refreshBadges(_loc2_.userId,_loc2_.selectedBadges);
            }
         }
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
      
      private function onFigureUpdate(param1:RoomSessionUserFigureUpdateEvent) : void
      {
         if(_container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.userId < 0)
         {
            return;
         }
         var _loc2_:IUserData = _container.roomSession.userDataManager.getUserDataByIndex(param1.userId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc5_:int = _loc2_.webID;
         var _loc3_:BitmapData = null;
         var _loc4_:* = _loc5_ == _container.sessionDataManager.userId;
         UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.updateUserData(_loc5_,param1.figure,param1.achievementScore,param1.customInfo,_loc4_,param1.badgesRank);
      }
      
      private function onPetInfo(param1:RoomSessionPetInfoUpdateEvent) : void
      {
         var _loc4_:* = false;
         var _loc6_:RoomWidgetPetInfoUpdateEvent = null;
         var _loc12_:IRoomSession = null;
         var _loc5_:IPetInfo = param1.petInfo;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc10_:IUserData = _container.roomSession.userDataManager.getPetUserData(_loc5_.petId);
         if(_loc10_ == null)
         {
            return;
         }
         var _loc2_:String = _loc10_.figure;
         var _loc8_:int = getPetType(_loc2_);
         var _loc9_:int = getPetRace(_loc2_);
         var _loc7_:String = null;
         if(_loc8_ == 16)
         {
            if(_loc5_.level >= _loc5_.adultLevel)
            {
               _loc7_ = "std";
            }
            else
            {
               _loc7_ = "grw" + _loc5_.level;
            }
         }
         var _loc3_:String = _loc2_ + (_loc7_ != null ? "/posture=" + _loc7_ : "");
         var _loc11_:BitmapData = _cachedPetImages.getValue(_loc3_) as BitmapData;
         if(_loc11_ == null)
         {
            _loc11_ = getPetImage(_loc2_,_loc7_);
            _cachedPetImages.add(_loc3_,_loc11_);
         }
         if(_container != null && _container.events != null)
         {
            _loc4_ = _loc5_.ownerId == _container.sessionDataManager.userId;
            _loc6_ = new RoomWidgetPetInfoUpdateEvent(_loc8_,_loc9_,_loc10_.name,_loc5_.petId,_loc11_,_loc4_,_loc5_.ownerId,_loc5_.ownerName,_loc10_.roomObjectId,_loc5_.breedId);
            _loc6_.level = _loc5_.level;
            _loc6_.levelMax = _loc5_.levelMax;
            _loc6_.experience = _loc5_.experience;
            _loc6_.experienceMax = _loc5_.experienceMax;
            _loc6_.energy = _loc5_.energy;
            _loc6_.energyMax = _loc5_.energyMax;
            _loc6_.nutrition = _loc5_.nutrition;
            _loc6_.nutritionMax = _loc5_.nutritionMax;
            _loc6_.petRespect = _loc5_.respect;
            _loc6_.petRespectLeft = _container.sessionDataManager.petRespectLeft;
            _loc6_.age = _loc5_.age;
            _loc6_.hasFreeSaddle = _loc5_.hasFreeSaddle;
            _loc6_.isRiding = _loc5_.isRiding;
            _loc6_.canBreed = _loc5_.canBreed;
            _loc6_.canHarvest = _loc5_.canHarvest;
            _loc6_.canRevive = _loc5_.canRevive;
            _loc6_.rarityLevel = _loc5_.rarityLevel;
            _loc6_.skillTresholds = _loc5_.skillTresholds;
            _loc6_.canRemovePet = false;
            _loc6_.accessRights = _loc5_.accessRights;
            _loc6_.maxWellBeingSeconds = _loc5_.maxWellBeingSeconds;
            _loc6_.remainingWellBeingSeconds = _loc5_.remainingWellBeingSeconds;
            _loc6_.remainingGrowingSeconds = _loc5_.remainingGrowingSeconds;
            _loc6_.hasBreedingPermission = _loc5_.hasBreedingPermission;
            _loc12_ = _container.roomSession;
            if(_loc4_)
            {
               _loc6_.canRemovePet = true;
            }
            else if(_loc12_.isRoomOwner || _container.sessionDataManager.isAnyRoomController || _loc12_.roomControllerLevel >= 1)
            {
               _loc6_.canRemovePet = true;
            }
            _container.events.dispatchEvent(_loc6_);
         }
      }
      
      private function onPetFigureUpdate(param1:RoomSessionPetFigureUpdateEvent) : void
      {
         var _loc3_:RoomWidgetPetFigureUpdateEvent = null;
         var _loc2_:String = param1.figure;
         var _loc4_:BitmapData = _cachedPetImages.getValue(_loc2_) as BitmapData;
         if(_loc4_ == null)
         {
            _loc4_ = getPetImage(_loc2_);
            _cachedPetImages.add(_loc2_,_loc4_);
         }
         if(_container != null && _container.events != null)
         {
            _loc3_ = new RoomWidgetPetFigureUpdateEvent(param1.petId,_loc4_);
            _container.events.dispatchEvent(_loc3_);
         }
      }
      
      private function onPetBreedingResult(param1:RoomSessionPetBreedingResultEvent) : void
      {
         var _loc3_:PetBreedingResultEventData = null;
         var _loc4_:PetBreedingResultEventData = null;
         var _loc2_:RoomWidgetPetBreedingResultEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc3_ = new PetBreedingResultEventData();
            _loc3_.stuffId = param1.resultData.stuffId;
            _loc3_.classId = param1.resultData.classId;
            _loc3_.productCode = param1.resultData.productCode;
            _loc3_.userId = param1.resultData.userId;
            _loc3_.userName = param1.resultData.userName;
            _loc3_.rarityLevel = param1.resultData.rarityLevel;
            _loc3_.hasMutation = param1.resultData.hasMutation;
            _loc4_ = new PetBreedingResultEventData();
            _loc4_.stuffId = param1.otherResultData.stuffId;
            _loc4_.classId = param1.otherResultData.classId;
            _loc4_.productCode = param1.otherResultData.productCode;
            _loc4_.userId = param1.otherResultData.userId;
            _loc4_.userName = param1.otherResultData.userName;
            _loc4_.rarityLevel = param1.otherResultData.rarityLevel;
            _loc4_.hasMutation = param1.otherResultData.hasMutation;
            _loc2_ = new RoomWidgetPetBreedingResultEvent(_loc3_,_loc4_);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onPetBreedingEvent(param1:RoomSessionPetBreedingEvent) : void
      {
         var _loc2_:RoomWidgetPetBreedingEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetPetBreedingEvent();
            _loc2_.state = param1.state;
            _loc2_.ownPetId = param1.ownPetId;
            _loc2_.otherPetId = param1.otherPetId;
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onConfirmPetBreedingEvent(param1:RoomSessionConfirmPetBreedingEvent) : void
      {
         var _loc4_:ConfirmPetBreedingPetData = null;
         var _loc3_:ConfirmPetBreedingPetData = null;
         var _loc6_:Array = null;
         var _loc5_:BreedingRarityCategoryData = null;
         var _loc7_:RoomWidgetConfirmPetBreedingEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc4_ = new ConfirmPetBreedingPetData();
            _loc4_.webId = param1.pet1.webId;
            _loc4_.name = param1.pet1.name;
            _loc4_.level = param1.pet1.level;
            _loc4_.figure = param1.pet1.figure;
            _loc4_.owner = param1.pet1.owner;
            _loc3_ = new ConfirmPetBreedingPetData();
            _loc3_.webId = param1.pet2.webId;
            _loc3_.name = param1.pet2.name;
            _loc3_.level = param1.pet2.level;
            _loc3_.figure = param1.pet2.figure;
            _loc3_.owner = param1.pet2.owner;
            _loc6_ = [];
            for each(var _loc2_ in param1.rarityCategories)
            {
               _loc5_ = new BreedingRarityCategoryData();
               _loc5_.chance = _loc2_.chance;
               _loc5_.breeds = _loc2_.breeds.concat();
               _loc6_.push(_loc5_);
            }
            _loc7_ = new RoomWidgetConfirmPetBreedingEvent(param1.nestId,_loc4_,_loc3_,_loc6_,param1.resultPetTypeId);
            _container.events.dispatchEvent(_loc7_);
         }
      }
      
      private function onConfirmPetBreedingResultEvent(param1:RoomSessionConfirmPetBreedingResultEvent) : void
      {
         var _loc2_:RoomWidgetConfirmPetBreedingResultEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetConfirmPetBreedingResultEvent(param1.breedingNestStuffId,param1.result);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onPetCommands(param1:RoomSessionPetCommandsUpdateEvent) : void
      {
         var _loc2_:RoomWidgetPetCommandsUpdateEvent = null;
         if(_container != null && _container.events != null)
         {
            _loc2_ = new RoomWidgetPetCommandsUpdateEvent(param1.petId,param1.allCommands,param1.enabledCommands);
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      private function onFavouriteGroupUpdated(param1:RoomSessionFavouriteGroupUpdateEvent) : void
      {
         if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1)
         {
            UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.favouriteGroupUpdated(param1.roomIndex,param1.habboGroupId,param1.status,param1.habboGroupName);
         }
      }
      
      public function update() : void
      {
      }
      
      private function getPetImage(param1:String, param2:String = null) : BitmapData
      {
         var _loc4_:BitmapData = null;
         var _loc3_:PetFigureData = new PetFigureData(param1);
         var _loc5_:uint = 0;
         var _loc6_:UnknownHabboRoom1 = _container.roomEngine.getPetImage(_loc3_.typeId,_loc3_.paletteId,_loc3_.color,new Vector3d(90),64,null,true,_loc5_,_loc3_.customParts,param2);
         if(_loc6_ != null)
         {
            _loc4_ = _loc6_.data;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new BitmapData(30,30,false,4289374890);
         }
         return _loc4_;
      }
      
      private function getPetType(param1:String) : int
      {
         return getSpaceSeparatedInteger(param1,0);
      }
      
      private function getPetRace(param1:String) : int
      {
         return getSpaceSeparatedInteger(param1,1);
      }
      
      private function getPetColor(param1:String) : int
      {
         var _loc2_:Array = param1.split(" ");
         if(_loc2_.length > 2)
         {
            return parseInt(_loc2_[2],16);
         }
         return 16777215;
      }
      
      private function getSpaceSeparatedInteger(param1:String, param2:int) : int
      {
         var _loc3_:Array = null;
         if(param1 != null)
         {
            _loc3_ = param1.split(" ");
            if(_loc3_.length > param2)
            {
               return int(_loc3_[param2]);
            }
         }
         return -1;
      }
      
      private function onNowPlayingChanged(param1:NowPlayingEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:ISongInfo = null;
         if(UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 != null)
         {
            _loc3_ = param1.id;
            _loc2_ = "";
            _loc5_ = "";
            if(_loc3_ != -1)
            {
               _loc4_ = UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.getSongInfo(_loc3_);
               if(_loc4_ != null)
               {
                  _loc2_ = _loc4_.name;
                  _loc5_ = _loc4_.creator;
               }
            }
            _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent("RWSUE_PLAYING_CHANGED",_loc3_,_loc2_,_loc5_));
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc2_:ISongInfo = null;
         if(UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1 != null)
         {
            _loc2_ = UnknownVarFromInfoStandWidgetHandler_UnknownIHabboSound1_1.getSongInfo(param1.id);
            if(_loc2_ != null && _container != null && _container.events != null)
            {
               _container.events.dispatchEvent(new RoomWidgetSongUpdateEvent("RWSUE_DATA_RECEIVED",param1.id,_loc2_.name,_loc2_.creator));
            }
         }
      }
      
      private function onRelationshipStatusEvent(param1:RelationshipStatusInfoEvent) : void
      {
         if(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1 && UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.mainWindow.visible)
         {
            UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.setRelationshipStatus(param1.userId,param1.relationshipStatusMap);
         }
      }
      
      public function get isActivityDisplayEnabled() : Boolean
      {
         return _container != null && _container.config && _container.config.getBoolean("activity.point.display.enabled");
      }
      
      public function setObjectData(param1:Map) : void
      {
         if(_container.sessionDataManager.hasSecurity(5))
         {
            _container.connection.send(new SetObjectDataMessageComposer(UnknownVarFromInfoStandWidgetHandler_InfoStandWidget_1.furniData.id,param1));
         }
      }
   }
}

