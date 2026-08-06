package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.sound.IHabboSoundBase_2;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   
   public class PlayListEditorWidget extends RoomWidgetBase
   {
      private static const DISK_COLOR_RED_MIN:int = 130;
      
      private static const DISK_COLOR_RED_RANGE:int = 100;
      
      private static const DISK_COLOR_GREEN_MIN:int = 130;
      
      private static const DISK_COLOR_GREEN_RANGE:int = 100;
      
      private static const DISK_COLOR_BLUE_MIN:int = 130;
      
      private static const DISK_COLOR_BLUE_RANGE:int = 100;
      
      private var _catalog:IHabboCatalog;
      
      private var UnknownVarFromPlayListEditorWidget_IComponent_1_1:IComponent_1;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _mainWindowHandler:MainWindowHandler;
      
      private var UnknownVarFromPlayListEditorWidget_Int_1:int;
      
      public function PlayListEditorWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IHabboSoundManagerFlash10, param4:IAssetLibraryCollection, param5:IHabboLocalizationManager, param6:IComponent_1, param7:IHabboCatalog)
      {
         super(param1,param2,param4,param5);
         _soundManager = param3;
         UnknownVarFromPlayListEditorWidget_IComponent_1_1 = param6;
         _catalog = param7;
         _mainWindowHandler = null;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_mainWindowHandler)
            {
               _mainWindowHandler.destroy();
               _mainWindowHandler = null;
            }
            _soundManager = null;
            super.dispose();
         }
      }
      
      override public function get mainWindow() : IWindowModel
      {
         if(_mainWindowHandler == null)
         {
            return null;
         }
         return _mainWindowHandler.window;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.addEventListener("RWPLEE_SHOW_PLAYLIST_EDITOR",onShowPlayListEditorEvent);
         param1.addEventListener("RWPLEE_HIDE_PLAYLIST_EDITOR",onHidePlayListEditorEvent);
         param1.addEventListener("RWPLEE_INVENTORY_UPDATED",onInventoryUpdatedEvent);
         param1.addEventListener("RWPLEE_SONG_DISK_INVENTORY_UPDATED",onSongDiskInventoryUpdatedEvent);
         param1.addEventListener("RWPLEE_PLAY_LIST_UPDATED",onPlayListUpdatedEvent);
         param1.addEventListener("RWPLEE_PLAY_LIST_FULL",onPlayListFullEvent);
         param1.addEventListener("RWPLENPE_SONG_CHANGED",onNowPlayingChangedEvent);
         param1.addEventListener("RWPLENPE_USER_PLAY_SONG",onNowPlayingChangedEvent);
         param1.addEventListener("RWPLENPW_USER_STOP_SONG",onNowPlayingChangedEvent);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.removeEventListener("RWPLEE_SHOW_PLAYLIST_EDITOR",onShowPlayListEditorEvent);
         param1.removeEventListener("RWPLEE_HIDE_PLAYLIST_EDITOR",onHidePlayListEditorEvent);
         param1.removeEventListener("RWPLEE_INVENTORY_UPDATED",onInventoryUpdatedEvent);
         param1.removeEventListener("RWPLEE_SONG_DISK_INVENTORY_UPDATED",onSongDiskInventoryUpdatedEvent);
         param1.removeEventListener("RWPLEE_PLAY_LIST_UPDATED",onPlayListUpdatedEvent);
         param1.removeEventListener("RWPLEE_PLAY_LIST_FULL",onPlayListFullEvent);
         param1.removeEventListener("RWPLENPE_SONG_CHANGED",onNowPlayingChangedEvent);
         param1.removeEventListener("RWPLENPE_USER_PLAY_SONG",onNowPlayingChangedEvent);
         param1.removeEventListener("RWPLENPW_USER_STOP_SONG",onNowPlayingChangedEvent);
      }
      
      public function get mainWindowHandler() : MainWindowHandler
      {
         return _mainWindowHandler;
      }
      
      public function getDiskColorTransformFromSongData(param1:String) : ColorTransform
      {
         var _loc5_:int = 0;
         var _loc2_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            switch(_loc5_ % 3)
            {
               case 0:
                  _loc2_ += param1.charCodeAt(_loc5_) * 37 as int;
                  break;
               case 1:
                  _loc4_ += param1.charCodeAt(_loc5_) * 37 as int;
                  break;
               case 2:
                  _loc3_ += param1.charCodeAt(_loc5_) * 37 as int;
            }
            _loc5_++;
         }
         _loc2_ = _loc2_ % 100 + 130;
         _loc4_ = _loc4_ % 100 + 130;
         _loc3_ = _loc3_ % 100 + 130;
         return new ColorTransform(_loc2_ / 255,_loc4_ / 255,_loc3_ / 255);
      }
      
      public function sendAddToPlayListMessage(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RoomWidgetPlayListModificationMessage = null;
         var _loc2_:IHabboSoundBase_2 = _soundManager.musicController.getRoomItemPlaylist();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = new RoomWidgetPlayListModificationMessage("RWPLAM_ADD_TO_PLAYLIST",_loc3_,param1);
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(_loc4_);
            }
         }
      }
      
      public function sendRemoveFromPlayListMessage(param1:int) : void
      {
         var _loc2_:RoomWidgetPlayListModificationMessage = new RoomWidgetPlayListModificationMessage("RWPLAM_REMOVE_FROM_PLAYLIST",param1);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function sendTogglePlayPauseStateMessage() : void
      {
         var _loc1_:int = 0;
         if(_mainWindowHandler != null && _mainWindowHandler.playListEditorView != null)
         {
            _loc1_ = int(_mainWindowHandler.playListEditorView.selectedItemIndex != -1 ? _mainWindowHandler.playListEditorView.selectedItemIndex : 0);
         }
         var _loc2_:RoomWidgetPlayListPlayStateMessage = new RoomWidgetPlayListPlayStateMessage("RWPLPS_TOGGLE_PLAY_PAUSE",UnknownVarFromPlayListEditorWidget_Int_1,_loc1_);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function playUserSong(param1:int) : void
      {
         var _loc2_:ISongInfo = null;
         var _loc3_:int = _soundManager.musicController.getSongIdPlayingAtPriority(0);
         if(_loc3_ != -1)
         {
            _loc2_ = _soundManager.musicController.getSongInfo(_loc3_);
            if(_loc2_.soundObject != null)
            {
               _loc2_.soundObject.fadeOutSeconds = 0;
            }
         }
         _soundManager.musicController.playSong(param1,2,0,0,0,0);
      }
      
      public function stopUserSong() : void
      {
         _soundManager.musicController.stop(2);
      }
      
      public function getImageGalleryAssetBitmap(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapDataAsset = this.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return null;
         }
         _loc2_ = _loc3_.content as BitmapData;
         return _loc2_.clone();
      }
      
      public function retrieveWidgetImage(param1:String) : void
      {
         var _loc4_:String = UnknownVarFromPlayListEditorWidget_IComponent_1_1.getProperty("image.library.playlist.url");
         var _loc5_:String = _loc4_ + param1 + ".gif";
         Logger.log("[PlayListEditorWidget]  : " + _loc5_);
         var _loc2_:URLRequest = new URLRequest(_loc5_);
         var _loc3_:AssetLoaderStruct = this.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         _loc3_.addEventListener("AssetLoaderEventComplete",onWidgetImageReady);
      }
      
      public function openSongDiskShopCataloguePage() : void
      {
         var _loc1_:RoomWidgetPlayListUserActionMessage = new RoomWidgetPlayListUserActionMessage("RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED");
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
         _catalog.openCatalogPage("trax_songs");
      }
      
      public function alertPlayListFull() : void
      {
         this.windowManager.alert("${playlist.editor.alert.playlist.full.title}","${playlist.editor.alert.playlist.full}",0,alertHandler);
      }
      
      private function alertHandler(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onShowPlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         var _loc2_:IHabboSoundBase_2 = null;
         UnknownVarFromPlayListEditorWidget_Int_1 = param1.furniId;
         if(!_mainWindowHandler)
         {
            _mainWindowHandler = new MainWindowHandler(this,_soundManager.musicController);
            _mainWindowHandler.window.visible = false;
         }
         if(!_mainWindowHandler.window.visible)
         {
            _mainWindowHandler.show();
            _soundManager.musicController.requestUserSongDisks();
            _loc2_ = _soundManager.musicController.getRoomItemPlaylist();
            if(_loc2_ != null)
            {
               _loc2_.requestPlayList();
            }
         }
      }
      
      private function onHidePlayListEditorEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(_mainWindowHandler != null)
         {
            if(_mainWindowHandler.window.visible)
            {
               _mainWindowHandler.hide();
            }
         }
      }
      
      private function onInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(!_mainWindowHandler)
         {
            return;
         }
         if(_mainWindowHandler.window.visible)
         {
            _soundManager.musicController.requestUserSongDisks();
         }
      }
      
      private function onWidgetImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         if(param1.type == "AssetLoaderEventComplete")
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               if(_mainWindowHandler != null)
               {
                  _mainWindowHandler.refreshLoadableAsset(_loc2_.assetName);
               }
            }
         }
      }
      
      private function onSongDiskInventoryUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(_mainWindowHandler)
         {
            _mainWindowHandler.onSongDiskInventoryReceived();
         }
      }
      
      private function onPlayListUpdatedEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         if(_mainWindowHandler)
         {
            _mainWindowHandler.onPlayListUpdated();
         }
      }
      
      private function onPlayListFullEvent(param1:RoomWidgetPlayListEditorEvent) : void
      {
         alertPlayListFull();
      }
      
      private function onNowPlayingChangedEvent(param1:RoomWidgetPlayListEditorNowPlayingEvent) : void
      {
         if(_mainWindowHandler)
         {
            _mainWindowHandler.onNowPlayingChanged(param1);
         }
      }
   }
}

