package com.sulake.habbo.sound.music
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;
   import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;
   import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;
   import com.sulake.habbo.sound.HabboSoundManagerFlash10;
   import com.sulake.habbo.sound.IHabboSoundBase_2;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.UnknownIHabboSound1;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.PlayListStatusEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   
   public class JukeboxPlayListController implements IHabboSoundBase_2
   {
      private var _disposed:Boolean = false;
      
      private var _isPlaying:Boolean = false;
      
      private var _entries:Array = [];
      
      private var UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1:UnknownIHabboSound1;
      
      private var UnknownVarFromJukeboxPlayListController_IEventDispatcher_1:IEventDispatcher;
      
      private var UnknownVarFromJukeboxPlayListController_IConnection_1:IConnection;
      
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var _nowPlayingSongId:int = -1;
      
      private var _missingSongInfo:Array = [];
      
      private var _messageEvents:Array;
      
      private var _playPosition:int = -1;
      
      public function JukeboxPlayListController(param1:HabboSoundManagerFlash10, param2:HabboMusicController, param3:IEventDispatcher, param4:IConnection)
      {
         super();
         _soundManager = param1;
         UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1 = param2;
         UnknownVarFromJukeboxPlayListController_IEventDispatcher_1 = param3;
         UnknownVarFromJukeboxPlayListController_IConnection_1 = param4;
         _messageEvents = [];
         _messageEvents.push(new NowPlayingMessageEvent(onNowPlayingMessage));
         _messageEvents.push(new JukeboxSongDisksMessageEvent(onJukeboxSongDisksMessage));
         _messageEvents.push(new JukeboxPlayListFullMessageEvent(onJukeboxPlayListFullMessage));
         for each(var _loc5_ in _messageEvents)
         {
            UnknownVarFromJukeboxPlayListController_IConnection_1.addMessageEvent(_loc5_);
         }
         UnknownVarFromJukeboxPlayListController_IEventDispatcher_1.addEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
         UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get nowPlayingSongId() : int
      {
         return _nowPlayingSongId;
      }
      
      public function get playPosition() : int
      {
         return _playPosition;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function get length() : int
      {
         if(_entries == null)
         {
            return 0;
         }
         return _entries.length;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            stopPlaying();
            if(UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.events)
            {
               UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1 = null;
            _soundManager = null;
            if(UnknownVarFromJukeboxPlayListController_IConnection_1)
            {
               for each(var _loc1_ in _messageEvents)
               {
                  UnknownVarFromJukeboxPlayListController_IConnection_1.removeMessageEvent(_loc1_);
                  _loc1_.dispose();
               }
               _messageEvents = null;
               UnknownVarFromJukeboxPlayListController_IConnection_1 = null;
            }
            if(UnknownVarFromJukeboxPlayListController_IEventDispatcher_1)
            {
               UnknownVarFromJukeboxPlayListController_IEventDispatcher_1.removeEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
               UnknownVarFromJukeboxPlayListController_IEventDispatcher_1 = null;
            }
            _disposed = true;
         }
      }
      
      public function stopPlaying() : void
      {
         UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.stop(priority);
         _nowPlayingSongId = -1;
         _playPosition = -1;
         _isPlaying = false;
      }
      
      public function requestPlayList() : void
      {
         if(UnknownVarFromJukeboxPlayListController_IConnection_1 == null)
         {
            return;
         }
         UnknownVarFromJukeboxPlayListController_IConnection_1.send(new GetJukeboxPlayListMessageComposer());
      }
      
      public function getEntry(param1:int) : ISongInfo
      {
         if(param1 < 0 || param1 >= _entries.length)
         {
            return null;
         }
         return _entries[param1];
      }
      
      protected function onSongFinishedPlayingEvent(param1:SoundCompleteEvent) : void
      {
      }
      
      private function onNowPlayingMessage(param1:IMessageEvent) : void
      {
         var _loc3_:NowPlayingMessageEvent = param1 as NowPlayingMessageEvent;
         var _loc2_:NowPlayingMessageParser = _loc3_.getParser() as NowPlayingMessageParser;
         Logger.log("Received Now Playing message with: " + _loc2_.currentSongId + ", " + _loc2_.nextSongId + ", " + _loc2_.syncCount);
         _isPlaying = _loc2_.currentSongId != -1;
         if(_loc2_.currentSongId >= 0)
         {
            UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.playSong(_loc2_.currentSongId,0,_loc2_.syncCount / 1000,0,1,1);
            _nowPlayingSongId = _loc2_.currentSongId;
         }
         else
         {
            stopPlaying();
         }
         if(_loc2_.nextSongId >= 0)
         {
            UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.addSongInfoRequest(_loc2_.nextSongId);
         }
         _playPosition = _loc2_.currentPosition;
         _soundManager.events.dispatchEvent(new NowPlayingEvent("NPE_SONG_CHANGED",0,_loc2_.currentSongId,_loc2_.currentPosition));
      }
      
      private function onJukeboxSongDisksMessage(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:SongDataEntry = null;
         var _loc5_:JukeboxSongDisksMessageEvent = param1 as JukeboxSongDisksMessageEvent;
         var _loc2_:JukeboxSongDisksMessageParser = _loc5_.getParser() as JukeboxSongDisksMessageParser;
         Logger.log("Received Jukebox song disks (=playlist) message, length of playlist: " + _loc2_.songDisks.length);
         _entries = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.songDisks.length)
         {
            _loc7_ = _loc2_.songDisks.getWithIndex(_loc4_);
            _loc6_ = _loc2_.songDisks.getKey(_loc4_);
            _loc3_ = UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.getSongInfo(_loc7_) as SongDataEntry;
            if(_loc3_ == null)
            {
               _loc3_ = new SongDataEntry(_loc7_,-1,null,null,null);
               if(_missingSongInfo.indexOf(_loc7_) < 0)
               {
                  _missingSongInfo.push(_loc7_);
                  UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.requestSongInfoWithoutSamples(_loc7_);
               }
            }
            _loc3_.diskId = _loc6_;
            _entries.push(_loc3_);
            _loc4_++;
         }
         if(_missingSongInfo.length == 0)
         {
            UnknownVarFromJukeboxPlayListController_IEventDispatcher_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         }
      }
      
      private function onJukeboxPlayListFullMessage(param1:IMessageEvent) : void
      {
         Logger.log("Received jukebox playlist full message.");
         UnknownVarFromJukeboxPlayListController_IEventDispatcher_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_FULL"));
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ISongInfo = null;
         var _loc6_:int = 0;
         var _loc3_:SongDataEntry = null;
         _loc4_ = 0;
         while(_loc4_ < length)
         {
            _loc2_ = _entries[_loc4_];
            if(_loc2_.id == param1.id)
            {
               _loc6_ = _loc2_.diskId;
               _loc3_ = UnknownVarFromJukeboxPlayListController_UnknownIHabboSound1_1.getSongInfo(param1.id) as SongDataEntry;
               if(_loc3_ != null)
               {
                  _loc3_.diskId = _loc6_;
                  _entries[_loc4_] = _loc3_;
               }
               break;
            }
            _loc4_++;
         }
         var _loc5_:int = int(_missingSongInfo.indexOf(param1.id));
         if(_loc5_ >= 0)
         {
            _missingSongInfo.splice(_loc5_,1);
         }
         if(_missingSongInfo.length == 0)
         {
            UnknownVarFromJukeboxPlayListController_IEventDispatcher_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         }
      }
   }
}

