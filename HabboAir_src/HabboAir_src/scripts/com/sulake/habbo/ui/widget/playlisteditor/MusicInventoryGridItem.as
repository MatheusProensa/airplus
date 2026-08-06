package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridItem
   {
      public static const UnknownConstFromMusicInventoryGridItem_Int_1:int = 0;
      
      public static const UnknownConstFromMusicInventoryGridItem_Int_2:int = 1;
      
      public static const BUTTON_STATE_DOWNLOAD:int = 2;
      
      private static const BG_COLOR_SELECTED:uint = 14612159;
      
      private static const BG_COLOR_UNSELECTED:uint = 15856113;
      
      private var UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var _window:IWindowController_1 = null;
      
      private var _diskId:int;
      
      private var _songId:int;
      
      private var _toPlayListButton:UnknownICoreWindowComponents5 = null;
      
      private var _playButtonState:int;
      
      public function MusicInventoryGridItem(param1:PlayListEditorWidget, param2:int, param3:int, param4:String, param5:ColorTransform)
      {
         super();
         UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1 = param1;
         _diskId = param2;
         _songId = param3;
         createWindow();
         deselect();
         if(param4 != null && param5 != null)
         {
            trackName = param4;
            diskColor = param5;
         }
      }
      
      public function get window() : IWindowModel
      {
         return _window as IWindowModel;
      }
      
      public function get diskId() : int
      {
         return _diskId;
      }
      
      public function get songId() : int
      {
         return _songId;
      }
      
      public function get toPlayListButton() : UnknownICoreWindowComponents5
      {
         return _toPlayListButton;
      }
      
      public function get playButtonState() : int
      {
         return _playButtonState;
      }
      
      public function update(param1:int, param2:String, param3:ColorTransform) : void
      {
         if(param1 == _songId)
         {
            trackName = param2;
            diskColor = param3;
         }
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
         }
      }
      
      private function createWindow() : void
      {
         var _loc3_:BitmapDataAsset = null;
         if(UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("playlisteditor_music_inventory_item") as XmlAsset;
         _window = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:IWindowController_1 = _window.getChildByName("action_buttons") as IWindowController_1;
         if(_loc1_ != null)
         {
            _toPlayListButton = _loc1_.getChildByName("button_to_playlist") as UnknownICoreWindowComponents5;
         }
         assignAssetByNameToElement("title_fader",_window.getChildByName("title_fader_bitmap") as IBitmapWrapperController);
         _loc3_ = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("icon_arrow") as BitmapDataAsset;
         if(_loc3_ != null)
         {
            if(_loc3_.content != null)
            {
               this.buttonToPlaylistBitmap = _loc3_.content as BitmapData;
            }
         }
         this.playButtonState = 0;
      }
      
      public function select() : void
      {
         var _loc2_:UnknownICoreWindowComponents6 = _window.getChildByName("background") as UnknownICoreWindowComponents6;
         if(_loc2_ != null)
         {
            _loc2_.color = 14612159;
         }
         var _loc3_:IWindowController_1 = _window.getChildByName("action_buttons") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         var _loc1_:UnknownICoreWindowComponents6 = _window.getChildByName("selected") as UnknownICoreWindowComponents6;
         if(_loc1_ != null)
         {
            _loc1_.visible = true;
         }
      }
      
      public function deselect() : void
      {
         var _loc2_:UnknownICoreWindowComponents6 = _window.getChildByName("background") as UnknownICoreWindowComponents6;
         if(_loc2_ != null)
         {
            _loc2_.color = 15856113;
         }
         var _loc3_:IWindowController_1 = _window.getChildByName("action_buttons") as IWindowController_1;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
         var _loc1_:UnknownICoreWindowComponents6 = _window.getChildByName("selected") as UnknownICoreWindowComponents6;
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc3_:BitmapDataAsset = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("icon_cd_big") as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.content != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
            _loc4_ = _loc2_.clone();
            if(_loc4_ != null)
            {
               _loc4_.colorTransform(_loc2_.rect,param1);
               this.diskIconBitmap = _loc4_;
            }
         }
      }
      
      public function set playButtonState(param1:int) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == 0)
         {
            _loc2_ = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("icon_play") as BitmapDataAsset;
         }
         else if(param1 == 1)
         {
            _loc2_ = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("icon_pause") as BitmapDataAsset;
         }
         else if(param1 == 2)
         {
            _loc2_ = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName("icon_download") as BitmapDataAsset;
         }
         if(_loc2_ != null)
         {
            if(_loc2_.content != null)
            {
               this.buttonPlayPauseBitmap = _loc2_.content as BitmapData;
            }
         }
         _playButtonState = param1;
      }
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function set diskIconBitmap(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperController = _window.getChildByName("disk_image") as IBitmapWrapperController;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = param1;
         }
      }
      
      private function set buttonToPlaylistBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_to_playlist","image_button_to_playlist",param1);
      }
      
      private function set buttonPlayPauseBitmap(param1:BitmapData) : void
      {
         assignBitmapDataToButton("button_play_pause","image_button_play_pause",param1);
      }
      
      private function assignBitmapDataToButton(param1:String, param2:String, param3:BitmapData) : void
      {
         if(param3 == null)
         {
            return;
         }
         var _loc4_:IWindowController_1 = _window.getChildByName("action_buttons") as IWindowController_1;
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_ = _loc4_.getChildByName(param1) as IWindowController_1;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperController = _loc4_.getChildByName(param2) as IBitmapWrapperController;
         if(_loc5_ != null)
         {
            _loc5_.bitmap = param3.clone();
            _loc5_.width = param3.width;
            _loc5_.height = param3.height;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperController) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset = UnknownVarFromMusicInventoryGridItem_PlayListEditorWidget_1.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
   }
}

