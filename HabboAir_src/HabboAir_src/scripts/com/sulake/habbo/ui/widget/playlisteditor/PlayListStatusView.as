package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class PlayListStatusView
   {
      public static const ADD_SONGS:String = "PLSV_ADD_SONGS";
      
      public static const START_PLAYBACK:String = "PLSV_START_PLAYBACK";
      
      public static const NOW_PLAYING:String = "PLSV_NOW_PLAYING";
      
      private var _container:IWindowController_1;
      
      private var _windows:Map = new Map();
      
      private var UnknownVarFromPlayListStatusView_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var UnknownVarFromPlayListStatusView_String_1:String;
      
      public function PlayListStatusView(param1:PlayListEditorWidget, param2:IWindowController_1)
      {
         super();
         _container = param2;
         UnknownVarFromPlayListStatusView_PlayListEditorWidget_1 = param1;
         createWindows();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in _windows.getValues())
         {
            _loc1_.destroy();
         }
         _windows = null;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(_windows[param1] as IWindowController_1,0);
         UnknownVarFromPlayListStatusView_String_1 = param1;
      }
      
      public function set nowPlayingTrackName(param1:String) : void
      {
         if(UnknownVarFromPlayListStatusView_String_1 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:IWindowController_1 = _windows[UnknownVarFromPlayListStatusView_String_1];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_track_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set nowPlayingAuthorName(param1:String) : void
      {
         if(UnknownVarFromPlayListStatusView_String_1 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:IWindowController_1 = _windows[UnknownVarFromPlayListStatusView_String_1];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_author_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set addSongsBackgroundImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowController_1 = _windows["PLSV_ADD_SONGS"];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _loc2_.getChildByName("background_image") as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.bitmap = param1.clone();
         _loc3_.width = param1.width;
         _loc3_.height = param1.height;
      }
      
      private function createWindows() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc2_:XmlAsset = null;
         var _loc4_:UnknownICoreWindowComponents4 = null;
         var _loc1_:UnknownICoreWindowComponents5 = null;
         _loc2_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset;
         _loc3_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_loc3_ != null)
         {
            _windows.add("PLSV_ADD_SONGS",_loc3_);
         }
         _loc2_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset;
         _loc3_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_loc3_ != null)
         {
            _windows.add("PLSV_START_PLAYBACK",_loc3_);
            _loc4_ = _loc3_.getChildByName("play_now_button") as UnknownICoreWindowComponents4;
            _loc4_.addEventListener("WME_CLICK",onPlayPauseClicked);
         }
         _loc2_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset;
         _loc3_ = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_loc3_ != null)
         {
            _windows.add("PLSV_NOW_PLAYING",_loc3_);
            _loc1_ = _loc3_.getChildByName("button_pause") as UnknownICoreWindowComponents5;
            _loc1_.addEventListener("WME_CLICK",onPlayPauseClicked);
            assignAssetToElement("icon_pause_large",_loc1_.getChildByName("pause_image") as IBitmapWrapperController);
            assignAssetToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperController);
            assignAssetToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperController);
         }
      }
      
      private function assignAssetToElement(param1:String, param2:IBitmapWrapperController) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset = UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
      
      private function onPlayPauseClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromPlayListStatusView_PlayListEditorWidget_1.sendTogglePlayPauseStateMessage();
      }
   }
}

