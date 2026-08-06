package com.sulake.habbo.sound.music
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer;
   import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;
   import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;
   import com.sulake.habbo.sound.*;
   import com.sulake.habbo.sound.events.PlayListStatusEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class SoundMachinePlayListController implements IHabboSoundBase_2
   {
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var UnknownVarFromSoundMachinePlayListController_HabboMusicController_1:HabboMusicController;
      
      private var UnknownVarFromSoundMachinePlayListController_IConnection_1:IConnection;
      
      private var UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1:IEventDispatcher;
      
      private var _roomEvents:IEventDispatcher;
      
      private var _nowPlayingSongId:int = -1;
      
      private var _playListEntries:Array = [];
      
      private var _isPlaying:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var _messageEvents:Array;
      
      public function SoundMachinePlayListController(param1:HabboSoundManagerFlash10, param2:HabboMusicController, param3:IEventDispatcher, param4:IEventDispatcher, param5:IConnection)
      {
         super();
         _soundManager = param1;
         UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1 = param3;
         _roomEvents = param4;
         UnknownVarFromSoundMachinePlayListController_IConnection_1 = param5;
         UnknownVarFromSoundMachinePlayListController_HabboMusicController_1 = param2;
         _messageEvents = [];
         _messageEvents.push(new PlayListMessageEvent(onPlayListMessage));
         _messageEvents.push(new PlayListSongAddedMessageEvent(onPlayListSongAddedMessage));
         for each(var _loc6_ in _messageEvents)
         {
            UnknownVarFromSoundMachinePlayListController_IConnection_1.addMessageEvent(_loc6_);
         }
         UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1.addEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
         UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_SWITCHED_ON",onSoundMachinePlayEvent);
         _roomEvents.addEventListener("ROSM_SOUND_MACHINE_SWITCHED_OFF",onSoundMachineStopEvent);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get length() : int
      {
         if(_playListEntries == null)
         {
            return 0;
         }
         return _playListEntries.length;
      }
      
      public function get playPosition() : int
      {
         return -1;
      }
      
      public function get nowPlayingSongId() : int
      {
         return _nowPlayingSongId;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set playPosition(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_isPlaying)
            {
               stopPlaying();
            }
            _soundManager = null;
            if(UnknownVarFromSoundMachinePlayListController_IConnection_1)
            {
               for each(var _loc1_ in _messageEvents)
               {
                  UnknownVarFromSoundMachinePlayListController_IConnection_1.removeMessageEvent(_loc1_);
                  _loc1_.dispose();
               }
               _messageEvents = null;
               UnknownVarFromSoundMachinePlayListController_IConnection_1 = null;
            }
            _playListEntries = null;
            UnknownVarFromSoundMachinePlayListController_HabboMusicController_1 = null;
            if(UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1)
            {
               UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1.removeEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
               UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1 = null;
            }
            if(_roomEvents)
            {
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_SWITCHED_ON",onSoundMachinePlayEvent);
               _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_SWITCHED_OFF",onSoundMachineStopEvent);
               _roomEvents = null;
            }
            _disposed = true;
         }
      }
      
      private function onSoundMachinePlayEvent(param1:Event) : void
      {
         startPlaying();
      }
      
      private function onSoundMachineStopEvent(param1:Event) : void
      {
         stopPlaying();
      }
      
      public function startPlaying() : void
      {
         if(_isPlaying)
         {
            return;
         }
         if(_playListEntries == null || _playListEntries.length == 0)
         {
            requestPlayList();
            _isPlaying = true;
            return;
         }
         stopPlaying();
         _nowPlayingSongId = -1;
         _isPlaying = true;
         playNextSong();
      }
      
      public function checkSongPlayState(param1:int) : void
      {
         var _loc2_:SongDataEntry = null;
         if(_nowPlayingSongId == param1)
         {
            playCurrentSongAndNotify(_nowPlayingSongId);
            _loc2_ = getNextEntry();
            if(_loc2_ != null)
            {
               UnknownVarFromSoundMachinePlayListController_HabboMusicController_1.addSongInfoRequest(_loc2_.id);
            }
         }
      }
      
      public function stopPlaying() : void
      {
         _nowPlayingSongId = -1;
         _isPlaying = false;
         UnknownVarFromSoundMachinePlayListController_HabboMusicController_1.stop(0);
      }
      
      public function updateVolume(param1:Number) : void
      {
      }
      
      public function addItem(param1:ISongInfo, param2:int = 0) : int
      {
         return -1;
      }
      
      public function moveItem(param1:int, param2:int) : void
      {
      }
      
      public function removeItem(param1:int) : void
      {
      }
      
      private function onSongFinishedPlayingEvent(param1:SoundCompleteEvent) : void
      {
         if(param1.id == _nowPlayingSongId)
         {
            playNextSong();
         }
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc2_:SongDataEntry = null;
         var _loc4_:int = 0;
         var _loc3_:SongDataEntry = null;
         if(_playListEntries == null || _playListEntries.length == 0)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _playListEntries.length)
         {
            _loc2_ = _playListEntries[_loc4_];
            if(_loc2_.id == param1.id)
            {
               _loc3_ = UnknownVarFromSoundMachinePlayListController_HabboMusicController_1.getSongInfo(param1.id) as SongDataEntry;
               if(_loc3_ != null)
               {
                  _playListEntries[_loc4_] = _loc3_;
               }
               return;
            }
            _loc4_++;
         }
      }
      
      private function playNextSong() : void
      {
         var _loc1_:SongDataEntry = getNextEntry();
         if(_loc1_ != null)
         {
            _nowPlayingSongId = _loc1_.id;
            playCurrentSongAndNotify(_nowPlayingSongId);
         }
      }
      
      private function playCurrentSongAndNotify(param1:int) : void
      {
         var _loc2_:SongDataEntry = getEntryWithId(param1) as SongDataEntry;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Number = _loc2_.startPlayHeadPos;
         _loc2_.startPlayHeadPos = 0;
         if(UnknownVarFromSoundMachinePlayListController_HabboMusicController_1.playSong(param1,0,_loc3_,0,0,0))
         {
            Logger.log("Trax song started by playlist: " + _loc2_.name + " by " + _loc2_.creator);
         }
      }
      
      private function getNextEntry() : SongDataEntry
      {
         var _loc1_:SongDataEntry = null;
         var _loc2_:int = 0;
         if(_playListEntries == null || _playListEntries.length == 0)
         {
            return null;
         }
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _playListEntries.length)
         {
            _loc1_ = _playListEntries[_loc2_];
            if(_loc1_.id == _nowPlayingSongId)
            {
               _loc3_ = _loc2_ + 1;
            }
            _loc2_++;
         }
         if(_loc3_ >= _playListEntries.length)
         {
            _loc3_ = 0;
         }
         return _playListEntries[_loc3_];
      }
      
      public function getEntry(param1:int) : ISongInfo
      {
         if(_playListEntries == null || param1 < 0 || param1 >= _playListEntries.length)
         {
            return null;
         }
         return _playListEntries[param1];
      }
      
      public function getEntryWithId(param1:int) : ISongInfo
      {
         var _loc2_:SongDataEntry = null;
         var _loc3_:int = 0;
         if(_playListEntries == null || _playListEntries.length == 0)
         {
            return null;
         }
         _loc3_ = 0;
         while(_loc3_ < _playListEntries.length)
         {
            _loc2_ = _playListEntries[_loc3_];
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function requestPlayList() : void
      {
         if(UnknownVarFromSoundMachinePlayListController_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromSoundMachinePlayListController_IConnection_1.send(new GetSoundMachinePlayListMessageComposer());
      }
      
      private function convertParserPlayList(param1:Array) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(new SongDataEntry(_loc2_.id,_loc2_.length,_loc2_.name,_loc2_.creator,null));
         }
         return _loc3_;
      }
      
      private function onPlayListMessage(param1:IMessageEvent) : void
      {
         var _loc2_:SongDataEntry = null;
         var _loc7_:int = 0;
         var _loc5_:PlayListMessageEvent = param1 as PlayListMessageEvent;
         var _loc4_:PlayListMessageParser = _loc5_.getParser() as PlayListMessageParser;
         var _loc6_:int = _loc4_.synchronizationCount;
         var _loc3_:Array = convertParserPlayList(_loc4_.playList);
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return;
         }
         _playListEntries = _loc3_;
         var _loc8_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc2_ = _playListEntries[_loc7_];
            _loc8_ += _loc2_.length;
            _loc7_++;
         }
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         _loc6_ %= _loc8_;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc2_ = _playListEntries[_loc7_];
            if(_loc6_ <= _loc2_.length)
            {
               _nowPlayingSongId = _loc2_.id;
               _loc2_.startPlayHeadPos = _loc6_ / 1000;
               break;
            }
            _loc6_ -= _loc2_.length;
            _loc7_++;
         }
         UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         if(_loc2_ != null && _isPlaying)
         {
            playCurrentSongAndNotify(_loc2_.id);
         }
      }
      
      private function onPlayListSongAddedMessage(param1:IMessageEvent) : void
      {
         var _loc4_:PlayListSongAddedMessageEvent = param1 as PlayListSongAddedMessageEvent;
         var _loc3_:PlayListSongAddedMessageParser = _loc4_.getParser() as PlayListSongAddedMessageParser;
         var _loc2_:SongDataEntry = new SongDataEntry(_loc3_.entry.id,_loc3_.entry.length,_loc3_.entry.name,_loc3_.entry.creator,null);
         if(_loc2_ == null)
         {
            return;
         }
         _playListEntries.push(_loc2_);
         UnknownVarFromSoundMachinePlayListController_IEventDispatcher_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         if(!_isPlaying)
         {
            return;
         }
         if(_playListEntries.length == 1)
         {
            playCurrentSongAndNotify(_loc2_.id);
         }
         else
         {
            checkSongPlayState(_loc2_.id);
         }
      }
   }
}

