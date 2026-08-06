package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceScriptProceedComposer;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.AmbassadorAlertMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.MuteUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.AvatarExpressionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.CancelTypingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.StartTypingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.CompostPlantMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MountPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveSaddleFromPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetBreedingPermissionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetRidingPermissionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerChangeStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerGetPresetsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.PeerUsersClassificationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.RoomUsersClassificationMessageComposer;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import flash.utils.getTimer;
   
   public class RoomSession implements IRoomSession
   {
      private const CHAT_LAG_WARNING_LIMIT:int = 2500;
      
      private var UnknownVarFromRoomSession_IConnection_1:IConnection;
      
      private var _roomId:int = 0;
      
      private var _roomPassword:String = "";
      
      private var UnknownVarFromRoomSession_Boolean_1:Boolean = false;
      
      private var _roomResources:String = "";
      
      private var _openConnectionComposer:IMessageComposer = null;
      
      private var _state:String = "RSE_CREATED";
      
      private var UnknownVarFromRoomSession_UserDataManager_1:UserDataManager;
      
      private var _ownUserRoomId:int = -1;
      
      private var _isRoomOwner:Boolean = false;
      
      private var UnknownVarFromRoomSession_Int_1:int = 0;
      
      private var _playTestMode:Boolean = false;
      
      private var _tradeMode:int = 0;
      
      private var _isGuildRoom:Boolean = false;
      
      private var _isSpectatorMode:Boolean = false;
      
      private var _arePetsAllowed:Boolean = false;
      
      private var _doorMode:int;
      
      private var UnknownVarFromRoomSession_Map_1:Map = new Map();
      
      private var UnknownVarFromRoomSession_Int_2:int = 0;
      
      private var _habboTracking:IHabboTracking = null;
      
      private var _isUserDecorating:Boolean = false;
      
      private var _isGameSession:Boolean = false;
      
      private var _isNuxNotComplete:Boolean = false;
      
      private var _roomModerationSettings:RoomModerationSettings = null;
      
      public function RoomSession()
      {
         super();
         UnknownVarFromRoomSession_UserDataManager_1 = new UserDataManager();
      }
      
      public function set connection(param1:IConnection) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromRoomSession_IConnection_1 = param1;
         if(UnknownVarFromRoomSession_UserDataManager_1 != null)
         {
            UnknownVarFromRoomSession_UserDataManager_1.connection = param1;
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomSession_IConnection_1 = null;
         if(UnknownVarFromRoomSession_UserDataManager_1 != null)
         {
            UnknownVarFromRoomSession_UserDataManager_1.dispose();
            UnknownVarFromRoomSession_UserDataManager_1 = null;
         }
         if(UnknownVarFromRoomSession_Map_1 != null)
         {
            UnknownVarFromRoomSession_Map_1.dispose();
            UnknownVarFromRoomSession_Map_1 = null;
         }
         if(_openConnectionComposer)
         {
            _openConnectionComposer.dispose();
            _openConnectionComposer = null;
         }
         if(_roomModerationSettings != null)
         {
            _roomModerationSettings = null;
         }
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function set roomId(param1:int) : void
      {
         _roomId = param1;
      }
      
      public function get roomPassword() : String
      {
         return _roomPassword;
      }
      
      public function set roomPassword(param1:String) : void
      {
         _roomPassword = param1;
      }
      
      public function get roomResources() : String
      {
         return _roomResources;
      }
      
      public function set roomResources(param1:String) : void
      {
         _roomResources = param1;
      }
      
      public function get openConnectionComposer() : IMessageComposer
      {
         return _openConnectionComposer;
      }
      
      public function set openConnectionComposer(param1:IMessageComposer) : void
      {
         _openConnectionComposer = param1;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function set habboTracking(param1:IHabboTracking) : void
      {
         _habboTracking = param1;
      }
      
      public function get isGameSession() : Boolean
      {
         return _isGameSession;
      }
      
      public function set isGameSession(param1:Boolean) : void
      {
         _isGameSession = param1;
      }
      
      public function get roomModerationSettings() : RoomModerationSettings
      {
         return _roomModerationSettings;
      }
      
      public function set roomModerationSettings(param1:RoomModerationSettings) : void
      {
         _roomModerationSettings = param1;
      }
      
      public function get playTestMode() : Boolean
      {
         return _playTestMode;
      }
      
      public function set playTestMode(param1:Boolean) : void
      {
         _playTestMode = param1;
      }
      
      public function trackEventLogOncePerSession(param1:String, param2:String, param3:String) : void
      {
         _habboTracking.trackEventLogOncePerSession(param1,param2,param3);
      }
      
      public function start() : Boolean
      {
         if(_state == "RSE_CREATED" && UnknownVarFromRoomSession_IConnection_1 != null)
         {
            _state = "RSE_STARTED";
            if(!UnknownVarFromRoomSession_Boolean_1)
            {
               if(_openConnectionComposer)
               {
                  return sendPredefinedOpenConnection();
               }
               return sendOpenFlatConnectionMessage();
            }
            return true;
         }
         return false;
      }
      
      public function reset(param1:int) : void
      {
         if(param1 != _roomId)
         {
            _roomId = param1;
            _isRoomOwner = false;
            UnknownVarFromRoomSession_Int_1 = 0;
            _tradeMode = 0;
            _isSpectatorMode = false;
         }
      }
      
      private function sendOpenFlatConnectionMessage() : Boolean
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return false;
         }
         UnknownVarFromRoomSession_IConnection_1.send(new OpenFlatConnectionMessageComposer(_roomId,_roomPassword));
         return true;
      }
      
      private function sendPredefinedOpenConnection() : Boolean
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return false;
         }
         UnknownVarFromRoomSession_IConnection_1.send(_openConnectionComposer);
         _openConnectionComposer = null;
         return true;
      }
      
      public function sendChatMessage(param1:String, param2:int = 0) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         if(_isGameSession)
         {
            UnknownVarFromRoomSession_IConnection_1.send(new Game2GameChatMessageComposer(param1));
         }
         else
         {
            param1 = param1.replace(/&#[0-9]+;/g,"");
            UnknownVarFromRoomSession_IConnection_1.send(new ChatMessageComposer(param1,param2,UnknownVarFromRoomSession_Int_2));
            UnknownVarFromRoomSession_Map_1.add(UnknownVarFromRoomSession_Int_2,getTimer());
            UnknownVarFromRoomSession_Int_2++;
         }
      }
      
      public function sendChangeMottoMessage(param1:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new ChangeMottoMessageComposer(param1));
      }
      
      public function receivedChatWithTrackingId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = UnknownVarFromRoomSession_Map_1.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getTimer();
            if(_loc3_ - int(_loc2_) > 2500)
            {
               if(_habboTracking != null)
               {
                  _habboTracking.chatLagDetected(_loc3_);
               }
            }
         }
      }
      
      public function sendShoutMessage(param1:String, param2:int = 0) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromRoomSession_IConnection_1.send(new ShoutMessageComposer(param1,param2));
      }
      
      public function sendWhisperMessage(param1:String, param2:String, param3:int = 0) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromRoomSession_IConnection_1.send(new WhisperMessageComposer(param1,param2,param3));
      }
      
      public function sendChatTypingMessage(param1:Boolean) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         if(param1)
         {
            UnknownVarFromRoomSession_IConnection_1.send(new StartTypingMessageComposer());
         }
         else
         {
            UnknownVarFromRoomSession_IConnection_1.send(new CancelTypingMessageComposer());
         }
      }
      
      public function sendAvatarExpressionMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new AvatarExpressionMessageComposer(param1));
      }
      
      public function sendSignMessage(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 17)
         {
            UnknownVarFromRoomSession_IConnection_1.send(new SignMessageComposer(param1));
         }
      }
      
      public function sendDanceMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new DanceMessageComposer(param1));
      }
      
      public function sendChangePostureMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new ChangePostureMessageComposer(param1));
      }
      
      public function sendCreditFurniRedeemMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new CreditFurniRedeemMessageComposer(param1));
      }
      
      public function sendPresentOpenMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new PresentOpenMessageComposer(param1));
      }
      
      public function sendOpenPetPackageMessage(param1:int, param2:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new OpenPetPackageMessageComposer(param1,param2));
      }
      
      public function sendRoomDimmerGetPresetsMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new RoomDimmerGetPresetsMessageComposer(param1));
      }
      
      public function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int) : void
      {
         var _loc7_:String = "000000" + param3.toString(16).toUpperCase();
         var _loc8_:String = "#" + _loc7_.substr(_loc7_.length - 6);
         UnknownVarFromRoomSession_IConnection_1.send(new RoomDimmerSavePresetMessageComposer(param1,param2,_loc8_,param4,param5,param6));
      }
      
      public function sendRoomDimmerChangeStateMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new RoomDimmerChangeStateMessageComposer(param1));
      }
      
      public function sendConversionPoint(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new EventLogMessageComposer(param1,param2,param3,param4,param5));
      }
      
      public function sendPollStartMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new PollStartComposer(param1));
      }
      
      public function sendPollRejectMessage(param1:int) : void
      {
         HabboTracking.getInstance().WindowManager.LilithCustomsInstance.OnPollReject(param1);
      }
      
      public function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new PollAnswerComposer(param1,param2,param3));
      }
      
      public function sendPeerUsersClassificationMessage(param1:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new PeerUsersClassificationMessageComposer(param1));
      }
      
      public function sendRoomUsersClassificationMessage(param1:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new RoomUsersClassificationMessageComposer(param1));
      }
      
      public function sendVisitFlatMessage(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new OpenFlatConnectionMessageComposer(param1));
      }
      
      public function sendVisitUserMessage(param1:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new VisitUserMessageComposer(param1));
      }
      
      public function ambassadorAlert(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new AmbassadorAlertMessageComposer(param1));
      }
      
      public function kickUser(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new KickUserMessageComposer(param1));
      }
      
      public function banUserWithDuration(param1:int, param2:String) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new BanUserWithDurationMessageComposer(param1,param2,roomId));
      }
      
      public function muteUser(param1:int, param2:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new MuteUserMessageComposer(param1,param2,roomId));
      }
      
      public function unmuteUser(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new UnmuteUserMessageComposer(param1,roomId));
      }
      
      public function assignRights(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new AssignRightsMessageComposer(param1));
      }
      
      public function removeRights(param1:int) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         var _loc2_:RemoveRightsMessageComposer = new RemoveRightsMessageComposer(_loc3_);
         UnknownVarFromRoomSession_IConnection_1.send(_loc2_);
      }
      
      public function letUserIn(param1:String, param2:Boolean) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new LetUserInMessageComposer(param1,param2));
      }
      
      public function pickUpPet(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new RemovePetFromFlatMessageComposer(param1));
      }
      
      public function mountPet(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new MountPetMessageComposer(param1,true));
      }
      
      public function togglePetRidingPermission(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new TogglePetRidingPermissionMessageComposer(param1));
      }
      
      public function togglePetBreedingPermission(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new TogglePetBreedingPermissionMessageComposer(param1));
      }
      
      public function dismountPet(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new MountPetMessageComposer(param1,false));
      }
      
      public function removeSaddleFromPet(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new RemoveSaddleFromPetMessageComposer(param1));
      }
      
      public function harvestPet(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new HarvestPetMessageComposer(param1));
      }
      
      public function compostPlant(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new CompostPlantMessageComposer(param1));
      }
      
      public function requestPetCommands(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new GetPetCommandsMessageComposer(param1));
      }
      
      public function useProductForPet(param1:int, param2:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new CustomizePetWithFurniComposer(param1,param2));
      }
      
      public function plantSeed(param1:int) : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new UseFurnitureMessageComposer(param1));
      }
      
      public function sendScriptProceed() : void
      {
         UnknownVarFromRoomSession_IConnection_1.send(new NewUserExperienceScriptProceedComposer());
      }
      
      public function quit() : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 != null)
         {
            UnknownVarFromRoomSession_IConnection_1.send(new QuitMessageComposer());
         }
      }
      
      public function changeQueue(param1:int) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromRoomSession_IConnection_1.send(new ChangeQueueMessageComposer(param1));
      }
      
      public function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String) : void
      {
         if(UnknownVarFromRoomSession_IConnection_1 == null)
         {
            return;
         }
         var _loc4_:SetClothingChangeDataMessageComposer = new SetClothingChangeDataMessageComposer(param1,param2,param3);
         UnknownVarFromRoomSession_IConnection_1.send(_loc4_);
         _loc4_.dispose();
         _loc4_ = null;
      }
      
      public function get userDataManager() : IUserDataManager
      {
         return UnknownVarFromRoomSession_UserDataManager_1 as IUserDataManager;
      }
      
      public function get ownUserRoomId() : int
      {
         return _ownUserRoomId;
      }
      
      public function set ownUserRoomId(param1:int) : void
      {
         _ownUserRoomId = param1;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         _isRoomOwner = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return this._isRoomOwner || this.roomControllerLevel >= 3;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 5)
         {
            UnknownVarFromRoomSession_Int_1 = param1;
         }
         else
         {
            Logger.log("Invalid roomControllerLevel " + param1 + ", setting to ROOM_CONTROL_LEVEL_NONE instead");
            UnknownVarFromRoomSession_Int_1 = 0;
         }
      }
      
      public function get roomControllerLevel() : int
      {
         if(_playTestMode)
         {
            return 0;
         }
         return UnknownVarFromRoomSession_Int_1;
      }
      
      public function get tradeMode() : int
      {
         return _tradeMode;
      }
      
      public function get isPrivateRoom() : Boolean
      {
         return true;
      }
      
      public function set tradeMode(param1:int) : void
      {
         _tradeMode = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isNoobRoom() : Boolean
      {
         return _doorMode == 4;
      }
      
      public function set doorMode(param1:int) : void
      {
         _doorMode = param1;
      }
      
      public function get doorMode() : int
      {
         return _doorMode;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return _isSpectatorMode;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         _isSpectatorMode = param1;
      }
      
      public function get arePetsAllowed() : Boolean
      {
         return _arePetsAllowed;
      }
      
      public function set arePetsAllowed(param1:Boolean) : void
      {
         _arePetsAllowed = param1;
      }
      
      public function get areBotsAllowed() : Boolean
      {
         return _isRoomOwner;
      }
      
      public function get isUserDecorating() : Boolean
      {
         return _isUserDecorating;
      }
      
      public function set isUserDecorating(param1:Boolean) : void
      {
         _isUserDecorating = param1;
      }
      
      public function get isNuxNotComplete() : Boolean
      {
         return _isNuxNotComplete;
      }
      
      public function set isNuxNotComplete(param1:Boolean) : void
      {
         _isNuxNotComplete = param1;
      }
      
      public function set skipOpc(param1:Boolean) : void
      {
         UnknownVarFromRoomSession_Boolean_1 = param1;
      }
   }
}

