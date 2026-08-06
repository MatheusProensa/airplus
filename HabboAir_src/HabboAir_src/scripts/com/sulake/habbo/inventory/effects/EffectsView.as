package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   import com.sulake.habbo.inventory.common.ThumbListManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class EffectsView implements IInventoryView
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromEffectsView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromEffectsView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromEffectsView_EffectsModel_1:EffectsModel;
      
      private var UnknownVarFromEffectsView_ThumbListManager_1:ThumbListManager;
      
      private var UnknownVarFromEffectsView_ThumbListManager_2:ThumbListManager;
      
      private var _disposed:Boolean = false;
      
      public function EffectsView(param1:EffectsModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IThumbListDataProvider, param6:IThumbListDataProvider)
      {
         super();
         UnknownVarFromEffectsView_EffectsModel_1 = param1;
         UnknownVarFromEffectsView_IAssetLibraryCollection_1 = param3;
         _windowManager = param2;
         var _loc9_:ISoundAsset = UnknownVarFromEffectsView_IAssetLibraryCollection_1.getAssetByName("inventory_effects_xml");
         var _loc7_:XmlAsset = XmlAsset(_loc9_);
         UnknownVarFromEffectsView_IWindowController_1_1 = IWindowController_1(_windowManager.buildFromXML(XML(_loc7_.content)));
         UnknownVarFromEffectsView_IWindowController_1_1.visible = false;
         UnknownVarFromEffectsView_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromEffectsView_ThumbListManager_1 = new ThumbListManager(UnknownVarFromEffectsView_IAssetLibraryCollection_1,param5,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         UnknownVarFromEffectsView_ThumbListManager_2 = new ThumbListManager(UnknownVarFromEffectsView_IAssetLibraryCollection_1,param6,"thumb_bg_png","thumb_bg_selected_png",getActiveThumbListImageWidth(),getActiveThumbListImageHeight());
         var _loc10_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("active_items_image") as IBitmapWrapperController;
         _loc10_.procedure = activeThumbListEventProc;
         var _loc8_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("inactive_items_image") as IBitmapWrapperController;
         _loc8_.procedure = inactiveThumbListEventProc;
         UnknownVarFromEffectsView_IWindowController_1_1.procedure = windowEventProc;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            UnknownVarFromEffectsView_EffectsModel_1 = null;
            UnknownVarFromEffectsView_IWindowController_1_1 = null;
            if(UnknownVarFromEffectsView_ThumbListManager_1 != null)
            {
               UnknownVarFromEffectsView_ThumbListManager_1.dispose();
               UnknownVarFromEffectsView_ThumbListManager_1 = null;
            }
            if(UnknownVarFromEffectsView_ThumbListManager_2 != null)
            {
               UnknownVarFromEffectsView_ThumbListManager_2.dispose();
               UnknownVarFromEffectsView_ThumbListManager_2 = null;
            }
            _disposed = true;
         }
      }
      
      public function getActiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("active_items_image") as IBitmapWrapperController;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getActiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("active_items_image") as IBitmapWrapperController;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getInactiveThumbListImageWidth() : int
      {
         var _loc1_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("inactive_items_image") as IBitmapWrapperController;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.width;
      }
      
      public function getInactiveThumbListImageHeight() : int
      {
         var _loc1_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("inactive_items_image") as IBitmapWrapperController;
         if(_loc1_ == null)
         {
            return 0;
         }
         return _loc1_.height;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(UnknownVarFromEffectsView_IWindowController_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromEffectsView_IWindowController_1_1.disposed)
         {
            return null;
         }
         return UnknownVarFromEffectsView_IWindowController_1_1;
      }
      
      public function updateListViews() : void
      {
         if(UnknownVarFromEffectsView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromEffectsView_IWindowController_1_1.disposed)
         {
            return;
         }
         UnknownVarFromEffectsView_ThumbListManager_2.updateImageFromList();
         UnknownVarFromEffectsView_ThumbListManager_1.updateImageFromList();
         var _loc2_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("inactive_items_image") as IBitmapWrapperController;
         var _loc4_:BitmapData = UnknownVarFromEffectsView_ThumbListManager_2.getListImage();
         _loc2_.bitmap = _loc4_;
         _loc2_.width = _loc4_.width;
         _loc2_.height = _loc4_.height;
         _loc2_.invalidate();
         var _loc3_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("active_items_image") as IBitmapWrapperController;
         var _loc1_:BitmapData = UnknownVarFromEffectsView_ThumbListManager_1.getListImage();
         _loc3_.bitmap = _loc1_;
         _loc3_.width = _loc1_.width;
         _loc3_.height = _loc1_.height;
         _loc3_.invalidate();
      }
      
      public function updateActionView() : void
      {
         if(UnknownVarFromEffectsView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromEffectsView_IWindowController_1_1.disposed)
         {
            return;
         }
         var _loc2_:UnknownICoreWindowComponents4 = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("activateEffect_button") as UnknownICoreWindowComponents4;
         var _loc3_:ITextWindow = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("effectDescriptionText") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Effect = UnknownVarFromEffectsView_EffectsModel_1.getSelectedEffect(-1);
         if(_loc1_ == null)
         {
            _loc2_.disable();
            setEffectDescriptionImage(null);
            _loc3_.text = "${inventory.effects.defaultdescription}";
         }
         else if(_loc1_.isActive)
         {
            _loc2_.disable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.active}";
            _windowManager.registerLocalizationParameter("inventory.effects.active","timeleft",convertSecondsToTime(_loc1_.secondsLeft));
            _windowManager.registerLocalizationParameter("inventory.effects.active","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.active","itemcount",String(_loc1_.amountInInventory));
         }
         else
         {
            _loc2_.enable();
            setEffectDescriptionImage(_loc1_.iconImage);
            _loc3_.text = "${inventory.effects.inactive}";
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","duration",convertSecondsToTime(_loc1_.duration));
            _windowManager.registerLocalizationParameter("inventory.effects.inactive","itemcount",String(_loc1_.amountInInventory));
         }
      }
      
      private function setEffectDescriptionImage(param1:BitmapData) : void
      {
         if(UnknownVarFromEffectsView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromEffectsView_IWindowController_1_1.disposed)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = UnknownVarFromEffectsView_IWindowController_1_1.findChildByName("effectDescriptionImage") as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.bitmap == null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,false);
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,_loc3_.height);
         }
         var _loc2_:Point = new Point((_loc3_.width - param1.width) / 2,(_loc3_.height - param1.height) / 2);
         _loc3_.bitmap.copyPixels(param1,param1.rect,_loc2_,null,null,false);
         _loc3_.invalidate();
      }
      
      private function convertSecondsToTime(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 60 / 60);
         var _loc4_:int = Math.floor((param1 - _loc2_ * 60 * 60) / 60);
         var _loc3_:int = param1 - _loc2_ * 60 * 60 - _loc4_ * 60;
         var _loc5_:String = "";
         if(_loc2_ > 0)
         {
            _loc5_ = _loc2_ + ":";
         }
         _loc5_ = _loc4_ < 10 ? _loc5_ + "0" + _loc4_ : _loc5_ + _loc4_;
         _loc5_ = _loc5_ + ":";
         return _loc3_ < 10 ? _loc5_ + "0" + _loc3_ : _loc5_ + _loc3_;
      }
      
      private function activeThumbListEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc5_ = UnknownVarFromEffectsView_ThumbListManager_1.resolveIndexFromImageLocation(_loc3_);
            _loc4_ = UnknownVarFromEffectsView_EffectsModel_1.getItemInIndex(_loc5_,1);
            if(_loc4_ != null)
            {
               UnknownVarFromEffectsView_EffectsModel_1.toggleEffectSelected(_loc4_.type);
            }
         }
      }
      
      private function inactiveThumbListEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = new Point(WindowMouseEvent(param1).localX,WindowMouseEvent(param1).localY);
            _loc5_ = UnknownVarFromEffectsView_ThumbListManager_2.resolveIndexFromImageLocation(_loc3_);
            _loc4_ = UnknownVarFromEffectsView_EffectsModel_1.getItemInIndex(_loc5_,0);
            if(_loc4_ != null)
            {
               UnknownVarFromEffectsView_EffectsModel_1.toggleEffectSelected(_loc4_.type);
            }
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:Effect = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "activateEffect_button")
            {
               _loc3_ = UnknownVarFromEffectsView_EffectsModel_1.getSelectedEffect(0);
               if(_loc3_ != null)
               {
                  UnknownVarFromEffectsView_EffectsModel_1.requestEffectActivated(_loc3_.type);
               }
            }
         }
      }
   }
}

