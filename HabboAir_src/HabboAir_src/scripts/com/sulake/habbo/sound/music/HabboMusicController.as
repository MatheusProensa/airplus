package com.sulake.habbo.sound.music
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
   import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
   import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;
   import com.sulake.habbo.sound.*;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import com.sulake.habbo.sound.trax.TraxSequencer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class HabboMusicController implements UnknownIHabboSound1, IComponentInterfaceQueue
   {
      public static const SKIP_POSITION_SET:int = -1;
      
      private static const MAXIMUM_NOTIFY_PRIORITY:int = 0;
      
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var UnknownVarFromHabboMusicController_IConnection_1:IConnection;
      
      private var _events:IEventDispatcher;
      
      private var _roomEvents:IEventDispatcher;
      
      private var UnknownVarFromHabboMusicController_Map_1:Map;
      
      private var UnknownVarFromHabboMusicController_Map_2:Map;
      
      private var UnknownVarFromHabboMusicController_Array_1:Array;
      
      private var _roomItemPlaylist:IHabboSoundBase_2 = null;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromHabboMusicController_Array_2:Array;
      
      private var UnknownVarFromHabboMusicController_Array_3:Array;
      
      private var UnknownVarFromHabboMusicController_Int_1:int = -1;
      
      private var UnknownVarFromHabboMusicController_Int_2:int = -1;
      
      private var UnknownVarFromHabboMusicController_Int_3:int = -1;
      
      private var UnknownVarFromHabboMusicController_Timer_1:Timer;
      
      private var UnknownVarFromHabboMusicController_Map_3:Map;
      
      private var UnknownVarFromHabboMusicController_Array_4:Array;
      
      private var _messageEvents:Array;
      
      private var UnknownVarFromHabboMusicController_Int_4:int = -1;
      
      private var _previousNotificationTime:int = -1;
      
      public function HabboMusicController(param1:HabboSoundManagerFlash10, param2:IEventDispatcher, param3:IEventDispatcher, param4:IConnection)
      {
         var _loc5_:int = 0;
         UnknownVarFromHabboMusicController_Map_1 = new Map();
         UnknownVarFromHabboMusicController_Map_2 = new Map();
         UnknownVarFromHabboMusicController_Array_1 = [];
         UnknownVarFromHabboMusicController_Array_2 = [];
         UnknownVarFromHabboMusicController_Array_3 = [];
         UnknownVarFromHabboMusicController_Map_3 = new Map();
         UnknownVarFromHabboMusicController_Array_4 = [];
         _messageEvents = [];
         super();
         _soundManager = param1;
         _events = param2;
         _roomEvents = param3;
         UnknownVarFromHabboMusicController_IConnection_1 = param4;
         _messageEvents.push(new TraxSongInfoMessageEvent(onSongInfoMessage));
         _messageEvents.push(new UserSongDisksInventoryMessageEvent(onSongDiskInventoryMessage));
         for each(var _loc6_ in _messageEvents)
         {
            UnknownVarFromHabboMusicController_IConnection_1.addMessageEvent(_loc6_);
         }
         _roomEvents.addEventListener("ROSM_JUKEBOX_INIT",onJukeboxInit);
         _roomEvents.addEventListener("ROSM_JUKEBOX_DISPOSE",onJukeboxDispose);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_INIT",onSoundMachineInit);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_DISPOSE",onSoundMachineDispose);
         UnknownVarFromHabboMusicController_Timer_1 = new Timer(1000);
         UnknownVarFromHabboMusicController_Timer_1.start();
         UnknownVarFromHabboMusicController_Timer_1.addEventListener("timer",sendNextSongRequestMessage);
         _events.addEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            UnknownVarFromHabboMusicController_Array_2[_loc5_] = null;
            UnknownVarFromHabboMusicController_Array_3[_loc5_] = 0;
            _loc5_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get events() : IEventDispatcher
      {
         return _events;
      }
      
      protected function onSongFinishedPlayingEvent(param1:SoundCompleteEvent) : void
      {
         var _loc2_:int = 0;
         Logger.log("Song " + param1.id + " finished playing");
         if(getSongIdPlayingAtPriority(UnknownVarFromHabboMusicController_Int_1) == param1.id)
         {
            if(getTopRequestPriority() == UnknownVarFromHabboMusicController_Int_1 && getSongRequestCountAtPriority(UnknownVarFromHabboMusicController_Int_1) == UnknownVarFromHabboMusicController_Int_3)
            {
               resetSongStartRequest(UnknownVarFromHabboMusicController_Int_1);
            }
            _loc2_ = UnknownVarFromHabboMusicController_Int_1;
            playSongWithHighestPriority();
            if(_loc2_ >= 2)
            {
               _events.dispatchEvent(new NowPlayingEvent("NPW_USER_STOP_SONG",_loc2_,param1.id,-1));
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SongDataEntry = null;
         var _loc2_:IHabboSoundBase_1 = null;
         if(!_disposed)
         {
            _soundManager = null;
            UnknownVarFromHabboMusicController_Array_1 = null;
            if(UnknownVarFromHabboMusicController_IConnection_1)
            {
               for each(var _loc4_ in _messageEvents)
               {
                  UnknownVarFromHabboMusicController_IConnection_1.removeMessageEvent(_loc4_);
                  _loc4_.dispose();
               }
               _messageEvents = null;
               UnknownVarFromHabboMusicController_IConnection_1 = null;
            }
            if(_roomItemPlaylist)
            {
               _roomItemPlaylist.dispose();
               _roomItemPlaylist = null;
            }
            if(UnknownVarFromHabboMusicController_Map_1)
            {
               _loc3_ = 0;
               while(_loc3_ < UnknownVarFromHabboMusicController_Map_1.length)
               {
                  _loc1_ = UnknownVarFromHabboMusicController_Map_1.getWithIndex(_loc3_) as SongDataEntry;
                  _loc2_ = _loc1_.soundObject as IHabboSoundBase_1;
                  if(_loc2_ != null)
                  {
                     _loc2_.stop();
                  }
                  _loc1_.soundObject = null;
                  _loc3_++;
               }
               UnknownVarFromHabboMusicController_Map_1.dispose();
               UnknownVarFromHabboMusicController_Map_1 = null;
            }
            if(UnknownVarFromHabboMusicController_Map_2 != null)
            {
               UnknownVarFromHabboMusicController_Map_2.dispose();
               UnknownVarFromHabboMusicController_Map_2 = null;
            }
            UnknownVarFromHabboMusicController_Timer_1.stop();
            UnknownVarFromHabboMusicController_Timer_1 = null;
            if(_roomEvents)
            {
               _roomEvents.removeEventListener("ROSM_JUKEBOX_INIT",onJukeboxInit);
               _roomEvents.removeEventListener("ROSM_JUKEBOX_DISPOSE",onJukeboxDispose);
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_INIT",onSoundMachineInit);
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_DISPOSE",onSoundMachineDispose);
            }
            if(UnknownVarFromHabboMusicController_Map_3 != null)
            {
               UnknownVarFromHabboMusicController_Map_3.dispose();
               UnknownVarFromHabboMusicController_Map_3 = null;
            }
            _disposed = true;
         }
      }
      
      public function getRoomItemPlaylist(param1:int = -1) : IHabboSoundBase_2
      {
         return _roomItemPlaylist;
      }
      
      private function addSongStartRequest(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean
      {
         if(param1 < 0 || param1 >= 4)
         {
            return false;
         }
         var _loc7_:SongStartRequestData = new SongStartRequestData(param2,param3,param4,param5,param6);
         UnknownVarFromHabboMusicController_Array_2[param1] = _loc7_;
         UnknownVarFromHabboMusicController_Array_3[param1] += 1;
         return true;
      }
      
      private function getSongStartRequest(param1:int) : SongStartRequestData
      {
         return UnknownVarFromHabboMusicController_Array_2[param1];
      }
      
      private function getSongIdRequestedAtPriority(param1:int) : int
      {
         if(param1 < 0 || param1 >= 4)
         {
            return -1;
         }
         if(UnknownVarFromHabboMusicController_Array_2[param1] == null)
         {
            return -1;
         }
         var _loc2_:SongStartRequestData = UnknownVarFromHabboMusicController_Array_2[param1];
         return _loc2_.songId;
      }
      
      private function getSongRequestCountAtPriority(param1:int) : int
      {
         if(param1 < 0 || param1 >= 4)
         {
            return -1;
         }
         return UnknownVarFromHabboMusicController_Array_3[param1];
      }
      
      private function getTopRequestPriority() : int
      {
         var _loc1_:int = 0;
         _loc1_ = UnknownVarFromHabboMusicController_Array_2.length - 1;
         while(_loc1_ >= 0)
         {
            if(UnknownVarFromHabboMusicController_Array_2[_loc1_] != null)
            {
               return _loc1_;
            }
            _loc1_--;
         }
         return -1;
      }
      
      private function resetSongStartRequest(param1:int) : void
      {
         if(param1 >= 0 && param1 < 4)
         {
            UnknownVarFromHabboMusicController_Array_2[param1] = null;
         }
      }
      
      private function reRequestSongAtPriority(param1:int) : void
      {
         var _loc2_:* = param1;
         var _loc3_:* = UnknownVarFromHabboMusicController_Array_3[_loc2_] + 1;
         UnknownVarFromHabboMusicController_Array_3[_loc2_] = _loc3_;
      }
      
      private function processSongEntryForPlaying(param1:int, param2:Boolean = true) : Boolean
      {
         var _loc4_:SongDataEntry = getSongDataEntry(param1);
         if(_loc4_ == null)
         {
            addSongInfoRequest(param1);
            return false;
         }
         if(_loc4_.soundObject == null)
         {
            _loc4_.soundObject = _soundManager.loadTraxSong(_loc4_.id,_loc4_.songData);
         }
         var _loc3_:IHabboSoundBase_1 = _loc4_.soundObject;
         if(!_loc3_.ready)
         {
            return false;
         }
         return true;
      }
      
      public function playSong(param1:int, param2:int, param3:Number = 0, param4:Number = 0, param5:Number = 0.5, param6:Number = 0.5) : Boolean
      {
         Logger.log("Requesting " + param1 + " for playing");
         if(!addSongStartRequest(param2,param1,param3,param4,param5,param6))
         {
            return false;
         }
         if(!processSongEntryForPlaying(param1))
         {
            return false;
         }
         if(param2 >= UnknownVarFromHabboMusicController_Int_1)
         {
            playSongObject(param2,param1);
         }
         else
         {
            Logger.log("Higher priority song blocked playing. Stored song " + param1 + " for priority " + param2);
         }
         return true;
      }
      
      private function playSongWithHighestPriority() : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         UnknownVarFromHabboMusicController_Int_1 = -1;
         UnknownVarFromHabboMusicController_Int_2 = -1;
         UnknownVarFromHabboMusicController_Int_3 = -1;
         var _loc1_:int = getTopRequestPriority();
         _loc2_ = _loc1_;
         while(_loc2_ >= 0)
         {
            _loc3_ = getSongIdRequestedAtPriority(_loc2_);
            if(_loc3_ >= 0 && playSongObject(_loc2_,_loc3_))
            {
               return;
            }
            _loc2_--;
         }
      }
      
      public function stop(param1:int) : void
      {
         var _loc2_:* = param1 == UnknownVarFromHabboMusicController_Int_1;
         var _loc3_:* = getTopRequestPriority() == param1;
         if(_loc2_)
         {
            resetSongStartRequest(param1);
            stopSongAtPriority(param1);
         }
         else
         {
            resetSongStartRequest(param1);
            if(_loc3_)
            {
               reRequestSongAtPriority(UnknownVarFromHabboMusicController_Int_1);
            }
         }
      }
      
      private function stopSongAtPriority(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:SongDataEntry = null;
         if(param1 == UnknownVarFromHabboMusicController_Int_1 && UnknownVarFromHabboMusicController_Int_1 >= 0)
         {
            _loc3_ = getSongIdPlayingAtPriority(param1);
            if(_loc3_ >= 0)
            {
               _loc2_ = getSongDataEntry(_loc3_);
               stopSongDataEntry(_loc2_);
               return true;
            }
         }
         return false;
      }
      
      private function stopSongDataEntry(param1:SongDataEntry) : void
      {
         var _loc2_:IHabboSoundBase_1 = null;
         if(param1 != null)
         {
            Logger.log("Stopping current song " + param1.id);
            _loc2_ = param1.soundObject;
            if(_loc2_ != null)
            {
               _loc2_.stop();
            }
         }
      }
      
      private function getSongDataEntry(param1:int) : SongDataEntry
      {
         var _loc2_:SongDataEntry = null;
         if(UnknownVarFromHabboMusicController_Map_1 != null)
         {
            _loc2_ = UnknownVarFromHabboMusicController_Map_1.getValue(param1) as SongDataEntry;
         }
         return _loc2_;
      }
      
      public function updateVolume(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:SongDataEntry = null;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = getSongIdPlayingAtPriority(_loc3_);
            if(_loc4_ >= 0)
            {
               _loc2_ = getSongDataEntry(_loc4_) as SongDataEntry;
               if(_loc2_ != null && _loc2_.soundObject != null)
               {
                  _loc2_.soundObject.volume = param1;
               }
            }
            _loc3_++;
         }
      }
      
      public function onSongLoaded(param1:int) : void
      {
         var _loc3_:int = 0;
         Logger.log("Song loaded : " + param1);
         var _loc2_:int = getTopRequestPriority();
         if(_loc2_ >= 0)
         {
            _loc3_ = getSongIdRequestedAtPriority(_loc2_);
            if(param1 == _loc3_)
            {
               playSongObject(_loc2_,param1);
            }
         }
      }
      
      public function addSongInfoRequest(param1:int) : void
      {
         requestSong(param1,true);
      }
      
      public function requestSongInfoWithoutSamples(param1:int) : void
      {
         requestSong(param1,false);
      }
      
      private function requestSong(param1:int, param2:Boolean) : void
      {
         if(UnknownVarFromHabboMusicController_Map_2.getValue(param1) == null)
         {
            UnknownVarFromHabboMusicController_Map_2.add(param1,param2);
            UnknownVarFromHabboMusicController_Array_1.push(param1);
         }
      }
      
      public function getSongInfo(param1:int) : ISongInfo
      {
         var _loc2_:SongDataEntry = getSongDataEntry(param1);
         if(_loc2_ == null)
         {
            requestSongInfoWithoutSamples(param1);
         }
         return _loc2_;
      }
      
      public function requestUserSongDisks() : void
      {
         if(UnknownVarFromHabboMusicController_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromHabboMusicController_IConnection_1.send(new GetUserSongDisksMessageComposer());
      }
      
      public function getSongDiskInventorySize() : int
      {
         return UnknownVarFromHabboMusicController_Map_3.length;
      }
      
      public function getSongDiskInventoryDiskId(param1:int) : int
      {
         if(param1 >= 0 && param1 < UnknownVarFromHabboMusicController_Map_3.length)
         {
            return UnknownVarFromHabboMusicController_Map_3.getKey(param1);
         }
         return -1;
      }
      
      public function getSongDiskInventorySongId(param1:int) : int
      {
         if(param1 >= 0 && param1 < UnknownVarFromHabboMusicController_Map_3.length)
         {
            return UnknownVarFromHabboMusicController_Map_3.getWithIndex(param1);
         }
         return -1;
      }
      
      public function getSongIdPlayingAtPriority(param1:int) : int
      {
         if(param1 != UnknownVarFromHabboMusicController_Int_1)
         {
            return -1;
         }
         return UnknownVarFromHabboMusicController_Int_2;
      }
      
      public function samplesUnloaded(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:SongDataEntry = null;
         var _loc4_:TraxSequencer = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromHabboMusicController_Map_1.length)
         {
            _loc3_ = UnknownVarFromHabboMusicController_Map_1.getWithIndex(_loc5_) as SongDataEntry;
            _loc4_ = _loc3_.soundObject as TraxSequencer;
            if(_loc3_.id != UnknownVarFromHabboMusicController_Int_2 && _loc4_ != null && _loc4_.ready)
            {
               _loc2_ = _loc4_.traxData.getSampleIds();
               _loc6_ = 0;
               while(_loc6_ < param1.length)
               {
                  if(_loc2_.indexOf(param1[_loc6_]) != -1)
                  {
                     _loc3_.soundObject = null;
                     _loc4_.dispose();
                     Logger.log("Unloaded " + _loc3_.name + " by " + _loc3_.creator);
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
      }
      
      public function get samplesIdsInUse() : Array
      {
         var _loc5_:int = 0;
         var _loc3_:SongStartRequestData = null;
         var _loc2_:SongDataEntry = null;
         var _loc1_:TraxSequencer = null;
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromHabboMusicController_Array_2.length)
         {
            if(UnknownVarFromHabboMusicController_Array_2[_loc5_] != null)
            {
               _loc3_ = UnknownVarFromHabboMusicController_Array_2[_loc5_];
               _loc2_ = UnknownVarFromHabboMusicController_Map_1.getValue(_loc3_.songId);
               if(_loc2_ != null)
               {
                  _loc1_ = _loc2_.soundObject as TraxSequencer;
                  if(_loc1_ != null)
                  {
                     _loc4_ = _loc4_.concat(_loc1_.traxData.getSampleIds());
                  }
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function sendNextSongRequestMessage(param1:TimerEvent) : void
      {
         if(UnknownVarFromHabboMusicController_Array_1.length < 1)
         {
            return;
         }
         if(UnknownVarFromHabboMusicController_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromHabboMusicController_IConnection_1.send(new GetSongInfoMessageComposer(UnknownVarFromHabboMusicController_Array_1));
         Logger.log("Requested song info\'s : " + UnknownVarFromHabboMusicController_Array_1);
         UnknownVarFromHabboMusicController_Array_1 = [];
      }
      
      private function onSongInfoMessage(param1:IMessageEvent) : void
      {
         var _loc8_:int = 0;
         var _loc9_:SongInfoEntry = null;
         var _loc10_:* = false;
         var _loc4_:Boolean = false;
         var _loc11_:IHabboSoundBase_1 = null;
         var _loc12_:SongDataEntry = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:TraxSongInfoMessageEvent = param1 as TraxSongInfoMessageEvent;
         var _loc2_:TraxSongInfoMessageParser = _loc3_.getParser() as TraxSongInfoMessageParser;
         var _loc7_:Array = _loc2_.songs;
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            _loc10_ = getSongDataEntry(_loc9_.id) == null;
            _loc4_ = areSamplesRequested(_loc9_.id);
            if(_loc10_)
            {
               _loc11_ = null;
               if(_loc4_)
               {
                  _loc11_ = _soundManager.loadTraxSong(_loc9_.id,_loc9_.data);
               }
               _loc12_ = new SongDataEntry(_loc9_.id,_loc9_.length,_loc9_.name,_loc9_.creator,_loc11_);
               _loc12_.songData = _loc9_.data;
               UnknownVarFromHabboMusicController_Map_1.add(_loc9_.id,_loc12_);
               _loc5_ = getTopRequestPriority();
               _loc6_ = getSongIdRequestedAtPriority(_loc5_);
               if(_loc11_ != null && _loc11_.ready && _loc9_.id == _loc6_)
               {
                  playSongObject(_loc5_,_loc6_);
               }
               _events.dispatchEvent(new SongInfoReceivedEvent("SIR_TRAX_SONG_INFO_RECEIVED",_loc9_.id));
               while(UnknownVarFromHabboMusicController_Array_4.indexOf(_loc9_.id) != -1)
               {
                  UnknownVarFromHabboMusicController_Array_4.splice(UnknownVarFromHabboMusicController_Array_4.indexOf(_loc9_.id),1);
                  if(UnknownVarFromHabboMusicController_Array_4.length == 0)
                  {
                     _events.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
                  }
               }
               Logger.log("Received song info : " + _loc9_.id);
            }
            _loc8_++;
         }
      }
      
      private function playSongObject(param1:int, param2:int) : Boolean
      {
         if(param2 == -1 || param1 < 0 || param1 >= 4)
         {
            return false;
         }
         var _loc6_:Boolean = false;
         if(stopSongAtPriority(UnknownVarFromHabboMusicController_Int_1))
         {
            _loc6_ = true;
         }
         var _loc5_:SongDataEntry = getSongDataEntry(param2);
         if(_loc5_ == null)
         {
            Logger.log("WARNING: Unable to find song entry id " + param2 + " that was supposed to be loaded.");
            return false;
         }
         var _loc3_:IHabboSoundBase_1 = _loc5_.soundObject;
         if(_loc3_ == null || !_loc3_.ready)
         {
            return false;
         }
         if(_loc6_)
         {
            Logger.log("Waiting previous song to stop before playing song " + param2);
            return true;
         }
         _loc3_.volume = _soundManager.traxVolume;
         var _loc9_:Number = -1;
         var _loc7_:Number = 0;
         var _loc4_:Number = 2;
         var _loc8_:Number = 1;
         var _loc10_:SongStartRequestData = getSongStartRequest(param1);
         if(_loc10_ != null)
         {
            _loc9_ = _loc10_.startPos;
            _loc7_ = _loc10_.playLength;
            _loc4_ = _loc10_.fadeInSeconds;
            _loc8_ = _loc10_.fadeOutSeconds;
         }
         if(_loc9_ >= _loc5_.length / 1000)
         {
            return false;
         }
         if(_loc9_ == -1)
         {
            _loc9_ = 0;
         }
         _loc3_.fadeInSeconds = _loc4_;
         _loc3_.fadeOutSeconds = _loc8_;
         _loc3_.position = _loc9_;
         _loc3_.play(_loc7_);
         UnknownVarFromHabboMusicController_Int_1 = param1;
         UnknownVarFromHabboMusicController_Int_3 = getSongRequestCountAtPriority(param1);
         UnknownVarFromHabboMusicController_Int_2 = param2;
         if(UnknownVarFromHabboMusicController_Int_1 <= 0)
         {
            notifySongPlaying(_loc5_);
         }
         if(param1 > 0)
         {
            _events.dispatchEvent(new NowPlayingEvent("NPE_USER_PLAY_SONG",param1,_loc5_.id,-1));
         }
         Logger.log("Started playing song " + param2 + " at position " + _loc9_ + " for " + _loc7_ + " seconds (length " + _loc5_.length / 1000 + ") with priority " + param1);
         return true;
      }
      
      private function notifySongPlaying(param1:SongDataEntry) : void
      {
         var _loc2_:int = 8000;
         var _loc3_:int = getTimer();
         if(param1.length >= _loc2_ && (UnknownVarFromHabboMusicController_Int_4 != param1.id || _loc3_ > _previousNotificationTime + _loc2_))
         {
            _soundManager.notifyPlayedSong(param1.name,param1.creator);
            UnknownVarFromHabboMusicController_Int_4 = param1.id;
            _previousNotificationTime = _loc3_;
         }
      }
      
      private function areSamplesRequested(param1:int) : Boolean
      {
         if(UnknownVarFromHabboMusicController_Map_2.getValue(param1) == null)
         {
            return false;
         }
         return UnknownVarFromHabboMusicController_Map_2.getValue(param1);
      }
      
      private function onSongDiskInventoryMessage(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:UserSongDisksInventoryMessageEvent = param1 as UserSongDisksInventoryMessageEvent;
         var _loc2_:UserSongDisksInventoryMessageParser = _loc3_.getParser() as UserSongDisksInventoryMessageParser;
         UnknownVarFromHabboMusicController_Map_3.reset();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.songDiskCount)
         {
            _loc5_ = _loc2_.getDiskId(_loc4_);
            _loc6_ = _loc2_.getSongId(_loc4_);
            UnknownVarFromHabboMusicController_Map_3.add(_loc5_,_loc6_);
            if(UnknownVarFromHabboMusicController_Map_1.getValue(_loc6_) == null)
            {
               UnknownVarFromHabboMusicController_Array_4.push(_loc6_);
               requestSongInfoWithoutSamples(_loc6_);
            }
            _loc4_++;
         }
         if(UnknownVarFromHabboMusicController_Array_4.length == 0)
         {
            _events.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
         }
      }
      
      private function onSoundMachineInit(param1:Event) : void
      {
         disposeRoomPlaylist();
         _roomItemPlaylist = new SoundMachinePlayListController(_soundManager,this,_events,_roomEvents,UnknownVarFromHabboMusicController_IConnection_1) as IHabboSoundBase_2;
      }
      
      private function onSoundMachineDispose(param1:Event) : void
      {
         disposeRoomPlaylist();
      }
      
      private function onJukeboxInit(param1:Event) : void
      {
         disposeRoomPlaylist();
         _roomItemPlaylist = new JukeboxPlayListController(_soundManager,this,_events,UnknownVarFromHabboMusicController_IConnection_1) as IHabboSoundBase_2;
         UnknownVarFromHabboMusicController_IConnection_1.send(new GetNowPlayingMessageComposer());
      }
      
      private function onJukeboxDispose(param1:Event) : void
      {
         disposeRoomPlaylist();
      }
      
      private function disposeRoomPlaylist() : void
      {
         if(_roomItemPlaylist != null)
         {
            _roomItemPlaylist.dispose();
            _roomItemPlaylist = null;
         }
      }
   }
}

