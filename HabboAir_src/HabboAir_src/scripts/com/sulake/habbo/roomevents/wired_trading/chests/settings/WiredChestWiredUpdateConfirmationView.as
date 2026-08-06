package com.sulake.habbo.roomevents.wired_trading.chests.settings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class WiredChestWiredUpdateConfirmationView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWiredChestWiredUpdateConfirmationView_ChestSettingsUI_1:ChestSettingsUI;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _chestId:int;
      
      private var _chestType:int;
      
      private var _chestItemType:int;
      
      private var UnknownVarFromWiredChestWiredUpdateConfirmationView_Boolean_1:Boolean;
      
      public function WiredChestWiredUpdateConfirmationView(param1:ChestSettingsUI)
      {
         super();
         UnknownVarFromWiredChestWiredUpdateConfirmationView_ChestSettingsUI_1 = param1;
         _windowManager = param1.chestController.windowManager;
         _window = _windowManager.buildFromXML(XML(param1.chestController.assets.getAssetByName("chest_wired_upgrade_xml").content),1) as IWindowController_1;
         _window.enableLookupCache();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         cancelButton.addEventListener("WME_CLICK",onWindowClose);
         buyButton.addEventListener("WME_CLICK",onBuyClicked);
      }
      
      private function onBuyClicked(param1:WindowMouseEvent) : void
      {
         buyButton.disable();
         UnknownVarFromWiredChestWiredUpdateConfirmationView_ChestSettingsUI_1.confirmUpgrade();
      }
      
      public function initialize(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         _chestId = param1;
         _chestType = param2;
         _chestItemType = param3;
         UnknownVarFromWiredChestWiredUpdateConfirmationView_Boolean_1 = param4;
         updateUI();
      }
      
      private function updateUI() : void
      {
         buyButton.enable();
         cancelButton.enable();
         var _loc1_:WiredChestController = UnknownVarFromWiredChestWiredUpdateConfirmationView_ChestSettingsUI_1.chestController;
         var _loc3_:UnknownHabboRoom1 = _loc1_.roomEngine.getFurnitureImage(_chestItemType,new Vector3d(90,0,0),64,this);
         if(_loc3_.data)
         {
            showChestPreview(_loc3_.data);
         }
         var _loc2_:String = null;
         if(UnknownVarFromWiredChestWiredUpdateConfirmationView_Boolean_1)
         {
            _loc2_ = "wiredchests.upgrade.wired.error.reason.rookie_chest";
         }
         errorText.visible = _loc2_ != null;
         if(_loc2_ != null)
         {
            buyButton.disable();
            errorText.text = _loc1_.localization.getLocalizationWithParams("wiredchests.upgrade.wired.error","","reason",_loc1_.localization.getLocalization(_loc2_));
         }
      }
      
      private function showChestPreview(param1:BitmapData) : void
      {
         productImage.bitmap = param1;
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.center();
         _window.activate();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         showChestPreview(param2);
      }
      
      public function imageFailed(param1:int) : void
      {
         showChestPreview(null);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _windowManager = null;
         UnknownVarFromWiredChestWiredUpdateConfirmationView_ChestSettingsUI_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      public function get productImage() : IBitmapWrapperController
      {
         return _window.findChildByName("product_image") as IBitmapWrapperController;
      }
      
      public function get productNameText() : ITextWindow
      {
         return _window.findChildByName("product_name") as ITextWindow;
      }
      
      public function get errorText() : ITextWindow
      {
         return _window.findChildByName("error_text") as ITextWindow;
      }
      
      public function get cancelButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("cancel_button") as UnknownICoreWindowComponents4;
      }
      
      public function get buyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("buy_button") as UnknownICoreWindowComponents4;
      }
   }
}

