package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.OfficialSongIdMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetOfficialSongIdMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   
   public class SongDiskProductViewCatalogWidget extends ProductViewCatalogWidget
   {
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1:IConnection;
      
      private var _playPreviewContainer:IWindowController_1;
      
      private var UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromSongDiskProductViewCatalogWidget_Int_1:int = -1;
      
      private var _officialSongId:String = "";
      
      private var UnknownVarFromSongDiskProductViewCatalogWidget_String_1:String = "";
      
      private var _officialSongIdListener:IMessageEvent = null;
      
      public function SongDiskProductViewCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1,param2);
         UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1 = _window.findChildByName("listen") as UnknownICoreWindowComponents4;
         UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1 = _window.findChildByName("ctlg_song_length");
         if(UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",onClickPlay);
            UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1.disable();
         }
         _playPreviewContainer = _window.findChildByName("playPreviewContainer") as IWindowController_1;
         if(_playPreviewContainer != null)
         {
            _playPreviewContainer.visible = false;
         }
         _soundManager = param2.soundManager;
         if(_soundManager != null)
         {
            _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         }
         UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1 = param2.connection;
         if(UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1 && !_officialSongIdListener)
         {
            _officialSongIdListener = new OfficialSongIdMessageEvent(onOfficialSongIdMessageEvent);
            UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1.addMessageEvent(_officialSongIdListener);
         }
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1.removeEventListener("WME_CLICK",onClickPlay);
         }
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
            if(_soundManager.events != null)
            {
               _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            _soundManager = null;
            if(UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1 && _officialSongIdListener)
            {
               UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1.removeMessageEvent(_officialSongIdListener);
               _officialSongIdListener = null;
            }
            UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1 = null;
         }
         super.dispose();
      }
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(page.offers.length == 0)
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(UnknownVarFromSongDiskProductViewCatalogWidget_Int_1,3,15,40,0.5,2);
         }
      }
      
      private function forceNoFadeoutOnPlayingSong(param1:int) : void
      {
         var _loc2_:ISongInfo = null;
         var _loc3_:int = _soundManager.musicController.getSongIdPlayingAtPriority(param1);
         if(_loc3_ != -1)
         {
            _loc2_ = _soundManager.musicController.getSongInfo(_loc3_);
            if(_loc2_.soundObject != null)
            {
               _loc2_.soundObject.fadeOutSeconds = 0;
            }
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc2_:IProduct = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_Int_1 = parseInt(_loc2_.extraParam);
            if(UnknownVarFromSongDiskProductViewCatalogWidget_Int_1 == 0)
            {
               _officialSongId = _loc2_.extraParam;
               if(UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1)
               {
                  UnknownVarFromSongDiskProductViewCatalogWidget_IConnection_1.send(new GetOfficialSongIdMessageComposer(_officialSongId));
               }
            }
            if(_playPreviewContainer != null)
            {
               _playPreviewContainer.visible = true;
            }
         }
         else
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_Int_1 = -1;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc6_:String = null;
         var _loc3_:IHabboLocalizationManager = null;
         var _loc7_:String = null;
         var _loc2_:Boolean = false;
         var _loc5_:int = getSongLength();
         if(_loc5_ >= 0)
         {
            _loc1_ = _loc5_ / 60;
            _loc4_ = _loc5_ % 60;
            _loc8_ = "" + _loc1_;
            _loc6_ = "" + _loc4_;
            if(_loc4_ < 10)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc3_ = (page.viewer.catalog as HabboCatalog).localization;
            _loc3_.registerParameter("catalog.song.length","min",_loc8_);
            _loc7_ = _loc3_.registerParameter("catalog.song.length","sec",_loc6_);
            _loc2_ = true;
            if(UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1 != null)
            {
               UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1.caption = _loc7_;
            }
         }
         else if(UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1 != null)
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_IWindowModel_1.caption = "";
         }
         if(UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            if(_loc2_)
            {
               UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1.enable();
            }
            else
            {
               UnknownVarFromSongDiskProductViewCatalogWidget_UnknownICoreWindowComponents4_1.disable();
            }
         }
      }
      
      private function getSongLength() : int
      {
         var _loc1_:ISongInfo = null;
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _loc1_ = _soundManager.musicController.getSongInfo(UnknownVarFromSongDiskProductViewCatalogWidget_Int_1);
            if(_loc1_ != null)
            {
               return _loc1_.length / 1000;
            }
            _soundManager.musicController.requestSongInfoWithoutSamples(UnknownVarFromSongDiskProductViewCatalogWidget_Int_1);
         }
         return -1;
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(param1.id == UnknownVarFromSongDiskProductViewCatalogWidget_Int_1)
         {
            updateView();
         }
      }
      
      private function onOfficialSongIdMessageEvent(param1:OfficialSongIdMessageEvent) : void
      {
         if(param1.getParser().officialSongId == _officialSongId)
         {
            UnknownVarFromSongDiskProductViewCatalogWidget_Int_1 = param1.getParser().songId;
            updateView();
         }
      }
   }
}

