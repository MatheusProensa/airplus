package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MusicInventoryStatusView
   {
      public static const BUY_MORE:String = "MISV_BUY_MORE";
      
      public static const PREVIEW_PLAYING:String = "MISV_PREVIEW_PLAYING";
      
      private var _container:IWindowController_1;
      
      private var _windows:Map = new Map();
      
      private var UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var UnknownVarFromMusicInventoryStatusView_String_1:String;
      
      private var UnknownVarFromMusicInventoryStatusView_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromMusicInventoryStatusView_ITextWindow_2:ITextWindow;
      
      public function MusicInventoryStatusView(param1:PlayListEditorWidget, param2:IWindowController_1)
      {
         super();
         _container = param2;
         UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1 = param1;
         createWindows();
         hide();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in _windows.getValues())
         {
            _loc1_.destroy();
         }
         _windows = null;
      }
      
      public function show() : void
      {
         _container.visible = true;
      }
      
      public function hide() : void
      {
         _container.visible = false;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(_windows[param1] as IWindowController_1,0);
         UnknownVarFromMusicInventoryStatusView_String_1 = param1;
      }
      
      public function set songName(param1:String) : void
      {
         if(UnknownVarFromMusicInventoryStatusView_ITextWindow_1 == null)
         {
            return;
         }
         UnknownVarFromMusicInventoryStatusView_ITextWindow_1.text = param1;
      }
      
      public function set authorName(param1:String) : void
      {
         if(UnknownVarFromMusicInventoryStatusView_ITextWindow_2 == null)
         {
            return;
         }
         UnknownVarFromMusicInventoryStatusView_ITextWindow_2.text = param1;
      }
      
      public function setPreviewPlayingBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_PREVIEW_PLAYING","preview_play_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      public function setGetMoreMusicBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_BUY_MORE","get_more_music_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      private function createWindows() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc2_:XmlAsset = null;
         var _loc1_:UnknownICoreWindowComponents4 = null;
         var _loc4_:UnknownICoreWindowComponents4 = null;
         _loc2_ = UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_inventory_subwindow_play_preview") as XmlAsset;
         _loc3_ = UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_loc3_ != null)
         {
            _windows.add("MISV_PREVIEW_PLAYING",_loc3_);
            UnknownVarFromMusicInventoryStatusView_ITextWindow_1 = _loc3_.getChildByName("preview_play_track_name") as ITextWindow;
            UnknownVarFromMusicInventoryStatusView_ITextWindow_2 = _loc3_.getChildByName("preview_play_author_name") as ITextWindow;
            _loc1_ = _loc3_.getChildByName("stop_preview_button") as UnknownICoreWindowComponents4;
            _loc1_.addEventListener("WME_CLICK",onStopPreviewClicked);
            setPreviewPlayingBackgroundImage(UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.getImageGalleryAssetBitmap("background_preview_playing"));
            assignAssetByNameToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperController);
            assignAssetByNameToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperController);
         }
         _loc2_ = UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_inventory_subwindow_get_more_music") as XmlAsset;
         _loc3_ = UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_loc3_ != null)
         {
            _windows.add("MISV_BUY_MORE",_loc3_);
            _loc4_ = _loc3_.getChildByName("open_catalog_button") as UnknownICoreWindowComponents4;
            _loc4_.addEventListener("WME_CLICK",onOpenCatalogButtonClicked);
            setGetMoreMusicBackgroundImage(UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.getImageGalleryAssetBitmap("background_get_more_music"));
         }
      }
      
      private function blitBackgroundImage(param1:String, param2:String, param3:BitmapData) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:IWindowController_1 = _windows[param1] as IWindowController_1;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc4_:IBitmapWrapperController = _loc6_.getChildByName(param2) as IBitmapWrapperController;
         if(_loc4_ == null)
         {
            return;
         }
         if(param3 != null)
         {
            _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,false,4294967295);
            _loc5_.copyPixels(param3,param3.rect,new Point(0,0));
            _loc4_.bitmap = _loc5_;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperController) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset = UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
      
      private function onOpenCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.openSongDiskShopCataloguePage();
      }
      
      private function onStopPreviewClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMusicInventoryStatusView_PlayListEditorWidget_1.stopUserSong();
      }
   }
}

