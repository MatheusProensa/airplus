package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.sound.IHabboSoundBase_2;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.UnknownIHabboSound1;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MainWindowHandler
   {
      private static const SHOW_BUY_MORE_MUSIC_DISK_COUNT:int = 6;
      
      private static const MY_MUSIC_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 9;
      
      private static const PLAYLIST_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 5;
      
      private var UnknownVarFromMainWindowHandler_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1:UnknownIHabboSound1;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2:UnknownICoreWindowComponents6;
      
      private var _musicInventoryView:MusicInventoryGridView;
      
      private var _playListEditorView:PlayListEditorItemListView;
      
      private var UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1:MusicInventoryStatusView;
      
      private var UnknownVarFromMainWindowHandler_PlayListStatusView_1:PlayListStatusView;
      
      private var UnknownVarFromMainWindowHandler_IScrollbarWindow_1:IScrollbarWindow;
      
      private var UnknownVarFromMainWindowHandler_IScrollbarWindow_2:IScrollbarWindow;
      
      public function MainWindowHandler(param1:PlayListEditorWidget, param2:UnknownIHabboSound1)
      {
         var _loc3_:BitmapData = null;
         super();
         UnknownVarFromMainWindowHandler_PlayListEditorWidget_1 = param1;
         UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1 = param2;
         var _loc5_:Array = ["title_mymusic","title_playlist","background_preview_playing","background_get_more_music","background_add_songs"];
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.getImageGalleryAssetBitmap(_loc4_);
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
            else
            {
               UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.retrieveWidgetImage(_loc4_);
            }
         }
         createWindow();
         _musicInventoryView = new MusicInventoryGridView(param1,getMusicInventoryGrid(),param2);
         _playListEditorView = new PlayListEditorItemListView(param1,getPlayListEditorItemList());
         UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1 = new MusicInventoryStatusView(param1,getMusicInventoryStatusContainer());
         UnknownVarFromMainWindowHandler_PlayListStatusView_1 = new PlayListStatusView(param1,getPlayListStatusContainer());
         refreshLoadableAsset();
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function get musicInventoryView() : MusicInventoryGridView
      {
         return _musicInventoryView;
      }
      
      public function get playListEditorView() : PlayListEditorItemListView
      {
         return _playListEditorView;
      }
      
      public function destroy() : void
      {
         if(UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1)
         {
            UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.stop(2);
            UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1 = null;
         }
         if(_musicInventoryView)
         {
            _musicInventoryView.destroy();
            _musicInventoryView = null;
         }
         if(_playListEditorView)
         {
            _playListEditorView.destroy();
            _playListEditorView = null;
         }
         if(UnknownVarFromMainWindowHandler_PlayListStatusView_1)
         {
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.destroy();
            UnknownVarFromMainWindowHandler_PlayListStatusView_1 = null;
         }
         if(UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1)
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.destroy();
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1 = null;
         }
         _window.destroy();
         _window = null;
      }
      
      public function hide() : void
      {
         _window.visible = false;
         if(UnknownVarFromMainWindowHandler_PlayListEditorWidget_1 != null)
         {
            UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.stopUserSong();
         }
      }
      
      public function show() : void
      {
         UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.requestUserSongDisks();
         var _loc1_:IHabboSoundBase_2 = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getRoomItemPlaylist();
         if(_loc1_ != null)
         {
            _loc1_.requestPlayList();
            selectPlayListStatusViewByFurniPlayListState();
         }
         _window.visible = true;
      }
      
      public function refreshLoadableAsset(param1:String = "") : void
      {
         if(param1 == "" || param1 == "title_mymusic")
         {
            assignWindowBitmapByAsset(UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1,"music_inventory_splash_image","title_mymusic");
         }
         if(param1 == "" || param1 == "title_playlist")
         {
            assignWindowBitmapByAsset(UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2,"playlist_editor_splash_image","title_playlist");
         }
         if(param1 == "" || param1 == "background_preview_playing")
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.setPreviewPlayingBackgroundImage(UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.getImageGalleryAssetBitmap("background_preview_playing"));
         }
         if(param1 == "" || param1 == "background_get_more_music")
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.setGetMoreMusicBackgroundImage(UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.getImageGalleryAssetBitmap("background_get_more_music"));
         }
         if(param1 == "" || param1 == "background_add_songs")
         {
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.addSongsBackgroundImage = UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.getImageGalleryAssetBitmap("background_add_songs");
         }
      }
      
      private function assignWindowBitmapByAsset(param1:IWindowController_1, param2:String, param3:String) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:IBitmapWrapperController = param1.getChildByName(param2) as IBitmapWrapperController;
         if(_loc5_ != null)
         {
            _loc4_ = UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.getImageGalleryAssetBitmap(param3);
            if(_loc4_ != null)
            {
               _loc5_.bitmap = _loc4_;
               _loc5_.width = _loc4_.width;
               _loc5_.height = _loc4_.height;
            }
         }
      }
      
      private function createWindow() : void
      {
         if(UnknownVarFromMainWindowHandler_PlayListEditorWidget_1 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_main_window") as XmlAsset;
         _window = UnknownVarFromMainWindowHandler_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.position = new Point(80,0);
         var _loc3_:IWindowController_1 = _window.getChildByName("content_area") as IWindowController_1;
         if(_loc3_ == null)
         {
            throw new Error("Window is missing \'content_area\' element");
         }
         UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1 = _loc3_.getChildByName("my_music_border") as UnknownICoreWindowComponents6;
         UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2 = _loc3_.getChildByName("playlist_border") as UnknownICoreWindowComponents6;
         if(UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1 == null)
         {
            throw new Error("Window content area is missing \'my_music_border\' window element");
         }
         if(UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2 == null)
         {
            throw new Error("Window content area is missing \'playlist_border\' window element");
         }
         UnknownVarFromMainWindowHandler_IScrollbarWindow_1 = UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1.getChildByName("music_inventory_scrollbar") as IScrollbarWindow;
         UnknownVarFromMainWindowHandler_IScrollbarWindow_2 = UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2.getChildByName("playlist_scrollbar") as IScrollbarWindow;
         if(UnknownVarFromMainWindowHandler_IScrollbarWindow_1 == null)
         {
            throw new Error("Window content area is missing \'music_inventory_scrollbar\' window element");
         }
         if(UnknownVarFromMainWindowHandler_IScrollbarWindow_2 == null)
         {
            throw new Error("Window content area is missing \'playlist_scrollbar\' window element");
         }
         var _loc1_:IWindowModel = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function getMusicInventoryGrid() : IItemGridWindow
      {
         return UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1.getChildByName("music_inventory_itemgrid") as IItemGridWindow;
      }
      
      private function getPlayListEditorItemList() : IItemListWindow
      {
         return UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2.getChildByName("playlist_editor_itemlist") as IItemListWindow;
      }
      
      private function getMusicInventoryStatusContainer() : IWindowController_1
      {
         return UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_1.getChildByName("preview_play_container") as IWindowController_1;
      }
      
      private function getPlayListStatusContainer() : IWindowController_1
      {
         return UnknownVarFromMainWindowHandler_UnknownICoreWindowComponents6_2.getChildByName("now_playing_container") as IWindowController_1;
      }
      
      private function selectPlayListStatusViewByFurniPlayListState() : void
      {
         var _loc1_:IHabboSoundBase_2 = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.isPlaying)
         {
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.selectView("PLSV_NOW_PLAYING");
         }
         else if(_loc1_.length > 0)
         {
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.selectView("PLSV_START_PLAYBACK");
         }
         else
         {
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.selectView("PLSV_ADD_SONGS");
         }
      }
      
      private function selectMusicStatusViewByMusicState() : void
      {
         if(isPreviewPlaying())
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.show();
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.selectView("MISV_PREVIEW_PLAYING");
         }
         else if(UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getSongDiskInventorySize() <= 6)
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.show();
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.selectView("MISV_BUY_MORE");
         }
         else
         {
            UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.hide();
         }
      }
      
      private function updatePlaylistEditorView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:ISongInfo = null;
         var _loc2_:IHabboSoundBase_2 = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getRoomItemPlaylist();
         var _loc3_:Array = [];
         var _loc1_:int = -1;
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_.getEntry(_loc4_);
               if(_loc5_ != null)
               {
                  _loc3_.push(_loc5_);
               }
               _loc4_++;
            }
            _loc1_ = _loc2_.playPosition;
         }
         _playListEditorView.refresh(_loc3_,_loc1_);
      }
      
      public function onPlayListUpdated() : void
      {
         var _loc3_:ISongInfo = null;
         updatePlaylistEditorView();
         selectPlayListStatusViewByFurniPlayListState();
         var _loc1_:IHabboSoundBase_2 = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = _loc1_.nowPlayingSongId;
         if(_loc2_ != -1)
         {
            _loc3_ = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getSongInfo(_loc2_);
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.nowPlayingTrackName = _loc3_.name;
            UnknownVarFromMainWindowHandler_PlayListStatusView_1.nowPlayingAuthorName = _loc3_.creator;
         }
         UnknownVarFromMainWindowHandler_IScrollbarWindow_2.visible = _loc1_.length > 5;
      }
      
      public function onSongDiskInventoryReceived() : void
      {
         _musicInventoryView.refresh();
         selectMusicStatusViewByMusicState();
         UnknownVarFromMainWindowHandler_IScrollbarWindow_1.visible = _musicInventoryView.itemCount > 9;
      }
      
      public function onNowPlayingChanged(param1:RoomWidgetPlayListEditorNowPlayingEvent) : void
      {
         var _loc3_:ISongInfo = null;
         var _loc2_:ISongInfo = null;
         switch(param1.type)
         {
            case "RWPLENPE_SONG_CHANGED":
               selectPlayListStatusViewByFurniPlayListState();
               _playListEditorView.setItemIndexPlaying(param1.position);
               if(param1.id != -1)
               {
                  _loc3_ = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getSongInfo(param1.id);
                  UnknownVarFromMainWindowHandler_PlayListStatusView_1.nowPlayingTrackName = _loc3_ != null ? _loc3_.name : "";
                  UnknownVarFromMainWindowHandler_PlayListStatusView_1.nowPlayingAuthorName = _loc3_ != null ? _loc3_.creator : "";
               }
               break;
            case "RWPLENPE_USER_PLAY_SONG":
               _musicInventoryView.setPreviewIconToPause();
               _loc2_ = UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getSongInfo(param1.id);
               UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.songName = _loc2_ != null ? _loc2_.name : "";
               UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.songName = _loc2_ != null ? _loc2_.name : "";
               UnknownVarFromMainWindowHandler_MusicInventoryStatusView_1.authorName = _loc2_ != null ? _loc2_.creator : "";
               selectMusicStatusViewByMusicState();
               break;
            case "RWPLENPW_USER_STOP_SONG":
               _musicInventoryView.setPreviewIconToPlay();
               selectMusicStatusViewByMusicState();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function isPreviewPlaying() : Boolean
      {
         return UnknownVarFromMainWindowHandler_UnknownIHabboSound1_1.getSongIdPlayingAtPriority(2) != -1;
      }
   }
}

