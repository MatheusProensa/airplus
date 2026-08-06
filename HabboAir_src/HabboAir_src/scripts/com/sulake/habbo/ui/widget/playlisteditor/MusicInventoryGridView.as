package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.UnknownIHabboSound1;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridView
   {
      private var UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1:UnknownIHabboSound1;
      
      private var UnknownVarFromMusicInventoryGridView_IItemGridWindow_1:IItemGridWindow;
      
      private var _items:Map = new Map();
      
      private var UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1:MusicInventoryGridItem;
      
      public function MusicInventoryGridView(param1:PlayListEditorWidget, param2:IItemGridWindow, param3:UnknownIHabboSound1)
      {
         super();
         UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1 = param3;
         UnknownVarFromMusicInventoryGridView_IItemGridWindow_1 = param2;
         UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1 = param1;
         UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 = null;
         UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get itemCount() : int
      {
         return _items.length;
      }
      
      public function destroy() : void
      {
         if(UnknownVarFromMusicInventoryGridView_IItemGridWindow_1 != null)
         {
            UnknownVarFromMusicInventoryGridView_IItemGridWindow_1.destroyGridItems();
            UnknownVarFromMusicInventoryGridView_IItemGridWindow_1 = null;
         }
         if(UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1 != null)
         {
            if(UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.events != null)
            {
               UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1 = null;
         }
         if(_items)
         {
            _items.reset();
            _items = null;
         }
         UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 = null;
         UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1 = null;
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:ISongInfo = null;
         var _loc1_:String = null;
         var _loc13_:ColorTransform = null;
         var _loc3_:MusicInventoryGridItem = null;
         var _loc7_:MusicInventoryGridItem = null;
         if(UnknownVarFromMusicInventoryGridView_IItemGridWindow_1 == null)
         {
            return;
         }
         UnknownVarFromMusicInventoryGridView_IItemGridWindow_1.removeGridItems();
         var _loc8_:Map = _items;
         var _loc2_:Map = new Map();
         var _loc5_:Array = _loc8_.getKeys();
         _items = new Map();
         var _loc6_:int = UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.getSongDiskInventorySize();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc9_ = UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.getSongDiskInventoryDiskId(_loc4_);
            _loc11_ = UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.getSongDiskInventorySongId(_loc4_);
            _loc12_ = UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.getSongInfo(_loc11_);
            _loc1_ = null;
            _loc13_ = null;
            if(_loc12_ != null)
            {
               _loc1_ = _loc12_.name;
               _loc13_ = UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.getDiskColorTransformFromSongData(_loc12_.songData);
            }
            if(_loc5_.indexOf(_loc9_) == -1)
            {
               _loc3_ = new MusicInventoryGridItem(UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1,_loc9_,_loc11_,_loc1_,_loc13_);
            }
            else
            {
               _loc3_ = _loc8_[_loc9_];
               _loc5_.splice(_loc5_.indexOf(_loc9_),1);
            }
            _loc3_.window.procedure = gridItemEventProc;
            _loc3_.toPlayListButton.procedure = gridItemEventProc;
            UnknownVarFromMusicInventoryGridView_IItemGridWindow_1.addGridItem(_loc3_.window);
            _items.add(_loc9_,_loc3_);
            _loc4_++;
         }
         for each(var _loc10_ in _loc5_)
         {
            _loc7_ = _loc8_[_loc10_];
            _loc7_.destroy();
            _loc8_.remove(_loc10_);
         }
      }
      
      public function setPreviewIconToPause() : void
      {
         if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 != null)
         {
            UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.playButtonState = 1;
         }
      }
      
      public function setPreviewIconToPlay() : void
      {
         if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 != null)
         {
            UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.playButtonState = 0;
         }
      }
      
      public function deselectAny() : void
      {
         if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 != null)
         {
            UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.deselect();
            UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 = null;
         }
      }
      
      private function gridItemEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc5_:MusicInventoryGridItem = null;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_to_playlist" || _loc3_)
            {
               if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 != null)
               {
                  UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.deselect();
                  stopPreview();
                  UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.sendAddToPlayListMessage(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.diskId);
                  UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 = null;
               }
            }
            else if(param2.name == "button_play_pause")
            {
               if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.playButtonState == 0)
               {
                  UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.playButtonState = 2;
                  UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.playUserSong(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.songId);
               }
               else
               {
                  stopPreview();
               }
            }
            else
            {
               _loc4_ = UnknownVarFromMusicInventoryGridView_IItemGridWindow_1.getGridItemIndex(param1.window);
               if(_loc4_ != -1)
               {
                  _loc5_ = _items.getWithIndex(_loc4_);
                  if(_loc5_ != UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1)
                  {
                     if(UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 != null)
                     {
                        UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.deselect();
                     }
                     UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1 = _loc5_;
                     UnknownVarFromMusicInventoryGridView_MusicInventoryGridItem_1.select();
                     stopPreview();
                  }
                  if(UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.mainWindowHandler != null)
                  {
                     UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.mainWindowHandler.playListEditorView.deselectAny();
                  }
               }
            }
         }
      }
      
      private function stopPreview() : void
      {
         UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.stopUserSong();
         setPreviewIconToPlay();
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc4_:ISongInfo = null;
         var _loc2_:String = null;
         var _loc5_:ColorTransform = null;
         var _loc3_:MusicInventoryGridItem = null;
         if(UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1 != null)
         {
            _loc4_ = UnknownVarFromMusicInventoryGridView_UnknownIHabboSound1_1.getSongInfo(param1.id);
            if(_loc4_ != null)
            {
               _loc2_ = _loc4_.name;
               _loc5_ = UnknownVarFromMusicInventoryGridView_PlayListEditorWidget_1.getDiskColorTransformFromSongData(_loc4_.songData);
               _loc3_ = _items[param1.id];
               if(_loc3_ != null)
               {
                  _loc3_.update(param1.id,_loc2_,_loc5_);
               }
            }
         }
      }
   }
}

