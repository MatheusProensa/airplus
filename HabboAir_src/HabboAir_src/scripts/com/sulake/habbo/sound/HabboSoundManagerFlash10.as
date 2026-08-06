package com.sulake.habbo.sound
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesParser;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectPlaySoundEvent;
   import com.sulake.habbo.sound.events.TraxSongLoadEvent;
   import com.sulake.habbo.sound.furni.FurniSamplePlaybackManager;
   import com.sulake.habbo.sound.music.HabboMusicController;
   import com.sulake.habbo.sound.music.TraxSampleManager;
   import com.sulake.habbo.sound.trax.TraxData;
   import com.sulake.habbo.sound.trax.TraxSequencer;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.utils.getTimer;
   
   public class HabboSoundManagerFlash10 extends Component implements IHabboSoundManagerFlash10, IProfiler_1
   {
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromHabboSoundManagerFlash10_IConnection_1:IConnection;
      
      private var _roomEngine:IRoomEngine;
      
      private var _notifications:IHabboNotifications;
      
      private var _genericVolume:Number = 0;
      
      private var _traxVolume:Number = 1;
      
      private var _furniVolume:Number = 1;
      
      private var _genericSamples:Map = new Map();
      
      private var _loadingSongId:int = -1;
      
      private var UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1:TraxSequencer;
      
      private var _musicController:UnknownIHabboSound1;
      
      private var UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1:TraxSampleManager;
      
      private var UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1:FurniSamplePlaybackManager;
      
      private var UnknownVarFromHabboSoundManagerFlash10_Map_1:Map = new Map();
      
      private var UnknownVarFromHabboSoundManagerFlash10_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboSoundManagerFlash10_Map_2:Map = new Map();
      
      public function HabboSoundManagerFlash10(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null, param4:Boolean = true)
      {
         super(param1,param2,param3);
         if(param4)
         {
            queueInterface(new IIDHabboCommunicationManager(),onCommunicationManagerReady);
            queueInterface(new IIDRoomEngine(),onRoomEngineReady);
            queueInterface(new IIDHabboNotifications(),onNotificationsReady);
         }
         events.addEventListener("TSLE_TRAX_LOAD_COMPLETE",onTraxLoadComplete);
         registerUpdateReceiver(this,1);
         Logger.log("Sound manager 10 init");
      }
      
      public function get musicController() : UnknownIHabboSound1
      {
         return _musicController;
      }
      
      public function get genericVolume() : Number
      {
         return _genericVolume;
      }
      
      public function set genericVolume(param1:Number) : void
      {
         updateVolumeSetting(param1,_furniVolume,_traxVolume);
         storeVolumeSetting();
      }
      
      public function get traxVolume() : Number
      {
         return _traxVolume;
      }
      
      public function set traxVolume(param1:Number) : void
      {
         updateVolumeSetting(_genericVolume,_furniVolume,param1);
         storeVolumeSetting();
      }
      
      public function get furniVolume() : Number
      {
         return _furniVolume;
      }
      
      public function set furniVolume(param1:Number) : void
      {
         updateVolumeSetting(_genericVolume,param1,_traxVolume);
         storeVolumeSetting();
      }
      
      public function previewVolume(param1:Number, param2:Number, param3:Number) : void
      {
         updateVolumeSetting(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         UnknownVarFromHabboSoundManagerFlash10_IConnection_1 = null;
         if(_musicController)
         {
            _musicController.dispose();
            _musicController = null;
         }
         if(UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1)
         {
            UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1.dispose();
            UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1 = null;
         }
         if(_genericSamples)
         {
            _genericSamples.dispose();
            _genericSamples = null;
         }
         if(UnknownVarFromHabboSoundManagerFlash10_Map_2)
         {
            UnknownVarFromHabboSoundManagerFlash10_Map_2.dispose();
            UnknownVarFromHabboSoundManagerFlash10_Map_2 = null;
         }
         if(UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1)
         {
            UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1.dispose();
            UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1 = null;
         }
         if(_communication)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_roomEngine)
         {
            _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND",onRoomEngineObjectPlaySound);
            _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND_AT_PITCH",onRoomEngineObjectPlaySound);
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_notifications)
         {
            _notifications.release(new IIDHabboNotifications());
            _notifications = null;
         }
         super.dispose();
      }
      
      public function playSound(param1:String, param2:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc7_:Sound = null;
         var _loc6_:int = getTimer();
         var _loc3_:Object = UnknownVarFromHabboSoundManagerFlash10_Map_2.getValue(param1);
         if(_loc3_ !== null)
         {
            _loc5_ = int(_loc3_);
            if(_loc6_ - _loc5_ <= 200)
            {
               return;
            }
         }
         var _loc4_:IHabboSoundBase_1 = _genericSamples.getValue(param1);
         if(_loc4_ == null)
         {
            _loc7_ = getSoundBySoundId(param1);
            if(_loc7_ != null)
            {
               _loc4_ = new HabboSoundBase(_loc7_,param2);
               _genericSamples.add(param1,IHabboSoundBase_1(_loc4_));
            }
         }
         _loc4_.volume = _genericVolume;
         UnknownVarFromHabboSoundManagerFlash10_Map_2.remove(param1);
         UnknownVarFromHabboSoundManagerFlash10_Map_2.add(param1,_loc6_);
         _loc4_.play();
      }
      
      public function playSoundAtPitch(param1:String, param2:Number) : IHabboSoundBase_1
      {
         var _loc4_:Sound = getSoundBySoundId(param1);
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:HabboSoundWithPitch = new HabboSoundWithPitch(_loc4_,param2);
         _loc3_.volume = _genericVolume;
         _loc3_.play();
         return _loc3_;
      }
      
      public function stopSound(param1:String) : void
      {
         var _loc2_:IHabboSoundBase_1 = _genericSamples.getValue(param1);
         if(_loc2_ != null)
         {
            _loc2_.stop();
         }
      }
      
      public function get loadingSongId() : int
      {
         return _loadingSongId;
      }
      
      private function onSampleLoadError() : void
      {
         _loadingSongId = -1;
         UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 = null;
      }
      
      private function getSoundBySoundId(param1:String) : Sound
      {
         var _loc2_:* = "";
         switch(param1)
         {
            case "HBST_call_for_help":
               _loc2_ = "sound_call_for_help";
               break;
            case "HBST_guide_invitation":
               _loc2_ = "sound_guide_received_invitation";
               break;
            case "HBST_guide_request":
               _loc2_ = "sound_guide_help_requested";
               break;
            case "HBST_message_received":
               _loc2_ = "sound_console_new_message";
               break;
            case "HBST_message_sent":
               _loc2_ = "sound_console_message_sent";
               break;
            case "HBST_pixels":
               _loc2_ = "sound_catalogue_duckets";
               break;
            case "HBST_purchase":
               _loc2_ = "sound_catalogue_cash";
               break;
            case "HBST_respect":
               _loc2_ = "sound_respect_received";
               break;
            case "CAMERA_shutter":
               _loc2_ = "sound_camera_shutter";
               break;
            case "HBSTG_snowwar_get_snowball":
            case "HBSTG_snowwar_hit1":
            case "HBSTG_snowwar_hit2":
            case "HBSTG_snowwar_hit3":
            case "HBSTG_snowwar_make_snowball":
            case "HBSTG_snowwar_miss":
            case "HBSTG_snowwar_throw":
            case "HBSTG_snowwar_walk":
            case "HBSTG_ig_countdown":
            case "HBSTG_ig_winning":
            case "HBSTG_ig_losing":
               _loc2_ = param1;
               break;
            case "FURNITURE_cuckoo_clock":
               _loc2_ = param1;
               break;
            default:
               Logger.log("HabboSoundManagerFlash10: Unknown sound request: " + param1);
               return null;
         }
         return getSoundByAssetName(_loc2_);
      }
      
      private function getSoundByAssetName(param1:String) : Sound
      {
         var _loc2_:ISoundAsset = assets.getAssetByName(param1);
         return _loc2_.content as Sound;
      }
      
      public function loadTraxSong(param1:int, param2:String) : IHabboSoundBase_1
      {
         if(UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 != null)
         {
            return addTraxSongForDownload(param1,param2);
         }
         var _loc3_:TraxSequencer = createTraxInstance(param1,param2);
         if(!_loc3_.ready)
         {
            UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 = _loc3_;
            _loadingSongId = param1;
         }
         return _loc3_ as IHabboSoundBase_1;
      }
      
      private function addTraxSongForDownload(param1:int, param2:String) : IHabboSoundBase_1
      {
         var _loc3_:TraxSequencer = createTraxInstance(param1,param2,false);
         if(!_loc3_.ready)
         {
            UnknownVarFromHabboSoundManagerFlash10_Map_1.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      private function createTraxInstance(param1:int, param2:String, param3:Boolean = true) : TraxSequencer
      {
         var _loc5_:TraxData = new TraxData(param2);
         var _loc4_:TraxSequencer = new TraxSequencer(param1,_loc5_,UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1.traxSamples,events);
         _loc4_.volume = _genericVolume;
         validateSampleAvailability(_loc4_,param3);
         return _loc4_;
      }
      
      private function validateSampleAvailability(param1:TraxSequencer, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc6_:TraxData = param1.traxData;
         var _loc5_:Array = _loc6_.getSampleIds();
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1.traxSamples.getValue(int(_loc5_[_loc4_])) == null)
            {
               if(param2)
               {
                  UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1.loadSample(int(_loc5_[_loc4_]));
               }
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            param1.ready = false;
         }
         else
         {
            param1.ready = true;
         }
      }
      
      public function notifyPlayedSong(param1:String, param2:String) : void
      {
         if(_notifications == null)
         {
            return;
         }
         _notifications.addSongPlayingNotification(param1,param2);
      }
      
      private function onCommunicationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:IConnection = null;
         if(param2 != null)
         {
            _communication = IHabboCommunicationManager(param2);
            _loc3_ = _communication.connection;
            if(_loc3_ != null)
            {
               onConnectionReady(_loc3_);
               init();
            }
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _roomEngine = IRoomEngine(param2);
         init();
      }
      
      private function onNotificationsReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _notifications = IHabboNotifications(param2);
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            UnknownVarFromHabboSoundManagerFlash10_IConnection_1 = param1;
         }
         init();
      }
      
      private function init() : void
      {
         if(UnknownVarFromHabboSoundManagerFlash10_IConnection_1 == null || _roomEngine == null || _musicController != null)
         {
            return;
         }
         _musicController = new HabboMusicController(this,events,_roomEngine.events,UnknownVarFromHabboSoundManagerFlash10_IConnection_1);
         UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1 = new TraxSampleManager(this,onSampleLoadError);
         UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1 = new FurniSamplePlaybackManager(this,_roomEngine.events);
         _roomEngine.events.addEventListener("REPSE_PLAY_SOUND",onRoomEngineObjectPlaySound);
         _roomEngine.events.addEventListener("REPSE_PLAY_SOUND_AT_PITCH",onRoomEngineObjectPlaySound);
         UnknownVarFromHabboSoundManagerFlash10_IConnection_1.addMessageEvent(new AccountPreferencesEvent(onSoundSettingsEvent));
         UnknownVarFromHabboSoundManagerFlash10_IConnection_1.send(new GetSoundSettingsComposer());
      }
      
      protected function setMusicController(param1:UnknownIHabboSound1) : void
      {
         _musicController = param1;
      }
      
      private function onTraxLoadComplete(param1:Event) : void
      {
         var _loc2_:TraxSongLoadEvent = param1 as TraxSongLoadEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 == null)
         {
            return;
         }
         UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1.ready = true;
         if(_musicController == null)
         {
            return;
         }
         _musicController.onSongLoaded(_loc2_.id);
         UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 = null;
         _loadingSongId = -1;
      }
      
      private function storeVolumeSetting() : void
      {
         if(UnknownVarFromHabboSoundManagerFlash10_IConnection_1 != null)
         {
            UnknownVarFromHabboSoundManagerFlash10_IConnection_1.send(new SetSoundSettingsComposer(int(_traxVolume * 100),int(_furniVolume * 100),int(_genericVolume * 100)));
         }
      }
      
      private function updateVolumeSetting(param1:Number, param2:Number, param3:Number) : void
      {
         if(UnknownVarFromHabboSoundManagerFlash10_Boolean_1)
         {
            _genericVolume = 0;
            _furniVolume = 0;
            _traxVolume = 0;
            _musicController.updateVolume(0);
            UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1.updateVolume(0);
         }
         else
         {
            _genericVolume = param1;
            _furniVolume = param2;
            _traxVolume = param3;
            _musicController.updateVolume(param3);
            UnknownVarFromHabboSoundManagerFlash10_FurniSamplePlaybackManager_1.updateVolume(param2);
         }
      }
      
      private function onSoundSettingsEvent(param1:IMessageEvent) : void
      {
         var _loc3_:AccountPreferencesEvent = param1 as AccountPreferencesEvent;
         var _loc2_:AccountPreferencesParser = _loc3_.getParser() as AccountPreferencesParser;
         var _loc4_:Number = _loc2_.uiVolume;
         if(_loc4_ == 1)
         {
            _loc4_ = 100;
         }
         updateVolumeSetting(_loc4_ / 100,_loc2_.furniVolume / 100,_loc2_.traxVolume / 100);
      }
      
      private function loadNextSong() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TraxSequencer = null;
         if(UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 == null && UnknownVarFromHabboSoundManagerFlash10_Map_1.length > 0)
         {
            _loc2_ = UnknownVarFromHabboSoundManagerFlash10_Map_1.getKey(0);
            _loc1_ = UnknownVarFromHabboSoundManagerFlash10_Map_1.remove(_loc2_);
            if(_loc1_ != null && !_loc1_.disposed)
            {
               validateSampleAvailability(_loc1_,true);
               if(_loc1_.ready)
               {
                  events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_COMPLETE",_loc2_));
               }
               else
               {
                  UnknownVarFromHabboSoundManagerFlash10_TraxSequencer_1 = _loc1_;
                  _loadingSongId = _loc2_;
               }
            }
         }
      }
      
      private function onRoomEngineObjectPlaySound(param1:Event) : void
      {
         var _loc2_:RoomEngineObjectPlaySoundEvent = RoomEngineObjectPlaySoundEvent(param1);
         if(param1.type == "REPSE_PLAY_SOUND")
         {
            playSound(_loc2_.soundId);
         }
         if(param1.type == "REPSE_PLAY_SOUND_AT_PITCH")
         {
            playSoundAtPitch(_loc2_.soundId,_loc2_.pitch);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1 != null)
         {
            UnknownVarFromHabboSoundManagerFlash10_TraxSampleManager_1.update(param1);
         }
         loadNextSong();
      }
      
      public function mute(param1:Boolean) : void
      {
         UnknownVarFromHabboSoundManagerFlash10_Boolean_1 = param1;
         updateVolumeSetting(_genericVolume,_furniVolume,_traxVolume);
      }
   }
}

