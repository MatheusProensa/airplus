package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.sound.ISongInfo;
   
   public class TraxPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromTraxPreviewCatalogWidget_Int_1:int = -1;
      
      public function TraxPreviewCatalogWidget(param1:IWindowController_1, param2:IHabboSoundManagerFlash10)
      {
         super(param1);
         UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1 = _window.findChildByName("listen") as UnknownICoreWindowComponents4;
         Logger.log("Trax listener found button: " + UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1);
         if(UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",onClickPlay);
            UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1.disable();
         }
         _soundManager = param2;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1.removeEventListener("WME_CLICK",onClickPlay);
         }
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
            _soundManager = null;
         }
         super.dispose();
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
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc2_:IProduct = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            UnknownVarFromTraxPreviewCatalogWidget_Int_1 = parseInt(_loc2_.extraParam);
            _loc3_ = true;
         }
         if(UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            if(_loc3_)
            {
               UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1.enable();
            }
            else
            {
               UnknownVarFromTraxPreviewCatalogWidget_UnknownICoreWindowComponents4_1.disable();
            }
         }
      }
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(UnknownVarFromTraxPreviewCatalogWidget_Int_1,3,15,40,0,2);
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
   }
}

